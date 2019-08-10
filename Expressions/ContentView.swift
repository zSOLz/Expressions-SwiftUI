//
//  ContentView.swift
//  SwUITest1
//
//  Created by Andrei Salavei on 8/6/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var colorScheme: ColorScheme
    
    var body: some View {
        VStack {
            HStack {
                ContentButton(title: "7", action: {})
                ContentButton(title: "8", action: {})
                ContentButton(title: "9", action: {})
            }
            HStack {
                ContentButton(title: "4", action: {})
                ContentButton(title: "5", action: {})
                ContentButton(title: "6", action: {})
            }
            HStack {
                ContentButton(title: "1", action: {})
                ContentButton(title: "2", action: {})
                ContentButton(title: "3", action: {})
            }
        }
        .accentColor(colorScheme.mainColor)
    }
}

struct ContentButton: View {
    enum AnimationStage {
        case initial
        case fadeOut
    }
    let title: String
    let action: () -> Void
    @State var animationStage: AnimationStage = .fadeOut

    var body: some View {
        Button(action: {
            self.action()
            self.animationStage = .initial
            withAnimation { self.animationStage = .fadeOut }
        }) {
            ZStack {
                Text(title)
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 0, maxHeight: .infinity,
                           alignment: .center)
                Circle()
                    .scale(animationStage.scale)
                    .opacity(animationStage.opacity)
            }
        }.font(.largeTitle)
    }
}

extension ContentButton.AnimationStage {
    var scale: CGFloat {
        switch self {
        case .initial: return 0.2
        case .fadeOut: return 1.5
        }
    }
    
    var opacity: Double {
        switch self {
        case .initial: return 0.5
        case .fadeOut: return 0
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ColorScheme())
    }
}
#endif
