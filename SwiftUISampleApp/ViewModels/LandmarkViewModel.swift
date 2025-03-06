//
//  LandmarkViewModel.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 18/01/25.
//

import Foundation

@Observable
class LandmarkViewModel {
    let repository: BaseRespository
    
    init(repository: BaseRespository) {
        self.repository = repository
        loadLandmarks()
    }
    
    var landmarks: [Landmark]?
    var categories: [String: [Landmark]] = [:]
    var features: [Landmark] = []

    func loadLandmarks() {
        landmarks = nil
        categories = [:]
        features = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            do {
                self.landmarks = try self.repository.loadData()
            } catch {
                self.landmarks = []
            }
            
            if (!self.landmarks!.isEmpty) {
                self.categories = Dictionary(grouping: self.landmarks!, by: { $0.category.rawValue })
                self.features = self.landmarks!.filter { $0.isFeatured }
            }
        }
    }
}
