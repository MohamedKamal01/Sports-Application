//
//  LastEvents.swift
//  Sports
//
//  Created by Mohamed Kamal on 28/02/2022.
//

import Foundation
struct Model1
{
    let strTeamHome: String
    let vs : String
    let strTeamWay: String
    let intHomeScore: String
    let dash: String
    let intWayScore: String
    let dateEvent: String
    let strTime: String
    init(strTeamHome: String,vs: String,strTeamWay: String,intHomeScore: String,dash: String,intWayScore: String,dateEvent: String,strTime: String)
    {
        self.strTeamHome = strTeamHome
        self.vs = vs
        self.strTeamWay = strTeamWay
        self.intHomeScore = intHomeScore
        self.dash = dash
        self.intWayScore = intWayScore
        self.dateEvent = dateEvent
        self.strTime = strTime
    }
}
