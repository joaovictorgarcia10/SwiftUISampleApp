//
//  ProfileSummary.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 24/01/25.
//

import SwiftUI

struct ProfileSummary: View {
    @Environment(HikeViewModel.self) var hikeViewModel

    var profile: Profile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)


                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)

                Divider()

                VStack(alignment: .leading) {
                    Text("Completed Badges")
                        .font(.headline)
                    
                    if hikeViewModel.hikes == nil {
                        ProgressView("Loading...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    } else if hikeViewModel.hikes!.isEmpty {
                        Text("No hikings founded")
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                HikeBadge(name: "First Hike")
                                HikeBadge(name: "Earth Day")
                                    .hueRotation(Angle(degrees: 90))
                                HikeBadge(name: "Tenth Hike")
                                    .grayscale(0.5)
                                    .hueRotation(Angle(degrees: 45))
                            }
                            .padding(.bottom)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Recent Hikes")
                                .font(.headline)
                            
                            HikeView(hike: hikeViewModel.hikes![0])
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    let hikeViewModel = HikeViewModel(repository: HikeLocalRepository())
    
    return ProfileSummary(profile: Profile.default)
        .environment(hikeViewModel)
}

