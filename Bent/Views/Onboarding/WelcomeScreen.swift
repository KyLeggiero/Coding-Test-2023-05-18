//
//  WelcomeScreen.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-19.
//

import SwiftUI

extension OnboardingSectionView {
    struct WelcomeScreen: View {
        
        @Binding
        var progress: OnboardingProgress
        
//        /// Called when this screen has been completed by the user, and it is time to move on to another screen in this section of the app
//        let onScreenComplete: () -> Void
        
        /// Called when this entire section has been completed by the user, and it is time to move on to another section of the app
        let onSectionComplete: () -> Void
        
        
        var body: some View {
            VStack(spacing: 0) {
                Spacer(minLength: 77)
                    .fixedSize()
                
                Text(Branding.brandName)
                    .font(.DesignSystem.bigTitle)
                
                Spacer(minLength: 65)
                    .fixedSize()
                
                Text("Find Your Queer Communities")
                    .font(.DesignSystem.tagline)
                
                Spacer()
                
                legalDisclaimer
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: 302)
                
                Spacer(minLength: 24)
                    .fixedSize()
                
//                Button("Sign up") {
//                    progress.userManuallySelectedScreen = .inviteCode
//                }
                Button("Sign up", action: {
                    var next = OnboardingScreen.inviteCode
                    progress.userManuallySelectedScreen = next
                })
                    .buttonStyle(.bigBorderedProminent)
                
                Spacer(minLength: 6)
                    .fixedSize()
                
                Button("Log in", action: onSectionComplete)
                    .buttonStyle(.bigBorderless)
            }
            .padding(.horizontal, 24)
        }
    }
}

private extension OnboardingSectionView.WelcomeScreen {
    var legalDisclaimer: Text {
        
        do {
            // TODO: Style the links correctly
            return Text(try AttributedString(markdown: """
                By signing up, I agree I’m 18 or older, and to the [Terms of Use](https://www.getbent.app/terms-of-service) & [Privacy Policy](https://www.getbent.app/privacy-policy)
                """))
            .font(.footnote)
        }
        catch {
            return Text("By signing up, I agree I’m 18 or older, and to the Terms of Use (https://www.getbent.app/terms-of-service) & Privacy Policy (https://www.getbent.app/privacy-policy")
                .font(.footnote)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSectionView.WelcomeScreen(progress: .constant(.fresh),
//                                            onScreenComplete: {},
                                            onSectionComplete: {})
    }
}
