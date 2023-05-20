//
//  InviteCodeScreen.swift
//  Bent
//
//  Created by Northstar✨System on 2023-05-19.
//

import SwiftUI

struct InviteCodeScreen: View {
    
    @Binding
    var progress: OnboardingProgress
    
    @State
    private var draftInviteCode: String
    
    @State
    private var inviteCodeIsValid = false
    
    @FocusState
    private var focusTextField: Bool
    
    
    init(progress: Binding<OnboardingProgress>) {
        self._progress = progress
        self._draftInviteCode = .init(initialValue: progress.wrappedValue.inviteCode ?? "")
        
        self.progress.userManuallySelectedScreen = .communitySelection
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Enter your invite code")
                .font(.DesignSystem.bigTitle)
            
            Spacer(minLength: 24)
                .fixedSize()
            
            Text("\(Branding.brandName) requires an invitation from an existing community to get started.")
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 24)
                .fixedSize()
            
            TextField("Invite code",
                      text: $draftInviteCode,
                      prompt: Text("Enter your invite code..."))
                .textFieldStyle(.roundedFilled)
                .onSubmit(submit)
                .onChange(of: draftInviteCode) { inviteCode in
                    // TODO: Actual validation
                    inviteCodeIsValid = !inviteCode.isEmpty
                }
                .focused($focusTextField)
                .onAppear {
                    focusTextField = true
                }
            
            Spacer(minLength: 12)
                .fixedSize()
            
            signupCta
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button("Next", action: submit)
            .buttonStyle(.bigBorderedProminent)
            .disabled(!inviteCodeIsValid)
        }
        .padding(16)
    }
    
    
    func submit() {
        progress.inviteCode = draftInviteCode
        progress.userManuallySelectedScreen = .communitySelection
    }
}



private extension InviteCodeScreen {
    var signupCta: Text {
        let base: Text
        
        do {
            base = Text(try AttributedString(markdown: "No invite? You can [sign up to be notified](https://help.getbent.app/hc/en-us/articles/12520679769883-How-do-I-find-groups-to-join-on-Bent-) when \(Branding.brandName) expands Community discovery in the future."))
        }
        catch {
            base = Text("No invite? You can sign up to be notified when \(Branding.brandName) expands Community discovery in the future: https://help.getbent.app/hc/en-us/articles/12520679769883-How-do-I-find-groups-to-join-on-Bent-")
        }
        
        return base
            .font(.footnote)
    }
}



struct InviteCodeScreen_Previews: PreviewProvider {
    static var previews: some View {
        InviteCodeScreen(progress: .constant(.init(userManuallySelectedScreen: .inviteCode)))
        InviteCodeScreen(progress: .constant(.init(userManuallySelectedScreen: .inviteCode, inviteCode: "GilbertBaker")))
    }
}
