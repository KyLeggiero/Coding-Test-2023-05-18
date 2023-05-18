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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appSection: .constant(.onboarding(progress: .fresh)))
        ContentView(appSection: .constant(.onboarding(progress: .init(
            userManuallySelectedScreen: .addProfilePic,
            inviteCode: "123ABC",
            selectedCommunityId: .init(),
            userProfile: .init(id: UUID(), phoneNubmerIsVerified: false),
            validationImage: nil)))
        )
    }
}
