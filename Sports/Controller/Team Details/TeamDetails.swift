//
//  TeamDetails.swift
//  Sports
//
//  Created by Mohamed Kamal on 25/02/2022.
//

import UIKit

class TeamDetails: UIViewController {

    var model: Model2?

    @IBOutlet weak var strTeamBadge: UIImageView!
    @IBOutlet weak var intFormedYear: UILabel!
    @IBOutlet weak var strCountry: UILabel!
    
    @IBOutlet weak var openWith: UILabel!
    @IBOutlet weak var strStadiumThumb: UIImageView!
    @IBOutlet weak var strTeamJersey: UIImageView!
    
    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var facebook: UIButton!
    var urlYoutube: String?
    var urlFacebook: String?
    
    override func viewWillAppear(_ animated: Bool) {
        let urlImageBadge = model!.strBadge
        let dataBadge = try? Data(contentsOf: URL(string: urlImageBadge)!)
        self.strTeamBadge.image = UIImage(data: dataBadge!)
        self.intFormedYear.text = "Since "+model!.intFormedYear
        self.strCountry.text = "Originated in "+model!.strCountry
        let urlImageJersy = model!.strTeamJersey
        let dataJersy = try? Data(contentsOf: URL(string: urlImageJersy)!)
        self.strTeamJersey.image = UIImage(data: dataJersy!)
        let urlImageStadium = model!.strStadiumThumb
        let dataStadium = try? Data(contentsOf: URL(string: urlImageStadium)!)
        self.strStadiumThumb.image = UIImage(data: dataStadium!)
        self.openWith.text = "Open Offecial Website"
        urlFacebook = model!.strFacebook
        urlYoutube = model!.strYoutube
        youtube.layer.cornerRadius = youtube.frame.size.height/2
        facebook.layer.cornerRadius = facebook.frame.size.height/2
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
   //MARK: - show facebook
    @IBAction func showFacebook(_ sender: Any) {
        
        if urlFacebook != ""
        {
            UIApplication.shared.open(URL(string: "https://\(urlFacebook!)")!, options: [:], completionHandler: nil)
        }
        else
        {
            let alert = UIAlertController(title: "This League", message: "Not Found", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert,animated: true)
        }
        
    }
    //MARK: - show video
    @IBAction func showVideo(_ sender: Any) {
        if urlYoutube != ""
        {
            UIApplication.shared.open(URL(string: "https://\(urlYoutube!)")!, options: [:], completionHandler: nil)
        }
        else
        {
            let alert = UIAlertController(title: "This League", message: "Not Found", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert,animated: true)
        }
    }
}
