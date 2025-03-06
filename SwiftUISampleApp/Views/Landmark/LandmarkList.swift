//
//  LandmarkList.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 18/01/25.
//

import SwiftUI

struct LandmarkList: View {
    @Environment(LandmarkViewModel.self) var landmarkViewModel
        
    @State private var showFavoritesOnly = false
    @State private var searchableText = ""
    
    var filteredLandmarks: [Landmark] {
        landmarkViewModel.landmarks!.filter { landmark in
            if searchableText.isEmpty {
                return (!showFavoritesOnly || landmark.isFavorite)
            }
            
            return (!showFavoritesOnly || landmark.isFavorite) &&
            landmark.name.localizedCaseInsensitiveContains(searchableText)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.default, value: filteredLandmarks)
            .navigationTitle("Landmarks")
            .searchable(text: $searchableText)
            .refreshable {
                landmarkViewModel.loadLandmarks()
            }
        } detail: {
            Text("Select a Landmark")
        }
    }
}

#Preview {
    let landmarkViewModel = LandmarkViewModel(repository: LandmarkLocalRepository())
    return LandmarkList().environment(landmarkViewModel)
}
