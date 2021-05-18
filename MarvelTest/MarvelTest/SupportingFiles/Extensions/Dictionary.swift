//
//  Dictionary.swift
//  MarvelTest
//
//  Created by jorgeSV on 18/5/21.
//

import Foundation

extension Dictionary {
    
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}
