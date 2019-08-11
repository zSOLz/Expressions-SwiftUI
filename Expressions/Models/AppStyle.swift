//
//  AppStyle.swift
//  SwUITest1
//
//  Created by Andrei Salavei on 8/9/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI
import Combine

class AppStyle: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    var mainColor: Color { didSet { objectWillChange.send() } }
    var backgroundColor: Color { didSet { objectWillChange.send() } }
    var errorColor: Color { didSet { objectWillChange.send() } }

    init() {
        mainColor = .blue
        backgroundColor = .white
        errorColor = .red
    }
}
