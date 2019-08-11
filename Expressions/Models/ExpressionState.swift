//
//  Expression.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/10/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI

struct ExpressionState {
    var characters: String
    var selection: ClosedRange<Int>
    
    static var initial: ExpressionState {
        return ExpressionState(characters: "", selection: 0...0)
    }
}
