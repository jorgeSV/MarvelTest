//
//  Container.swift
//  MarvelTest
//
//  Created by jorgeSV on 29/5/21.
//

struct Container : Codable {
    let available : Int?
    let returned : Int?
    let collectionURI : String?
    let items : [Item]?

    enum CodingKeys: String, CodingKey {

        case available = "available"
        case returned = "returned"
        case collectionURI = "collectionURI"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
        items = try values.decodeIfPresent([Item].self, forKey: .items)
    }

}
