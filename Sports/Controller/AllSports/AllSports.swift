//
//  AllSports.swift
//  Sports
//
//  Created by Mohamed Kamal on 21/02/2022.
//

import UIKit
import Reachability
import CoreData
import SkeletonView
class AllSports: UICollectionViewController, UICollectionViewDelegateFlowLayout,SkeletonCollectionViewDataSource {

    var counter = 0
    var allSports = [SportModel]()
    let reachability = try! Reachability()
    //MARK: - check reachabilty of connection of network
    override func viewWillAppear(_ animated: Bool)
    {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
       do{
         try reachability.startNotifier()
       }catch{
         print("could not start reachability notifier")
       }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sports"

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if counter == 0
        {
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete), animation: nil, transition: .crossDissolve(0))
            counter += 1
        }
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allSports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        configure(cell,forItemAt: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let countrys = storyBoard.instantiateViewController(withIdentifier: "Countrys") as! Countrys
        self.navigationController?.pushViewController(countrys, animated: true)
        countrys.strSport = allSports[indexPath.row].strSport
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftAndRightPaddings: CGFloat = 0.0
        let numberOfItemsPerRow: CGFloat = 2.0
        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
    // MARK: - configure cell
    func configure(_ cell: CustomCell, forItemAt indexPath: IndexPath)
    {
        let urlimage = URL(string: allSports[indexPath.row].strSportThumb)
        let data = try? Data(contentsOf: urlimage!)
        if let imageData = data {
            cell.strSportThumb.image = UIImage(data: imageData)!
        }
        cell.strSport.text = allSports[indexPath.row].strSport
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.purple.cgColor
    }
    // MARK: - collection skeleton view
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return CustomCell.identifier
    }
    //MARK: reachabilty of network
    @objc func reachabilityChanged(note: Notification){

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
          getAllSports()
      case .cellular:
          print("Reachable via cellular")
          getAllSports()
      case .unavailable:
          print("Network not reachable")
      case .none:
          print("None")
      }
    }
    //MARK: reset api of all sports
    func getAllSports()
    {
        ServerData.shared.getAllSports { (result) in
            switch result
            {
            case .success(let sports):
                self.updateUI(with: sports)
            case .failure(let error):
                self.displayError(error,
                    title: "Failed to Fetch Sports")
            }
        }
        
    }
    //MARK: - update ui for data from server
    func updateUI(with sports: [SportModel]) {
            DispatchQueue.main.async {
                self.allSports = sports
                self.collectionView.stopSkeletonAnimation()
                self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0))
                self.collectionView.reloadData()
            }
    }
    //MARK: - display error for not comming data
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",style: .default, handler:nil))
           self.present(alert, animated: true, completion: nil)
        }
    }
    

}
