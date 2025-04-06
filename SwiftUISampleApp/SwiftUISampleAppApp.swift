//
//  SwiftUISampleAppApp.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 15/01/25.
//

import SwiftUI

@main
struct SwiftUISampleAppApp: App {
    @State private var landmarkViewModel = LandmarkViewModel()
    @State private var hikeViewModel = HikeViewModel(repository: HikeLocalRepository())
    @State private var profileViewModel = ProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(landmarkViewModel)
                .environment(hikeViewModel)
                .environment(profileViewModel)
        }
    }
}
