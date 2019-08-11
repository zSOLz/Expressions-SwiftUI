//
//  NumbersAndOperatorsView.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/10/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI

struct NumbersAndOperatorsView: View {
    @EnvironmentObject var appStyle: AppStyle
    let viewModel: ExpressionsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                GeneralButton(tapAction: { self.viewModel.clear() }, label: { Text("C") })
                    .foregroundColor(appStyle.errorColor)
                AddSymbolButton("(")
                AddSymbolButton(")")
                AddSymbolButton("÷")
            }
            HStack(spacing: 0) {
                AddSymbolButton("7")
                AddSymbolButton("8")
                AddSymbolButton("9")
                AddSymbolButton("×")
            }
            HStack(spacing: 0) {
                AddSymbolButton("4")
                AddSymbolButton("5")
                AddSymbolButton("6")
                AddSymbolButton("−")
            }
            HStack(spacing: 0) {
                AddSymbolButton("1")
                AddSymbolButton("2")
                AddSymbolButton("3")
                AddSymbolButton("+")
            }
            HStack(spacing: 0) {
                AddSymbolButton("0")
                GeneralButton { Text("") }
                AddSymbolButton(",")
                GeneralButton { Text("=") }
            }
        }
        .accentColor(appStyle.mainColor)
        .font(Font.largeTitle.weight(.thin))
    }
    
    func AddSymbolButton(_ text: String) -> GeneralButton<Text> {
        GeneralButton(tapAction: { self.viewModel.append(text: text) },
                      label: { Text(text)})
    }
}

#if DEBUG
struct NumbersAndOperatorsView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersAndOperatorsView(viewModel: .preview)
            .previewLayout(.fixed(width: 320, height: 320))
            .environmentObject(AppStyle())
    }
}
#endif
