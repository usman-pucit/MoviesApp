//
//  LoadingView.swift
//  PlandayAssessment
//
//  Created by Muhammad Usman on 05/03/2023.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isLoading: Bool
    let content: () -> Content

    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isLoading)
                    .blur(radius: self.isLoading ? 3 : 0)

                ProgressView()
                    .tint(Color.systemTitleColor)
                    .opacity(self.isLoading ? 1 : 0)
            }
        }
    }
}
