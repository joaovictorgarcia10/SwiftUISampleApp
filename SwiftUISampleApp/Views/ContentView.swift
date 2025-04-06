//
//  ContentView.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 15/01/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(LandmarkViewModel.self) var landmarkViewModel
    @Environment(HikeViewModel.self) var hikeViewModel
    @Environment(ProfileViewModel.self) var profileViewModel
    
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        if landmarkViewModel.landmarks == nil {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
        } else if landmarkViewModel.landmarks!.isEmpty {
            VStack {
                Text("No landmarks founded")
                Button {
                    landmarkViewModel.loadLandmarks()
                } label: {
                    Text("Try again")
                }
            }
        } else {
            TabView(selection: $selection) {
                CategoryHome()
                    .tag(Tab.featured)
                    .tabItem { Label("Featured", systemImage: "star") }
                
                LandmarkList()
                    .tag(Tab.list)
                    .tabItem { Label("List", systemImage: "list.bullet") }
            }
        }
    }
}


#Preview {
    let landmarkViewModel = LandmarkViewModel()
    let hikeViewModel = HikeViewModel(repository: HikeLocalRepository())
    let profileViewModel = ProfileViewModel()

    return ContentView()
        .environment(landmarkViewModel)
        .environment(hikeViewModel)
        .environment(profileViewModel)
}
