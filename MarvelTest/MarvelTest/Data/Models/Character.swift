//
//  Character.swift
//  MarvelTest
//
//  Created by jorgeSV on 11/5/21.
//

import Foundation

struct Character : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let modified : String?
    let resourceURI : String?
    let thumbnail : Thumbnail?
    let comics : Container?
    let series : Container?
    let stories : Container?
    let events : Container?
//    let urls : [Urls]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case modified = "modified"
        case resourceURI = "resourceURI"
        case thumbnail = "thumbnail"
        case comics = "comics"
        case series = "series"
        case stories = "stories"
        case events = "events"
//        case urls = "urls"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        comics = try values.decodeIfPresent(Container.self, forKey: .comics)
        series = try values.decodeIfPresent(Container.self, forKey: .series)
        stories = try values.decodeIfPresent(Container.self, forKey: .stories)
        events = try values.decodeIfPresent(Container.self, forKey: .events)
//        urls = try values.decodeIfPresent([Urls].self, forKey: .urls)
    }

}
