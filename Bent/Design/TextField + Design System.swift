//
//  TextField + Design System.swift
//  Bent
//
//  Created by Northstar✨System on 2023-05-19.
//

import SwiftUI



/// Styles a text field as a large rectangle with rounded corners and a background which differentiates it
struct RoundedFilledTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(16)
            .background(.regularMaterial)
            .cornerRadius(12)
    }
}



extension TextFieldStyle where Self == RoundedFilledTextFieldStyle {
    /// Styles the text field as a large rectangle with rounded corners and a background which differentiates it
    static var roundedFilled: Self { .init() }
}



struct RoundedFilledTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Invite code", text: .constant(""), prompt: Text("Enter your invite code..."))
            .textFieldStyle(.roundedFilled)
    }
}
