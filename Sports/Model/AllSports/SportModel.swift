//
//  SportModel.swift
//  Sports
//
//  Created by Mohamed Kamal on 28/02/2022.
//

import Foundation

struct SportModel: Codable
{
    var strSport: String
    var strSportThumb: String
    enum CodingKeys: String, CodingKey
    {
        case strSport
        case strSportThumb
    }
}
