//
//  OnboardingSectionView.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-19.
//

import SwiftUI

struct OnboardingSectionView: View {
    
    @Binding
    var progress: OnboardingProgress
    
    /// Called when this section has been completed by the user, and it is time to move on to another section of the app
    let onSectionComplete: () -> Void
    
//    @State
//    private var navigationPath: NavigationPath
    
    @State
    private var currentScreen: OnboardingScreen
    
    
    init(progress: Binding<OnboardingProgress>, onSectionComplete: @escaping () -> Void) {
        self._progress = progress
        self.onSectionComplete = onSectionComplete
//        self._navigationPath = .init(initialValue: progress.wrappedValue.navigationPath)
        self._currentScreen = .init(initialValue: progress.wrappedValue.idealScreen ?? .welcome)
    }
    
    
    var body: some View {
//        NavigationStack(path: $navigationPath) { // TODO: Why doesn't this work?
        content
        .onChange(of: progress) { progress in
//            navigationPath = progress.navigationPath
            
            if let idealScreen = progress.idealScreen {
                currentScreen = idealScreen
            }
            else {
                onSectionComplete()
            }
        }
    }
    
    
    @ViewBuilder
    var content: some View {
        switch currentScreen {
        case .welcome:
            WelcomeScreen(
                progress: $progress,
//                    onScreenComplete: {
//                        progress.userManuallySelectedScreen = .inviteCode
//                        currentScreen = progress.idealScreen ?? .inviteCode
//                    },
                onSectionComplete: onSectionComplete)
            
        case .inviteCode:
            InviteCodeScreen(progress: $progress)
            
        case .communitySelection:
            EmptyView()
        case .createAccount:
            EmptyView()
        case .verifyPhone:
            EmptyView()
        case .createProfile:
            EmptyView()
        case .addProfilePic:
            EmptyView()
        case .verifyProfilePic:
            EmptyView()
        case .requestPermissions:
            EmptyView()
        }
    }
}

struct OnboardingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSectionView(progress: .constant(.fresh), onSectionComplete: {})
        OnboardingSectionView(progress: .constant(.init(
            userManuallySelectedScreen: .addProfilePic,
            inviteCode: "123ABC",
            selectedCommunityId: .init(),
            userProfile: .init(id: UUID(), name: "Ky", phoneNubmerIsVerified: false),
            verificationImage: nil)), onSectionComplete: {})
    }
}
