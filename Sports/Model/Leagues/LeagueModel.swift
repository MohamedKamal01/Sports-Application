//
//  LeagueModel.swift
//  Sports
//
//  Created by Mohamed Kamal on 28/02/2022.
//

import Foundation
struct LeagueModel: Codable
{
    var idLeague: String
    var strLeague: String
    var strYoutube: String
    var strBadge: String
    enum CodingKeys: String, CodingKey
    {
        case idLeague
        case strLeague
        case strYoutube
        case strBadge
    }
}
