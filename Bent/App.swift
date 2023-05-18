//
//  App.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import SwiftUI

@main
struct App: SwiftUI.App {
    
    @EnvironmentObject
    private var serializationManager: SerializationManager<TopLevelSerializationKeys>
    
    var body: some Scene {
        WindowGroup {
            ContentView(appSection: .init(
                get: {
                    (try? resync {
                        await serializationManager[.appSection]
                    })
                    ?? .onboarding(progress: .fresh)
                },
                set: { newValue in
                    Task {
                        serializationManager[.appSection] = newValue
                    }
                }
            ))
        }
    }
}
