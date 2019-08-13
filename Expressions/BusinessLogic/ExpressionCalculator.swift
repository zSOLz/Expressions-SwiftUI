//
//  Calculator.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/13/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import Foundation

enum ExpressionError: Error {
    case general(message: String, range: ClosedRange<Int>)
}

class ExpressionCalculator {
    var variables: [String: Double] = [:]
    
    func calculate(tokens: [ExpressionToken]) -> Result<Double, ExpressionError> {
        if let error = checkBraces(tokens: tokens) {
            return .failure(error)
        }
        let calculator = Calculator(variables: variables, tokens: tokens)
        return calculator.calculate()
    }
    
    private class Calculator {
        private var variables: [String: Double]
        private var tokens: [ExpressionToken]
        private var currentIndex: Int = 0
        private var currentToken: ExpressionToken
        
        init(variables: [String: Double], tokens: [ExpressionToken]) {
            self.variables = variables
            self.tokens = tokens
            self.currentToken = tokens[0]
        }
        
        func calculate() -> Result<Double, ExpressionError> {
            currentIndex = 0
            getNextToken()
            
            do {
                let result = try prior1(getToken: false)
                if abs(result - result.rounded()) < result.ulp * 2 {
                    return .success(result.rounded())
                } else {
                    return .success(result)
                }
            } catch {
                return .failure(error as! ExpressionError)
            }
        }
        
        @discardableResult
        private func getNextToken() -> ExpressionToken {
            currentToken = tokens[currentIndex]
            currentIndex += 1
            return currentToken
        }
        
        private func prior1(getToken: Bool) throws -> Double {
            var left = try prior2(getToken: getToken)
            while true {
                switch currentToken.type {
                case .plus:
                    left += try prior2(getToken: true)
                case .minus:
                    left -= try prior2(getToken: true)
                default:
                    return left;
                }
            }
        }
        
        private func prior2(getToken: Bool) throws -> Double {
            var left = try prior3(getToken: getToken)
            while true {
                switch currentToken.type {
                case .multiply:
                    left *= try prior3(getToken: true)
                case .divide:
                    let temp = try prior3(getToken: true)
                    if temp != 0 {
                        left /= temp;
                    } else {
                        throw ExpressionError.general(message: "Divide by '0'", range: currentToken.range)
                    }
                    break;
                default:
                    return left;
                }
            }
        }
        
        private func prior3(getToken: Bool) throws -> Double {
            // TODO: Handle items tokens:
            // Pow
            // Currency
            // Expression
            // Fact
            return try prior4(getToken: getToken)
        }
        
        private func prior4(getToken: Bool) throws -> Double {
            if getToken {
                getNextToken()
            }
            var previousTokenType = currentToken.type
            var result: Double = 0
            switch currentToken.type {
            case let .number(value):
                result = value
                getNextToken()
                
            case let .variable(key):
                guard let value = variables[key] else {
                    throw ExpressionError.general(message: "Unknown variable \(key)", range: currentToken.range)
                }
                result = value
                getNextToken()
                
            case .minus:
                result -= try prior4(getToken: true)
                
            case .leftBracket:
                result = try prior1(getToken: true)
                guard currentToken.type == .rightBracket else {
                    throw ExpressionError.general(message: "')' is missing", range: currentToken.range)
                }
                
                previousTokenType = .rightBracket
                getNextToken()
                
            case .end:
                throw ExpressionError.general(message: "Expression is missing", range: currentToken.range.upperBound...currentToken.range.upperBound)
                
            default:
                throw ExpressionError.general(message: "Expression is missing", range: currentToken.range.upperBound...currentToken.range.upperBound)
            }
            
            if (previousTokenType == .rightBracket && currentToken.type == .leftBracket) {
                return result * (try prior3(getToken: false))
            }
            
            if (!currentToken.type.isBinary &&
                !currentToken.type.isPostfix &&
                !currentToken.type.isRightBracket &&
                currentToken.type != .end) {
                throw ExpressionError.general(message: "Operator is missing", range: currentToken.range.upperBound...currentToken.range.upperBound)
            }
            
            return result
        }
    }
}

private extension ExpressionCalculator {
    func checkBraces(tokens: [ExpressionToken]) -> ExpressionError? {
        var braces: Int = 0
        for token in tokens {
            if token.type == .leftBracket {
                braces += 1
            } else if token.type == .rightBracket {
                braces -= 1
            }
            
            if (braces < 0) {
                return .general(message: "'(' is missing", range: 0...0)
            }
        }
        if braces != 0, let lastTokenEnd = tokens.last?.range.upperBound {
            return .general(message: "')' is missing", range: lastTokenEnd...lastTokenEnd)
        }
        return nil
    }
}
