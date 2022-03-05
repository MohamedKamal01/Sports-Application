//
//  CustomCellTableView.swift
//  Sports
//
//  Created by Mohamed Kamal on 22/02/2022.
//

import UIKit

class CustomCellTableView: UITableViewCell {


    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var strBadge: UIImageView!
    
    @IBOutlet weak var mView: UIView!
    
    @IBOutlet weak var strLeague: UILabel!
        override func awakeFromNib() {
        super.awakeFromNib()
            strBadge.layer.borderWidth=1.0
            //strBadge.layer.masksToBounds = false
            strBadge.layer.borderColor = UIColor.white.cgColor
            strBadge.layer.cornerRadius = strBadge.frame.size.height/2
            //strBadge.clipsToBounds = true
            
            strLeague.numberOfLines = 0
            
            youtube.layer.borderWidth = 1
            youtube.layer.masksToBounds = false
            youtube.layer.borderColor = UIColor.darkGray.cgColor
            youtube.layer.cornerRadius = youtube.frame.size.height/2
            youtube.clipsToBounds = true
            mView.layer.cornerRadius = mView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    
}
