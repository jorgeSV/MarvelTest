//
//  GeneralApi.swift
//  MarvelTest
//
//  Created by jorgeSV on 11/5/21.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GeneralApi {
    
    enum endpoints: String {
        case characters = "characters"
    }
    
    static func getCharacters(request:CharacterModel.List.Request,
                              extraID:Int? = nil,
                              onSuccess: @escaping (PaginatedList<Character>) -> (),
                              onError: @escaping (Error) -> ()) {
        
        var requestParams = request.dictionary
        
        AF.request(Utils.completeUrlWithEndpoint(endpoint: endpoints.characters.rawValue, extraID: extraID),
                   parameters: Utils.mergeWithGeneralApiParameters(requestParams: &requestParams)).responseJSON { response in
            
            switch response.result {
                
                case .success(let value):
                    
                    let json = JSON(value)
                    print("JSON: \(json)")
                
                    do {
                        let base = try JSONDecoder().decode(BaseWrapper.self, from: json.rawData())
                        
                        let characters = try JSONDecoder().decode(PaginatedList<Character>.self, from: (base.data?.rawData())!)
                        print("Characters count: '\(characters.count ?? 0)'")
                        
                        return onSuccess(characters)
                        
                    } catch {
                        print("Error \(error)")
                        onError(error)
                    }
                                
                case .failure(let error):
                    
                    print(error)
                    onError(error)
            }
        }
        
    }
}
