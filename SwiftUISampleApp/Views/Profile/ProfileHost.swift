//
//  ProfileHost.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 24/01/25.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    
    @Environment(HikeViewModel.self) var hikeViewModel
    @Environment(ProfileViewModel.self) var profileViewModel

    @State private var draftProfile = Profile.default
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = profileViewModel.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: profileViewModel.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = profileViewModel.profile
                    }
                    .onDisappear {
                        profileViewModel.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}


#Preview {
    let hikeViewModel = HikeViewModel(repository: HikeLocalRepository())
    let profileViewModel = ProfileViewModel()

    return ProfileHost()
        .environment(hikeViewModel)
        .environment(profileViewModel)
}

