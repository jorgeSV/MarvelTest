//
//  BaseWrapper.swift
//  MarvelTest
//
//  Created by jorgeSV on 11/5/21.
//

import Foundation
import SwiftyJSON

struct BaseWrapper : Codable {
    let code : Int?
    let status : String?
    let copyright : String?
    let attributionText : String?
    let attributionHTML : String?
    let data : JSON?
    let etag : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case data = "data"
        case etag = "etag"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        attributionText = try values.decodeIfPresent(String.self, forKey: .attributionText)
        attributionHTML = try values.decodeIfPresent(String.self, forKey: .attributionHTML)
        data = try values.decodeIfPresent(JSON.self, forKey: .data)
        etag = try values.decodeIfPresent(String.self, forKey: .etag)
    }

}
