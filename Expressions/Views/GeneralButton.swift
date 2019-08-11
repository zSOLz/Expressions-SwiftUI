//
//  GeneralButton.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/10/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI

struct GeneralButton<Label: View>: View {
    enum TapAnimationStage {
        case start
        case end
    }
    private let tapAction: (() -> Void)?
    private let holdAction: (() -> Void)?
    private let innerContent: Label
    @State private var animationStage: TapAnimationStage = .end
    
    init(tapAction: (() -> Void)? = nil,
         holdAction: (() -> Void)? = nil,
         @ViewBuilder label: () -> Label) {
        self.innerContent = label()
        self.tapAction = tapAction
        self.holdAction = holdAction
    }
    
    var body: some View {
        ZStack {
            innerContent.frame(minWidth: 0, maxWidth: .infinity,
                               minHeight: 0, maxHeight: .infinity,
                               alignment: .center)
            Circle()
                .scale(animationStage.scale)
                .opacity(animationStage.opacity)
        }
        .onTapGesture {
            self.tapAction?()
            self.animationStage = .start
            withAnimation { self.animationStage = .end }
        }
        .onLongPressGesture {
            self.tapAction?()
            self.animationStage = .start
            withAnimation { self.animationStage = .end }
        }
    }
}

private extension GeneralButton.TapAnimationStage {
    var scale: CGFloat {
        switch self {
        case .start: return 0.5
        case .end: return 1.5
        }
    }
    
    var opacity: Double {
        switch self {
        case .start: return 0.5
        case .end: return 0
        }
    }
}

#if DEBUG
struct GeneralButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GeneralButton { Text("5") }
            GeneralButton { Text("+") }
        }
        .previewLayout(.fixed(width: 100, height: 100))
        .font(Font.largeTitle.weight(.thin))
    }
}
#endif
