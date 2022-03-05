//
//  MyCollectionViewCell2.swift
//  Sports
//
//  Created by Mohamed Kamal on 25/02/2022.
//

import UIKit

class MyCollectionViewCell2: UICollectionViewCell {


    @IBOutlet var strBadge: UIImageView!
    var model: Model2?
    static let identifier = "MyCollectionViewCell2"
    static func nib() ->UINib
    {
        return UINib(nibName: "MyCollectionViewCell2", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func configure(with model: Model2)
    {
        let urlimage = model.strBadge
        let data = try? Data(contentsOf: URL(string: urlimage)!)
        self.model = model
        if let imageData = data {
            self.strBadge.image = UIImage(data: imageData)
            self.strBadge.layer.borderWidth=1.0
            self.strBadge.layer.masksToBounds = false
            self.strBadge.layer.borderColor = UIColor.white.cgColor
            self.strBadge.layer.cornerRadius = strBadge.frame.size.height/2
            self.strBadge.clipsToBounds = true
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//            self.strBadge.isUserInteractionEnabled = true
//            self.strBadge.addGestureRecognizer(tapGestureRecognizer)
//            self.strBadge.isUserInteractionEnabled = true;
            }

        }
    
//    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//        _ = tapGestureRecognizer.view as! UIImageView
//     print("mohamed")
//
//    }


    

}
