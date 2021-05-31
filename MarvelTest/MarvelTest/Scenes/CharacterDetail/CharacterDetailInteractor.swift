//
//  CharacterDetailInteractor.swift
//  MarvelTest
//
//  Created by jorgeSV on 29/5/21.
//

import UIKit

protocol CharacterDetailBusinessLogic {
    func fetchCharacterDetail()
}

protocol CharacterDetailDataStore {
    var character: Character! { get set }
}

class CharacterDetailInteractor: CharacterDetailBusinessLogic, CharacterDetailDataStore {
    
    var presenter: CharacterDetailPresentationLogic?
    var worker = CharacterDetailWorker()
    
    var workerList = CharacterListSceneWorker()
    
    var character: Character!

    // MARK: Fetch Character Detail

    func fetchCharacterDetail() {
        
        workerList.getCharacters(request: CharacterModel.List.Request(offset: 0, limit: 1), extraID: self.character?.id) { list in
            
            if let itemsList = list.results {
                
                if let newCharacter = itemsList.compactMap({ $0 }).first {
                    
                    let response = CharacterModel.Detail.Response(character: newCharacter)
                    self.presenter?.presentCharacterDetail(response: response)
                }
            }
            
        } onError: { error in
            self.presenter?.presentError(error: error)
        }
    }
}
