//
//  MyCollectionViewCell1.swift
//  Sports
//
//  Created by Mohamed Kamal on 24/02/2022.
//

import UIKit

class MyCollectionViewCell1: UICollectionViewCell {
    
    @IBOutlet var strTeamHome: UILabel!
    @IBOutlet var vs: UILabel!
    @IBOutlet var strTeamWay: UILabel!
    @IBOutlet var intHomeScore: UILabel!
    @IBOutlet var dash: UILabel!
    @IBOutlet var intWayScore: UILabel!
    @IBOutlet var dateEvent: UILabel!
    @IBOutlet var strTime: UILabel!
    
    static let identifier = "MyCollectionViewCell1"
    static func nib() ->UINib
    {
        return UINib(nibName: "MyCollectionViewCell1", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with model: Model1)
    {
        self.strTeamHome.text = model.strTeamHome
        self.strTeamHome.textAlignment = .center
        self.strTeamHome.numberOfLines = 0
        self.vs.text = model.vs
        self.vs.textAlignment = .center
        self.strTeamWay.text = model.strTeamWay
        self.strTeamWay.textAlignment = .center
        self.strTeamWay.numberOfLines = 0
        self.intHomeScore.text = model.intHomeScore
        self.intHomeScore.textAlignment = .center
        self.dash.text = model.dash
        self.dash.textAlignment = .center
        self.intWayScore.text = model.intWayScore
        self.intWayScore.textAlignment = .center
        self.dateEvent.text = model.dateEvent
        self.strTime.text = model.strTime
    }

}
