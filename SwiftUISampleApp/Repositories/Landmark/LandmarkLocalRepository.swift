//
//  LocalFileRepository.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 18/01/25.
//

import Foundation

enum LandmarkLocalRepositoryError : Error {
    case fileNotFound(String)
    case impossibleLoadFile(String)
    case impossibleParseFile(String)
}

class LandmarkLocalRepository : BaseRespository {

    func loadData<T>() throws -> T where T : Decodable {
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
