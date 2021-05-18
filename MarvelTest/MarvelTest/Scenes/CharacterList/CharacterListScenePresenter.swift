//
//  CharacterListScenePresenter.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//

import UIKit

protocol CharacterListScenePresentationLogic {
    func presentCharacters(response: CharacterModel.List.Response, hasMoreResults: Bool?)
    func presentError(error: Error)
}

class CharacterListScenePresenter: CharacterListScenePresentationLogic {
    weak var viewController: CharacterListSceneDisplayLogic?
  
    // MARK: Presents
  
    func presentCharacters(response: CharacterModel.List.Response, hasMoreResults: Bool?) {
        
        let viewModel = response.list.results?.compactMap({ character in
            CharacterModel.List.ViewModel(path: character.thumbnail?.path ?? "",
                                          ext: character.thumbnail?.ext ?? "",
                                          title: character.name ?? "",
                                          desc: character.description ?? "")
        }) ?? []
        
        viewController?.displayCharacters(viewModel: viewModel, hasMoreResults: hasMoreResults)
    }
    
    func presentError(error: Error) {
        viewController?.displayError(error: error)
    }
}
