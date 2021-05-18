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
//    let urls : [Urls]?
    let thumbnail : Thumbnail?
//    let comics : Comics?
//    let stories : Stories?
//    let events : Events?
//    let series : Series?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case modified = "modified"
        case resourceURI = "resourceURI"
//        case urls = "urls"
        case thumbnail = "thumbnail"
//        case comics = "comics"
//        case stories = "stories"
//        case events = "events"
//        case series = "series"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
//        urls = try values.decodeIfPresent([Urls].self, forKey: .urls)
        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
//        comics = try values.decodeIfPresent(Comics.self, forKey: .comics)
//        stories = try values.decodeIfPresent(Stories.self, forKey: .stories)
//        events = try values.decodeIfPresent(Events.self, forKey: .events)
//        series = try values.decodeIfPresent(Series.self, forKey: .series)
    }

}
