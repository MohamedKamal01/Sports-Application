//
//  CollectionTableViewCell2.swift
//  Sports
//
//  Created by Mohamed Kamal on 25/02/2022.
//

import UIKit
protocol TeamDetailsDelegate: NSObjectProtocol
{
    func TeamDetailsDelegateDidTapItem(model: Model2)
}
class CollectionTableViewCell2:  UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    weak var delegate: TeamDetailsDelegate?
    static let identifier = "CollectionTableViewCell2"
    static func nib() -> UINib
    {
        return UINib(nibName: "CollectionTableViewCell2", bundle: nil)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    var models = [Model2]()
    func configier(with models:[Model2])
    {
        self.models = models
        collectionView.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(MyCollectionViewCell2.nib(), forCellWithReuseIdentifier: MyCollectionViewCell2.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK :- cllection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell2.identifier, for: indexPath) as! MyCollectionViewCell2
        cell.configure(with: models[indexPath.row])
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.purple.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if((delegate?.responds(to: Selector(("TeamDetailsDelegateDidTapItem:")))) != nil)
        {
            delegate?.TeamDetailsDelegateDidTapItem(model: models[indexPath.row])
        }
        
    }
    
}



