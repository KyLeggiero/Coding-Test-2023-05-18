//
//  App.swift
//  Bent
//
//  Created by Ky Leggiero on 2023-05-18.
//

import SwiftUI

import SimpleLogging



@main
struct App: SwiftUI.App {
    
    @StateObject
    private var serializationManager = SerializationManager<TopLevelSerializationKeys>()
    
    @State
    private var appSection: AppSection = .default
    
    var body: some Scene {
        WindowGroup {
            ContentView(appSection: $appSection)
                .environmentObject(serializationManager)
                .task {
                    appSection = await serializationManager[.appSection, default: .default]
                }
                .onChange(of: appSection) { appSection in
                    Task {
                        do {
                            try await serializationManager.serialize(appSection, to: .appSection)
                        }
                        catch {
                            log(error: error)
                        }
                    }
                }
            
//            ContentView(appSection: .init(
//                get: {
//                    do {
//                        return try resync {
//                            await serializationManager[.appSection] ?? .onboarding(progress: .fresh)
//                        }
//                    }
//                    catch {
//                        log(error: error)
//                        return .onboarding(progress: .fresh)
//                    }
//                },
//
//                set: { newValue in
//                    Task {
//                        do {
//                            try await serializationManager.serialize(newValue, to: .appSection)
//                        }
//                        catch {
//                            log(error: error)
//                        }
//                    }
//                }
//            ))
        }
    }
}
