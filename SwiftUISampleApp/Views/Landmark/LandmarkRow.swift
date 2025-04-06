//
//  LandmarkRow.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 18/01/25.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
   
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
           
            Text(landmark.name)

            Spacer()
            
            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
    }
}

#Preview("First") {
    let landmarkViewModel = LandmarkViewModel()

    return if let firstLandmark = landmarkViewModel.landmarks!.first {
        LandmarkRow(landmark: firstLandmark)
    } else {
        Text("No landmarks loaded")
    }
}

#Preview("Last") {
    let landmarkViewModel = LandmarkViewModel()
    
    return if let firstLandmark = landmarkViewModel.landmarks!.last {
        LandmarkRow(landmark: firstLandmark)
    } else {
        Text("No landmarks loaded")
    }
}
