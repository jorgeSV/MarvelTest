//
//  CharacterListSceneInteractor.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//

import UIKit

protocol CharacterListSceneBusinessLogic {
    func fetchCharacters(request: CharacterModel.List.Request)
}

protocol CharacterListSceneDataStore {
    var characterList: [Character] { get set }
}

class CharacterListSceneInteractor: CharacterListSceneBusinessLogic, CharacterListSceneDataStore {
  
    var presenter: CharacterListScenePresentationLogic?
    var worker = CharacterListSceneWorker()
    var characterList: [Character] = []
  
    // MARK: Fetchs
  
    func fetchCharacters(request: CharacterModel.List.Request) {
        
        worker.getCharacters(request: request, onSuccess: { list in
          
            if let itemsList = list.results {
                self.characterList.append(contentsOf: itemsList.compactMap({ $0 }))
            }
            
            var list = list
            list.results = self.characterList
            let response = CharacterModel.List.Response(list: list)
            
            self.presenter?.presentCharacters(response: response, hasMoreResults: self.worker.hasMoreResults(list: self.characterList, total: list.total ?? 0))
            
        }, onError: { error in
            self.presenter?.presentError(error: error)
        })
    }
}
