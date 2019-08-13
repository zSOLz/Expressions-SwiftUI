//
//  ExpressionsViewModel.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/10/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI
import Combine

class ExpressionsViewModel: ObservableObject {
    private let expressionCalculator = ExpressionCalculator()
    
    private var expressions = [ExpressionState.initial]
    private var currentIndex = 0
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    var errorText: String?
    var currentExpression: ExpressionState {
        return expressions[currentIndex]
    }
    
    func append(text: String) {
        var newExpression = currentExpression
        newExpression.characters.append(text)
        expressions.append(newExpression)
        currentIndex += 1
        errorText = nil
        objectWillChange.send()
    }
    
    func clear() {
        expressions.append(.initial)
        currentIndex += 1
        errorText = nil
        objectWillChange.send()
    }
    
    func calculate() {
        let tokens = CharactersParser.parse(characters: currentExpression.characters.map { String($0) })
        switch expressionCalculator.calculate(tokens: tokens) {
        case let .success(result):
            let characters = String(result)
            expressions.append(ExpressionState(characters: String(characters),
                                               selection: characters.count...characters.count))
            currentIndex += 1
            objectWillChange.send()
            
        case let .failure(.general(message, range)):
            errorText = "\(message) : \(range)"
            objectWillChange.send()
        }
    }
}

extension ExpressionsViewModel {
    static let preview: ExpressionsViewModel = {
        let viewModel = ExpressionsViewModel()
        viewModel.expressions = [ExpressionState.initial,
                                 ExpressionState(characters: "(123+456)×0.1",
                                                 selection: 0...0)]
        viewModel.currentIndex = 1
        return viewModel
    }()
}
