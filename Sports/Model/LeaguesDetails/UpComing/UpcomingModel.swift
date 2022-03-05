//
//  UpcomingModel.swift
//  Sports
//
//  Created by Mohamed Kamal on 28/02/2022.
//

import Foundation
struct Model
{
    let strEvent: String
    let dateEvent: String
    let timeEvent: String
    init(strEvent: String,dateEvent: String,timeEvent: String)
    {
        self.strEvent = strEvent
        self.dateEvent = dateEvent
        self.timeEvent = timeEvent
    }
}
