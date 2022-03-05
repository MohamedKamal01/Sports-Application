//
//  FavoriteLeagues.swift
//  Sports
//
//  Created by Mohamed Kamal on 27/02/2022.
//

import UIKit
import Reachability
class FavoriteLeagues: UITableViewController {

    @IBOutlet weak var noData: UIImageView!
    var checkNetwork = ""
    var segueStrLeague: String?
    var segueIdLeague: String?
    let reachability = try! Reachability()
    //MARK: - check reachabilty of connection of network
    override func viewWillAppear(_ animated: Bool)
    {
        DBManager.shared.getFavorites()
        if DBManager.shared.strLeagues.count == 0
        {
            tableView.isHidden = false
            
        }
        else
        {
            noData.isHidden = true

        }

        tableView.reloadData()
        
        
    }
    //MARK: - reachabilty of network
    @objc func reachabilityChanged(note: Notification){

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          checkNetwork = "Reachable via WiFi"
          
      case .cellular:
          checkNetwork = "Reachable via cellular"

      case .unavailable:
          checkNetwork = "Network not reachable"
      case .none:
          checkNetwork = "None"
      }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 60
        
    }

    // MARK: -Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBManager.shared.strLeagues.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomFavoriteCell
        let urlimage = URL(string: DBManager.shared.strBadges[indexPath.row])
        let data = try? Data(contentsOf: urlimage!)

        if let imageData = data {
            cell.strBadge.image = UIImage(data: imageData)!
        }
        
        cell.strLeague.text = DBManager.shared.strLeagues[indexPath.row]
        cell.youtube.addTarget(self, action: #selector(watchVideo(sender:)), for: .touchUpInside)
        cell.youtube.tag = indexPath.row
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect.zero)
        let label = UILabel(frame: CGRect(x: 150, y: 20, width: 150, height: 50))
        label.text = "Favorite Leagues"
        label.textColor = UIColor.black
        view.backgroundColor = .white
        view.addSubview(label)
        return view
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        DBManager.shared.deleteData("Favorite", strLeague: DBManager.shared.strLeagues[indexPath.row])
        DBManager.shared.strLeagues.remove(at: indexPath.row)
        DBManager.shared.strBadges.remove(at: indexPath.row)
        DBManager.shared.strYoutubes.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        if DBManager.shared.strLeagues.count == 0
        {
            noData.isHidden = false
        }

        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if checkNetwork != "Network not reachable" || checkNetwork != "None"
        {
            self.segueStrLeague = DBManager.shared.strLeagues[indexPath.row]
            self.segueIdLeague = DBManager.shared.idLeagues[indexPath.row]
            self.performSegue(withIdentifier: "segueFavorite", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "network not avaliable", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! LeaguesDetails
        detailVC.strLeague = self.segueStrLeague!
        detailVC.idLeague = self.segueIdLeague!
    }

    // MARK: - watch Video
    @objc func watchVideo(sender: UIButton){
        if DBManager.shared.strYoutubes[sender.tag] != ""
        {
            UIApplication.shared.open(URL(string: "https://\(DBManager.shared.strYoutubes[sender.tag])")!, options: [:], completionHandler: nil)
        }
        else
        {
            let alert = UIAlertController(title: DBManager.shared.strYoutubes[sender.tag], message: "Not Found", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert,animated: true)
        }
        
    }
}
