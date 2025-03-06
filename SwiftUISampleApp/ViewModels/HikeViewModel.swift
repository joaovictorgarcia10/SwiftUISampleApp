//
//  HikeViewModel.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 24/01/25.
//

import Foundation

@Observable
class HikeViewModel {
    let repository: BaseRespository

    init(repository: BaseRespository) {
        self.repository = repository
        loadHikes()
    }
    
    var hikes: [Hike]?
    
    func loadHikes() {
        hikes = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            do {
                self.hikes = try self.repository.loadData()
            } catch {
                self.hikes = []
            }
        }
    }
}
