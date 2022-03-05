//
//  LeaguesDettails.swift
//  Sports
//
//  Created by Mohamed Kamal on 22/02/2022.
//

import UIKit

class LeaguesDetails: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    

    var strLeague:String = ""
    var strYoutube:String = ""
    var strBadge:String = ""
    var idLeague:String = ""
    @IBOutlet var table: UITableView!
    var modelsUpcoming = [Model]()
    var modelsResults = [Model1]()
    var modelsTeams = [Model2]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let myimage = UIImage(named: "favorite")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: myimage, style: .plain, target: self, action: #selector(addTapped))
        table.delegate = self
        table.dataSource = self
        getUpcomingEvents()
        getLastestResults()
        getAllTeams()
    }
    @objc func addTapped()
    {
        let check = DBManager.shared.addFavorite(strLeague: strLeague, strYoutube: strYoutube, strBadge: strBadge, idLeague: idLeague)
        if !check
        {
            let alert = UIAlertController(title: strLeague, message: "Exist", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        }
        else
        {
            let alert = UIAlertController(title: strLeague, message: "Added", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
        cell.configier(with: modelsUpcoming)
        switch indexPath.section
        {
        case 0:
            table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configier(with: modelsUpcoming)
            return cell
            break
        case 1:
            table.register(CollectionTableViewCell1.nib(), forCellReuseIdentifier: CollectionTableViewCell1.identifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell1.identifier, for: indexPath) as! CollectionTableViewCell1
            cell.configier(with: modelsResults)
            return cell
            break
        case 2:
            table.register(CollectionTableViewCell2.nib(), forCellReuseIdentifier: CollectionTableViewCell2.identifier)
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell2.identifier, for: indexPath) as! CollectionTableViewCell2
            
            cell.configier(with: modelsTeams)
            cell.delegate = self
            return cell
            break
        default:
            break
        }
        return cell
    }

    func moveToTeamDetails(index: Int)
    {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "teamDetails") as? TeamDetails
        else{
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var events = ""
        if section == 0
        {
            events = "Upcoming Events"
        }
        else if section == 1
        {
            events = "Latest Results"
        }
        else
        {
            events = "Teams"
        }
        return events
    }
    //MARK: - get upcoming events
  func getUpcomingEvents()
  {
      let myURLString = "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=\(strLeague)"
      print(myURLString)
      let urlString = myURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      if let url = URL(string: urlString!)
      {
          var flag = true
          let req = URLRequest(url: url)
          let session = URLSession(configuration: URLSessionConfiguration.default)
          let task = session.dataTask(with: req) { data, response, error in
              do
              {
                  let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as!
                  Dictionary<String,Any>
                  if let dicLeagues = json["event"] as? [Dictionary<String,Any>]
                  {
                      DispatchQueue.main.async {
                      for dictionary in dicLeagues
                      {
                          let dateFormatter = DateFormatter()
                          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                          if let _ = dictionary["dateEvent"] as? String
                          {
                              if let date = dateFormatter.date(from:(dictionary["dateEvent"] as! String)+"T"+(dictionary["strTime"] as? String ?? "00:00:00")+"+00:00")
                              {
                                  if date > Date()
                                  {
                                      self.modelsUpcoming.append(Model(strEvent: dictionary["strEvent"] as! String, dateEvent: dictionary["dateEvent"] as! String, timeEvent: dictionary["strTime"] as! String))
                                      flag = false
                                  }
                              }
                          }
                          self.table.reloadData()
                      }
                          if flag
                          {
                              self.modelsUpcoming.append(Model(strEvent: "NO Data To Show", dateEvent: "", timeEvent: ""))
                              self.table.reloadData()
                          }
          
                          self.table.reloadData()
                      }
                  }
                  else
                  {
                      self.modelsUpcoming.append(Model(strEvent: "NO Data To Show", dateEvent: "", timeEvent: ""))
                      self.table.reloadData()
                  }
      
      
              }
              catch
              {
                  print(error.localizedDescription)
              }
          }
          task.resume()
          table.reloadData()
      }
  }
    // MARK: - get all results
    func getLastestResults()
    {
        //strLeague = strLeague.replacingOccurrences(of: " ", with: "_")
        let myURLString = "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=\(idLeague)"
        print(myURLString)
        let urlString = myURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: urlString!)
        {
            var flag = true
            let req = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: req) { data, response, error in
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as!
                    Dictionary<String,Any>
                    if let dicLeagues = json["events"] as? [Dictionary<String,Any>]
                    {
                        DispatchQueue.main.async {
                        for dictionary in dicLeagues
                        {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            if let _ = dictionary["dateEvent"] as? String
                            {
                                if let date = dateFormatter.date(from:(dictionary["dateEvent"] as! String)+"T"+(dictionary["strTime"] as? String ?? "00:00:00")+"+00:00")
                                {
                                    if date < Date()
                                    {
                                        if let _ = dictionary["strHomeTeam"] as? String
                                        {
                                            if let _ = dictionary["strAwayTeam"] as? String
                                            {
                                                if let _ = dictionary["intHomeScore"] as? String
                                                {
                                                    if let _ = dictionary["intAwayScore"] as? String
                                                    {
                                                        self.modelsResults.append(Model1(strTeamHome: dictionary["strHomeTeam"] as! String, vs: "VS", strTeamWay: dictionary["strAwayTeam"] as! String, intHomeScore: dictionary["intHomeScore"] as! String, dash: "-", intWayScore: dictionary["intAwayScore"] as! String, dateEvent: dictionary["dateEvent"] as! String, strTime: dictionary["strTime"] as! String))
                                                           flag = false
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if let _ = dictionary["intRound"] as? String
                                            {
                                            self.modelsResults.append(Model1(strTeamHome:dictionary["strVenue"] as! String, vs:"" , strTeamWay: "", intHomeScore: "", dash: dictionary["intRound"] as! String, intWayScore: "", dateEvent: dictionary["dateEvent"] as! String, strTime: dictionary["strTime"] as! String))
                                            flag = false
                                            }
                                        }
                                    }
                                }
                            }
                            self.table.reloadData()
                        }
                            if flag
                            {
                                self.modelsResults.append(Model1(strTeamHome: "NO Data To Show", vs: "", strTeamWay: "", intHomeScore: "", dash: "", intWayScore: "", dateEvent: "", strTime: ""))
                                self.table.reloadData()
                                
                            }
            
                        }
                    }
                    else
                    {
                        self.modelsResults.append(Model1(strTeamHome: "NO Data To Show", vs: "", strTeamWay: "", intHomeScore: "", dash: "", intWayScore: "", dateEvent: "", strTime: ""))
                        self.table.reloadData()
                    }
        
        
                }
                catch
                {
                    print(error.localizedDescription)
                }
            }
            task.resume()
            table.reloadData()
        }
    }
    //MARK: - get all teams
    func getAllTeams()
    {
      //strLeague = strLeague.replacingOccurrences(of: " ", with: "_")
      let myURLString = "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(strLeague)"
      print(myURLString)
      let urlString = myURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
      if let url = URL(string: urlString!)
      {
          let req = URLRequest(url: url)
          let session = URLSession(configuration: URLSessionConfiguration.default)
          let task = session.dataTask(with: req) { data, response, error in
              do
              {
                  let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as!
                  Dictionary<String,Any>
                  if let dicLeagues = json["teams"] as? [Dictionary<String,Any>]
                  {
                      DispatchQueue.main.async
                      {
                      for dictionary in dicLeagues
                      {
                          if let _ = dictionary["strTeamBadge"] as? String
                          {
                              
                              if let _ = dictionary["intFormedYear"] as? String
                              {
                                    if let _ = dictionary["strCountry"] as? String
                                  {
                                    if let _ = dictionary["strTeamJersey"] as? String
                                    {
                                    if let _ = dictionary["strFacebook"] as? String
                                    {
                                    if let _ = dictionary["strYoutube"] as? String
                                    {
                                    if let _ = dictionary["strTeam"] as? String
                                    {
                                        self.modelsTeams.append(Model2(strBadge: dictionary["strTeamBadge"] as! String, intFormedYear: dictionary["intFormedYear"] as! String, strCountry: dictionary["strCountry"] as! String, strStadiumThumb: dictionary["strStadiumThumb"] as? String ?? "https://www.thesportsdb.com/images/media/team/stadium/w1anwa1588432105.jpg", strTeamJersey: dictionary["strTeamJersey"] as! String, strFacebook: dictionary["strFacebook"] as! String, strYoutube: dictionary["strYoutube"] as! String, strTeam: dictionary["strTeam"] as! String))
                                        self.table.reloadData()
                                    }
                                    }
                                    }
                                    }
                              }
                          }
                          }
                      }
                      }
                  }
                  else
                  {
                      self.modelsTeams.append(Model2(strBadge: "No Event To Show", intFormedYear: "", strCountry: "", strStadiumThumb: "", strTeamJersey: "", strFacebook: "", strYoutube: "", strTeam: ""))
                      self.table.reloadData()
                  }
      
      
              }
              catch
              {
                  print(error.localizedDescription)
              }
          }
          task.resume()
          table.reloadData()
      }
    }
}
extension LeaguesDetails : TeamDetailsDelegate
{
    func TeamDetailsDelegateDidTapItem(model: Model2) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "TeamDetails" ) as! TeamDetails
        vc.model = model
        self.present(vc, animated: true)
    }
}




 
