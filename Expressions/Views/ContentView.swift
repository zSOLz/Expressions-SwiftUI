//
//  ContentView.swift
//  SwUITest1
//
//  Created by Andrei Salavei on 8/6/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appStyle: AppStyle
    @ObservedObject var viewModel: ExpressionsViewModel

    var body: some View {
        VStack(spacing: 0) {
            ExpressionsView(viewModel: viewModel)
                .font(Font.largeTitle.weight(.thin))
                .padding([.top])
            Spacer()
                .frame(maxHeight: .infinity)
            NumbersAndOperatorsView(viewModel: viewModel)
                .padding()
                .frame(maxHeight: 450)
        }
        .accentColor(appStyle.mainColor)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .preview)
            .environmentObject(AppStyle())
    }
}
#endif