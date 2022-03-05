//
//  MyCollectionViewCell.swift
//  Sports
//
//  Created by Mohamed Kamal on 22/02/2022.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var strEvent: UILabel!
    @IBOutlet var dateEvent: UILabel!
    @IBOutlet var timeEvent: UILabel!
    
    static let identifier = "MyCollectionViewCell"
    static func nib() ->UINib
    {
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with model: Model)
    {
        self.strEvent.text = model.strEvent
        self.dateEvent.text = model.dateEvent
        self.timeEvent.text = model.timeEvent
        
    }

}
