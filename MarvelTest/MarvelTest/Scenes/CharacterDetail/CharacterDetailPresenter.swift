//
//  CharacterDetailPresenter.swift
//  MarvelTest
//
//  Created by jorgeSV on 29/5/21.
//

import UIKit

protocol CharacterDetailPresentationLogic {
    func presentCharacterDetail(response: CharacterModel.Detail.Response)
    func presentError(error: Error)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
  
    weak var viewController: CharacterDetailDisplayLogic?
  
    // MARK: Presents
  
    func presentCharacterDetail(response: CharacterModel.Detail.Response) {
        
        guard let char = response.character else {
            presentError(error: NSError())
            return
        }
        
        let comics = String.init(char.comics?.available ?? 0) + " comics" + "\n"
        let series = String.init(char.series?.available ?? 0) + " series" + "\n"
        let events = String.init(char.events?.available ?? 0) + " events" + "\n"
        let stories = String.init(char.stories?.available ?? 0) + " stories"
        
        let viewModel = CharacterModel.Detail.ViewModel(path: char.thumbnail?.path ?? "",
                                                        ext: char.thumbnail?.ext ?? "",
                                                        title: char.name ?? "",
                                                        desc: char.description ?? "",
                                                        opt: comics + series + events + stories)
        
        viewController?.displayCharacterDetail(viewModel: viewModel)
    }
    
    func presentError(error: Error) {
        viewController?.displayError(error: error)
    }
}
