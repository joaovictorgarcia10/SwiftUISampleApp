//
//  CategoryHome.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 23/01/25.
//

import SwiftUI

struct CategoryHome: View {
    @Environment(LandmarkViewModel.self) var landmarkViewModel

    @State private var showingProfile = false
    
    var body: some View {
        NavigationSplitView {
            List {
                landmarkViewModel.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                
                ForEach(landmarkViewModel.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: landmarkViewModel.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    let landmarkViewModel = LandmarkViewModel(repository: LandmarkLocalRepository())

    return CategoryHome()
        .environment(landmarkViewModel)
}
