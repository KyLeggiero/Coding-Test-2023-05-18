//
//  ContentView.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import SwiftUI

struct ContentView: View {
    
    @Binding
    var appSection: AppSection
    
    var body: some View {
        switch appSection {
        case .onboarding(let progress):
            OnboardingSectionView(
                progress: .init(
                    get: { progress },
                    set: { appSection = .onboarding(progress: $0) } ),
                onSectionComplete: {
                    appSection = .thankYouForYourConsideration
                }
            )
            
        case .thankYouForYourConsideration:
            ThankYouForYourConsideration(onReset: { appSection = .default })
                .transition(.move(edge: .trailing).animation(.default))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appSection: .constant(.onboarding(progress: .fresh)))
        ContentView(appSection: .constant(.onboarding(progress: .init(
            userManuallySelectedScreen: .addProfilePic,
            inviteCode: "123ABC",
            selectedCommunityId: .init(),
            userProfile: .init(id: UUID(), name: "Ky", phoneNubmerIsVerified: false),
            verificationImage: nil)))
        )
    }
}
