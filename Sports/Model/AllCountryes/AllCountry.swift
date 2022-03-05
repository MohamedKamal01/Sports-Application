//
//  AllCountry.swift
//  Sports
//
//  Created by Mohamed Kamal on 03/03/2022.
//

import Foundation
struct CountryModel: Codable
{
    var name_en: String

    enum CodingKeys: String, CodingKey
    {
        case name_en
    }
}
struct AllCountryModel: Codable
{
    let countries: [CountryModel]
}
