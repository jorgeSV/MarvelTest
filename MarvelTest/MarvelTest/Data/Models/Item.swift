//
//  Item.swift
//  MarvelTest
//
//  Created by jorgeSV on 29/5/21.
//

import Foundation

struct Item : Codable {
    let resourceURI : String?
    let name : String?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case resourceURI = "resourceURI"
        case name = "name"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
