//
//  Leagues.swift
//  Sports
//
//  Created by Mohamed Kamal on 22/02/2022.
//

import UIKit
import SkeletonView
class Leagues: UITableViewController {

    @IBOutlet weak var noData: UIImageView!
    var strSport : String = ""
    var countrysNames = [String]()
    var segueStrLeague: String?
    var segueIdLeague: String?
    var segueStrYoutube: String?
    var segueStrBadge: String?
    var allLeagues = [LeagueModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllLeaguesForSport()
        if allLeagues.count != 0
        {
            tableView.isHidden = false
            
        }
        else
        {
            noData.isHidden = true

        }
        tableView.reloadData()
        title = "Leagues For \(strSport)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return allLeagues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellTableView
        configure(cell, forItemAt: indexPath)
        return cell
    }
    //MARK: - configure cell
    func configure(_ cell: CustomCellTableView, forItemAt indexPath: IndexPath)
    {
        let urlimage = URL(string: allLeagues[indexPath.row].strBadge)
        let data = try? Data(contentsOf: urlimage!)
        if let imageData = data {
            cell.strBadge.image = UIImage(data: imageData)!
        }
        cell.strLeague.text = allLeagues[indexPath.row].strLeague
        cell.youtube.addTarget(self, action: #selector(watchVideo(sender:)), for: .touchUpInside)
        cell.youtube.tag = indexPath.row
    }
    //MARK: - segue for league details
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.segueStrLeague = allLeagues[indexPath.row].strLeague
        self.segueIdLeague = allLeagues[indexPath.row].idLeague
        self.segueStrBadge = allLeagues[indexPath.row].strBadge
        self.segueStrYoutube = allLeagues[indexPath.row].strYoutube
        self.performSegue(withIdentifier: "segueLeaguesDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! LeaguesDetails
        detailVC.strLeague = self.segueStrLeague!
        detailVC.idLeague = self.segueIdLeague!
        detailVC.strBadge = self.segueStrBadge!
        detailVC.strYoutube = self.segueStrYoutube!
    }
    
    // MARK: - watch Video
    @objc func watchVideo(sender: UIButton){
        if allLeagues[sender.tag].strYoutube != ""
        {
            UIApplication.shared.open(URL(string: "https://\(allLeagues[sender.tag].strYoutube)")!, options: [:], completionHandler: nil)
        }
        else
        {
            let alert = UIAlertController(title: allLeagues[sender.tag].strLeague, message: "Not Found", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert,animated: true)
        }
        
    }
    //MARK: - get All Leagues For Sport
    func getAllLeaguesForSport()
    {
        for country in countrysNames{
            ServerData.shared.getAllLeagues(country: country, sport: strSport) { (result) in
                switch result
                {
                case .success(let allLeagues):
                    self.updateUI(with: allLeagues)
                case .failure(let error):
                    self.displayError(error,
                        title: "Failed to Fetch Leagues to \(country)")
                
                }
            }
        }
    }
    //MARK: - update ui for data from server
    func updateUI(with leagues: [LeagueModel]) {
            DispatchQueue.main.async {
                self.allLeagues += leagues
                if self.allLeagues.count == 0
                {
                    self.noData.isHidden = true
                }
                self.tableView.reloadData()
            }
    }
    //MARK: - display error for not comming data
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            if self.allLeagues.count == 0
            {
                self.noData.isHidden = false
            }
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss",style: .default, handler:nil))
           self.present(alert, animated: true, completion: nil)
        }
    }


}
