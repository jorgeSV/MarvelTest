//
//  CharacterListSceneModels.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//

import UIKit

enum CharacterModel {
  
    // MARK: Use cases
  
    enum List {
        
        struct Request: Encodable {
            let offset : Int?
            let limit : Int?
        }
    
        struct Response {
            let list: PaginatedList<Character>
        }
    
        struct ViewModel {
            let path: String
            let ext: String
            let title: String
            let desc: String
        }
    }
}
