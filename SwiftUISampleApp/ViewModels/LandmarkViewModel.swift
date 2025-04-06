//
//  LandmarkViewModel.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 18/01/25.
//

import Foundation

@Observable
class LandmarkViewModel {
    
    init() {
        loadLandmarks()
    }
    
    var landmarks: [Landmark]?
    var categories: [String: [Landmark]] = [:]
    var features: [Landmark] = []
    
    func loadLandmarks() {
        resetVariables()
        
        guard let repository = self.getRepositoryFromEnvironment() else {
            self.landmarks = []
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            do {
                self.landmarks = try repository.loadData()
            } catch {
                self.landmarks = []
            }
            
            if (!self.landmarks!.isEmpty) {
                self.categories = Dictionary(grouping: self.landmarks!, by: { $0.category.rawValue })
                self.features = self.landmarks!.filter { $0.isFeatured }
            }
        }
    }
        
    private func getRepositoryFromEnvironment() -> BaseRespository? {
        let value = ProcessInfo.processInfo.environment["ENVIRONMENT"]
        
        switch value {
        case "local":
            return LandmarkLocalRepository()
        case "remote":
            return LandmarkRemoteRepository()
        default:
            return nil
        }
    }
    
    private func resetVariables() {
        self.landmarks = nil
        self.categories = [:]
        self.features = []
    }
}
