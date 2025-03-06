//
//  LandmarkRespository.swift
//  SwiftUISampleApp
//
//  Created by João Victor Garcia Leite Santana on 18/01/25.
//

import Foundation

protocol BaseRespository {
    func loadData<T: Decodable>() throws -> T
}
