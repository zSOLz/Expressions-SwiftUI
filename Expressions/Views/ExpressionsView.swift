//
//  ExpressionsView.swift
//  Expressions
//
//  Created by Andrei Salavei on 8/10/19.
//  Copyright © 2019 Andrei Salavei. All rights reserved.
//

import SwiftUI

struct ExpressionsView: View {
    @ObservedObject var viewModel: ExpressionsViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Spacer()
                Spacer()
                Text(viewModel.currentExpression.characters)
                Spacer()
                Spacer()
            }
        }
    }
}

#if DEBUG
struct ExpressionsView_Previews: PreviewProvider {
    static var previews: some View {
        ExpressionsView(viewModel: ExpressionsViewModel.preview)
    }
}
#endif
