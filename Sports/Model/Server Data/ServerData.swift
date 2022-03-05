//
//  ServerData.swift
//  Sports
//
//  Created by Mohamed Kamal on 28/02/2022.
//

import Foundation
class ServerData
{
    static let shared = ServerData()
    private init(){}
    
    // MARK: - fetch all sports
    func getAllSports(completion: @escaping (Result<[SportModel], Error>) -> Void)
    {
        
        let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php")
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
        if let data = data
        {
            do
            {
                let json = try  JSONDecoder().decode(AllSportsModel.self, from: data)
                completion(.success(json.sports))
            } catch {
                completion(.failure(error))
            }
        }
        else if let error = error
        {
            completion(.failure(error))
        }
        }
        task.resume()
    }
    // MARK: - fetch all leagues for spacific sport
    func getAllLeagues(country: String, sport: String,completion: @escaping(Result<[LeagueModel],Error>) -> Void)
    {
        if let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=\(country.replacingOccurrences(of: " ", with: "_"))&s=\(sport.replacingOccurrences(of: " ", with: "_"))")
        {
        let req = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
        if let data = data
        {
            do
            {
                let json = try JSONDecoder().decode(AllLeaguesModel.self, from: data)
                completion(.success(json.countrys))
            }
            catch
            {
                completion(.failure(error))
            }
                    
        }
        else if let error = error
        {
            completion(.failure(error))
        }
                
        }
            task.resume()
        }
    
        

    }
    //MARK: - get all countryes
    func getAllCountryes(completion: @escaping (Result<[CountryModel], Error>) -> Void)
    {
        
        let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_countries.php")
        let req = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: req) { data, response, error in
        if let data = data
        {
            do
            {
                let json = try  JSONDecoder().decode(AllCountryModel.self, from: data)
                completion(.success(json.countries))
            } catch {
                completion(.failure(error))
            }
        }
        else if let error = error
        {
            completion(.failure(error))
        }
        }
        task.resume()
    }
    
    
}
