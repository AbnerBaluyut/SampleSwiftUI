//
//  ViewExt.swift
//  SwiftfulThinkingApp
//
//  Created by Abner Lawrence Baluyut on 12/2/24.
//

import SwiftUI

extension View {
    
    public func appBar(title: String, backButtonAction: @escaping() -> Void) -> some View {

        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                backButtonAction()
            }) {
                Image("ic-back") // set backbutton image here
                    .renderingMode(.template)
                    .foregroundColor(AppColors.darkGray)
            })
    }
}
