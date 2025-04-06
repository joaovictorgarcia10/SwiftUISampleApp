//
//  LandmarkDetailView.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 18/01/25.
//

import SwiftUI

struct LandmarkDetail: View {
    @Environment(LandmarkViewModel.self) var landmarkViewModel
    
    var landmark: Landmark
    
    var landmarkIndex: Int {
        landmarkViewModel.landmarks!.firstIndex(where: { $0.id == landmark.id })!
    }
    
    var body: some View {
        @Bindable var landmarkViewModel = landmarkViewModel
        
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y: -100)
                .padding(.bottom, -100)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name).font(.title)
                    //FavoriteButton(isSet: $landmarkViewModel.landmarks[landmarkIndex].isFavorite)
                }
                
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.automatic)
}
}

#Preview {
    let landmarkViewModel = LandmarkViewModel()
    return LandmarkDetail(landmark: landmarkViewModel.landmarks![1])
        .environment(landmarkViewModel)
}
