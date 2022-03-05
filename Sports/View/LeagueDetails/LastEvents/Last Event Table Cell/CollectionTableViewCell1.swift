//
//  CollectionTableViewCell1.swift
//  Sports
//
//  Created by Mohamed Kamal on 24/02/2022.
//

import UIKit

class CollectionTableViewCell1: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    static let identifier = "CollectionTableViewCell1"
    static func nib() -> UINib
    {
        return UINib(nibName: "CollectionTableViewCell1", bundle: nil)
    }
    
    @IBOutlet var collectionView: UICollectionView!
    var models = [Model1]()
    func configier(with models:[Model1])
    {
        self.models = models
        collectionView.reloadData()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(MyCollectionViewCell1.nib(), forCellWithReuseIdentifier: MyCollectionViewCell1.identifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell1.identifier, for: indexPath) as! MyCollectionViewCell1
        cell.configure(with: models[indexPath.row])
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 425, height: 150)
    }
    
    
}

