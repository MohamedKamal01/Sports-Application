//
//  Countrys.swift
//  Sports
//
//  Created by Mohamed Kamal on 02/03/2022.
//

import UIKit


class Countrys: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var searchBar: UISearchBar!
    var strSport: String = ""
    var countryNames = [String]()
    var countrys = [String]()
    //var filteredData: [String]!
    var allCountys = [CountryModel]()
    

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            countryNames.removeAll()
        //searchBar.text = ""
        //DBManager.shared.getCountrysNames()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.delegate = self
        tableView.dataSource = self
        //searchBar.delegate = self
        //filteredData = DBManager.shared.names
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(buttonTapped))
        title = "Countrys"
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.setEditing(true, animated: false)
        tableView.reloadData()
        }
    override func viewDidLoad() {
    super.viewDidLoad()

        getAllSports()
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
    cell.textLabel?.text = countrys[indexPath.row]
    return cell
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countrys.count
}

// This method updates filteredData based on the text in the Search Box
//func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    filteredData = searchText.isEmpty ? DBManager.shared.names : DBManager.shared.names.filter({(dataString: String) -> Bool in
//
//        return dataString.range(of: searchText, options: .caseInsensitive) != nil
//    })

//    tableView.reloadData()
//}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        countryNames.append(countrys[indexPath.row])
        }
   
    @objc fileprivate func buttonTapped()
    {

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Leagues = storyBoard.instantiateViewController(withIdentifier: "Leagues") as! Leagues
        self.navigationController?.pushViewController(Leagues, animated: true)
        Leagues.strSport = strSport
        Leagues.countrysNames = countryNames
    }
    func getAllSports()
    {
        ServerData.shared.getAllCountryes { (result) in
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
    func updateUI(with sports: [CountryModel]) {
            DispatchQueue.main.async {
                self.allCountys = sports
                for i in 0..<sports.count
                {
                    self.countrys.append(sports[i].name_en)
                    print(sports[i].name_en)
                }
                self.tableView.reloadData()
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
