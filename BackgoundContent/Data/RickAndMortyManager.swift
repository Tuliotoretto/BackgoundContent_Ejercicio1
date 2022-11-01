//
//  RickAndMortyDataManager.swift
//  BackgoundContent
//
//  Created by Julian Garcia  on 31/10/22.
//

import Foundation

protocol RickAndMortyDelegate {
    func didUpdateData(_ rickAndMortyManager: RickAndMortyManager, _ rickAndMorty: RickAndMorty)
    func didFailWithError(_ rickAndMortyManager: RickAndMortyManager, _ error: Error)
}

struct RickAndMortyManager {
    let url = "https://rickandmortyapi.com/api/character"
    
    var delegate: RickAndMortyDelegate?
    
    func fetchCharacters() {
        guard let url = URL(string: url) else {return}
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(self, error!)
                return
            }
            if let safeData = data {
                do {
                    let decodedData = try JSONDecoder().decode(RickAndMorty.self, from: safeData)
                    let rickAndMorty = RickAndMorty(info: decodedData.info, results: decodedData.results)
                    self.delegate?.didUpdateData(self, rickAndMorty)
                } catch {
                    self.delegate?.didFailWithError(self, error)
                }
            }
        }
        task.resume()
    }
}
