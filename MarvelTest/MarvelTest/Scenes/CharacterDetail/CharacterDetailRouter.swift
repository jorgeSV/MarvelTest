//
//  CharacterDetailRouter.swift
//  MarvelTest
//
//  Created by jorgeSV on 29/5/21.
//

import UIKit

@objc protocol CharacterDetailRoutingLogic {
    
}

protocol CharacterDetailDataPassing {
    var dataStore: CharacterDetailDataStore? { get }
}

class CharacterDetailRouter: NSObject, CharacterDetailRoutingLogic, CharacterDetailDataPassing {
  
    weak var viewController: CharacterDetailViewController?
    var dataStore: CharacterDetailDataStore?
}
