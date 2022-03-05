//
//  DBManager.swift
//  Sports
//
//  Created by Mohamed Kamal on 23/02/2022.
//

import Foundation
import UIKit
import CoreData

class DBManager
{
    var names = [String]()
    var strLeagues = [String]()
    var strBadges = [String]()
    var strYoutubes = [String]()
    var idLeagues = [String]()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let shared = DBManager()
    private init()
    {
        
    }
    
    // MARK: - add to favorites
    func addFavorite(strLeague: String,strYoutube: String,strBadge: String,idLeague: String) -> Bool
    {
        if !checkIfItemExist(strLeague: strLeague)
        {
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Favorite", in : managedContext)!
            let favorites = NSManagedObject(entity: entity, insertInto: managedContext)
            favorites.setValue(strLeague, forKey: "strLeagues")
            favorites.setValue(strYoutube, forKey: "strYoutubes")
            favorites.setValue(strBadge, forKey: "strBadges")
            favorites.setValue(idLeague, forKey: "idLeagues")
            do
            {
                try managedContext.save()
                print("Record Added!")
            }
            catch let error as NSError
            {
                print("Could not save. \(error),\(error.userInfo)")
            }
            return true
        }
        
        return false

    }
    // MARK: - get Favorites
    func getFavorites()
    {
        strBadges.removeAll()
        strLeagues.removeAll()
        strYoutubes.removeAll()
        idLeagues.removeAll()
        var managedObject : [NSManagedObject]!
        managedObject = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        let managedContext = appDelegate.persistentContainer.viewContext
        do
        {
            managedObject = try managedContext.fetch(fetchRequest)
            for i in 0..<managedObject.count
            {
                strLeagues.append(managedObject[i].value(forKey: "strLeagues") as! String)
                strYoutubes.append(managedObject[i].value(forKey: "strYoutubes") as! String)
                strBadges.append(managedObject[i].value(forKey: "strBadges") as! String)
                idLeagues.append(managedObject[i].value(forKey: "idLeagues") as! String)

            }
        }
        catch let error as NSError
        {
            print(error)
        }
    }
    // MARK: - check if item exist
    func checkIfItemExist(strLeague: String) -> Bool {

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "strLeagues == %@" ,strLeague)

        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    // MARK: - delete data from favorite
    func deleteData(_ entity:String,strLeague: String) {
        if checkIfItemExist(strLeague: strLeague)
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "strLeagues == %@", strLeague)
            do {
                let results = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
                for object in results {
                    guard let objectData = object as? NSManagedObject else {continue}
                    appDelegate.persistentContainer.viewContext.delete(objectData)
                }
            } catch let error {
                print("Detele data in \(entity) error :", error)
            }
            try! appDelegate.persistentContainer.viewContext.save()
            
        }
    }
    // MARK: - add countrys names
    func addCountrysNames()
    {

        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CountryName", in : managedContext)!
        for name in names
        {
            let countrys = NSManagedObject(entity: entity, insertInto: managedContext)
            countrys.setValue(name, forKey: "name")
            do
            {
                try managedContext.save()
                print("Record Added!")
            }
            catch let error as NSError
            {
                print("Could not save. \(error),\(error.userInfo)")
            }
        
        }

    }
    // MARK: - get countrys names
    func getCountrysNames()
    {
        names.removeAll()
        var managedObject : [NSManagedObject]!
        managedObject = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CountryName")
        let managedContext = appDelegate.persistentContainer.viewContext
        do
        {
            managedObject = try managedContext.fetch(fetchRequest)
            for i in 0..<managedObject.count
            {
                names.append(managedObject[i].value(forKey: "name") as! String)
            }
        }
        catch let error as NSError
        {
            print(error)
        }
    }
    // MARK: - delete all data from entity
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                appDelegate.persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
