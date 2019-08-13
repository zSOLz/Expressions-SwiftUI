//
//  ExpressionToken.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/13/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import Foundation

struct ExpressionToken {
    enum TokenType: Hashable {
        case end
        
        case number(Double)
        case variable(String)
        
        case plus
        case minus
        case multiply
        case divide
        
        case leftBracket
        case rightBracket
    }
    
    var type: TokenType
    var range: ClosedRange<Int>
}

extension ExpressionToken.TokenType {
    var isBinary: Bool {
        return (self == .plus ||
                self == .minus ||
                self == .multiply ||
                self == .divide)
        // self == .pow
    }
    
    var isPostfix: Bool {
        return false
        //return (t == EXTokenFact ||
        //        t == EXTokenExpression ||
        //        t == EXTokenCurrency);
    }
    
    var isPrefix: Bool {
        return false
        //return (t == EXTokenSin ||
        //        t == EXTokenCos ||
        //        t == EXTokenTg ||
        //        t == EXTokenCtg ||
        //        t == EXTokenLg ||
        //        t == EXTokenLog2 ||
        //        t == EXTokenLn ||
        //        t == EXTokenAsin ||
        //        t == EXTokenAcos ||
        //        t == EXTokenAtg ||
        //        t == EXTokenSqrt2 ||
        //        t == EXTokenSqrt3 ||
        //        t == EXTokenSqrt4);
    }
    
    var isRightBracket: Bool {
        return self == .rightBracket
        // self == EXTokenRAbs;
    }
}
