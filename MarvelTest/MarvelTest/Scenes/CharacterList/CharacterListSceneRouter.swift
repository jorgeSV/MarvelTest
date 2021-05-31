//
//  CharacterListSceneRouter.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//

import UIKit

@objc protocol CharacterListSceneRoutingLogic {
    func routeToCharacterDetail(segue: UIStoryboardSegue?)
}

protocol CharacterListSceneDataPassing {
    var dataStore: CharacterListSceneDataStore? { get }
}

class CharacterListSceneRouter: NSObject, CharacterListSceneRoutingLogic, CharacterListSceneDataPassing {
    
    weak var viewController: CharacterListSceneViewController?
    var dataStore: CharacterListSceneDataStore?
  
    // MARK: Routing

    func routeToCharacterDetail(segue: UIStoryboardSegue?) {
      
        if let segue = segue {
            let destinationVC = segue.destination as! CharacterDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCharacterDetail(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCharacterDetail(source: dataStore!, destination: &destinationDS)
            navigateToCharacterDetail(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: Navigation

    func navigateToCharacterDetail(source: CharacterListSceneViewController, destination: CharacterDetailViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToCharacterDetail(source: CharacterListSceneDataStore, destination: inout CharacterDetailDataStore) {
        destination.character = source.selectedCharacter
    }
}
