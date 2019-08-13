//
//  Parser.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/13/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import Foundation

private let digits = Set<String>("0123456789".map { String($0) })
private let points = Set<String>([",", "."])

class CharactersParser {
    static func parse(characters: [String]) -> [ExpressionToken] {
        var tokens: [ExpressionToken] = []
        var index: Int = 0
        
        while index < characters.count {
            let tokenStart = index
            if digits.contains(characters[index]) || points.contains(characters[index]) {
                var value: Double = 0
                var dividor: Double = 1
                var decimal: Double = 0
                // var exponentPositive = false
                // var exponentValue: Double = 0
                
                while index < characters.count, digits.contains(characters[index]), let characterValue = Double(characters[index]) {
                    value *= 10
                    value += characterValue
                    index += 1
                }
                
                if index < characters.count, points.contains(characters[index]) {
                    index += 1
                    while index < characters.count, digits.contains(characters[index]), let characterValue = Double(characters[index]) {
                        decimal *= 10
                        decimal += characterValue
                        dividor *= 10
                        index += 1
                    }
                }
                
                let numberValue = value + decimal / dividor
                tokens.append(ExpressionToken(type: .number(numberValue), range: tokenStart...index))
            } else {
                let tokenType: ExpressionToken.TokenType
                switch characters[index] {
                case "(": tokenType = .leftBracket
                case ")": tokenType = .rightBracket
                case "+": tokenType = .plus
                case "-", "−": tokenType = .minus
                case "*", "×": tokenType = .multiply
                case "/", "÷": tokenType = .divide
                default: tokenType = .variable(characters[index])
                }
                tokens.append(ExpressionToken(type: tokenType, range: tokenStart...index))
                index += 1
            }
        }
        tokens.append(ExpressionToken(type: .end, range: index...index))
        return tokens
    }
}
