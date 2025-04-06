//
//  LandmarkRemoteRepository.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 06/03/25.
//

import Foundation
import FirebaseFirestore

class LandmarkRemoteRepository: BaseRespository {
    func loadData<T>() throws -> T where T : Decodable {
        // MARK: Implement load data from Firebase
        lazy var firestore = Firestore.firestore()
        // ...
        
        let data: Data
        let filename = "landmarkData.json"
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            throw LandmarkLocalRepositoryError.fileNotFound("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            throw LandmarkLocalRepositoryError.impossibleLoadFile("Couldn't load \(filename) from main bundle:\n\(error)")
         }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw LandmarkLocalRepositoryError.impossibleParseFile("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
