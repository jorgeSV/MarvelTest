//
//  CharacterListSceneRouter.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//

import UIKit

@objc protocol CharacterListSceneRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CharacterListSceneDataPassing {
    var dataStore: CharacterListSceneDataStore? { get }
}

class CharacterListSceneRouter: NSObject, CharacterListSceneRoutingLogic, CharacterListSceneDataPassing {
    
    weak var viewController: CharacterListSceneViewController?
    var dataStore: CharacterListSceneDataStore?
  
    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: CharacterListSceneViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: CharacterListSceneDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
