//
//  Button + Design System.swift
//  Bent
//
//  Created by Northstar✨System on 2023-05-19.
//

import SwiftUI



// MARK: - Big Borderd Prominent

/// Styles a button as a large rectangle with rounded corners and a background which makes it visually prominent
struct BigBorderedProminentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ButtonProxy(configuration: configuration)
    }
    
    
    struct ButtonProxy: View {
        
        let configuration: ButtonStyle.Configuration
        
        @Environment(\.isEnabled)
        private var isEnabled: Bool
        
        var body: some View {
            configuration.label
                .opacity(configuration.isPressed ? 0.8 : 1)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .padding(14)
                .background {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.accentColor)
                }
                .opacity(isEnabled ? 1 : 0.6)
        }
    }
}



extension ButtonStyle where Self == BigBorderedProminentButtonStyle {
    /// Styles the button as a large rectangle with rounded corners and a background which makes it visually prominent
    static var bigBorderedProminent: Self { .init() }
}



// MARK: - Big Borderless

/// Styles a button as a large transparent touch target
struct BigBorderlessButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.medium)
            .foregroundColor(.accentColor)
            .controlSize(.large)
            .frame(maxWidth: .infinity)
            .padding(14)
    }
}



extension ButtonStyle where Self == BigBorderlessButtonStyle {
    /// Styles the button as a large transparent touch target
    static var bigBorderless: Self { .init() }
}



struct DesignSystem_ButtonStyles_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("Sign up", action: {})
                .buttonStyle(.bigBorderedProminent)
            
            Button("Log in", action: {})
                .buttonStyle(.bigBorderless)
        }
    }
}

