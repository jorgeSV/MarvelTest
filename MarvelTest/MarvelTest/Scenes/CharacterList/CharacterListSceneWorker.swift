//
//  CharacterListSceneWorker.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//  

import UIKit

class CharacterListSceneWorker {
  
    func getCharacters(request: CharacterModel.List.Request,
                       extraID: Int? = nil,
                       onSuccess: @escaping (PaginatedList<Character>) -> Void,
                       onError: @escaping (Error) -> Void) {
        
        GeneralApi.getCharacters(request: request, extraID: extraID, onSuccess: { (list) in
            onSuccess(list)
        }) { (error) in
            onError(error)
        }
    }
    
    func hasMoreResults(list: [Any], total: Int) -> Bool {
        
        if list.count < total {
            return true
        }
        
        return false
    }
}
