//
//  Utils.swift
//  MarvelTest
//
//  Created by jorgeSV on 13/5/21.
//

import Foundation
import CryptoKit
import Alamofire

class Utils {

    static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    static func generalApiParameters() -> Parameters {
        
        let strHash = Constants.API_TS + Constants.API_KEY_PRIVATE + Constants.API_KEY_PUBLIC
        
        let params : Parameters = ["ts" : Constants.API_TS,
                                   "apikey" : Constants.API_KEY_PUBLIC,
                                   "hash" : Utils.MD5(string: strHash)]
        
        return params
    }
}
