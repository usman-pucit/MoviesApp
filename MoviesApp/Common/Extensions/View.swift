//
//  View.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 17/03/2023.
//

import SwiftUI

struct AlertState: Equatable {
    let title: String
    let message: String
}

extension View {
    func errorAlertState(state: Binding<AlertState?>) -> some View {
        alert(isPresented: .constant(state.wrappedValue != nil)) {
            let cancelAction = {
                state.wrappedValue = nil
            }

            guard let title = state.wrappedValue?.title.localized, let message = state.wrappedValue?.message.localized else {
                return .init(title: Text(""), message: Text("something went wrong."), dismissButton: .cancel(cancelAction))
            }

            return Alert(title: Text(title), message: Text(message), dismissButton: .cancel(cancelAction))
        }
    }
}
