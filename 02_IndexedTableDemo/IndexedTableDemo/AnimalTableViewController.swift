//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Simon Ng on 3/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var animalsDict = [String: [String]]()
    var animalSectionTitles = [String]()
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    /*let animals: [String: [String]] = ["B" : ["Bear", "Black Swan", "Buffalo"],
                                       "C" : ["Camel", "Cockatoo"],
                                       "D" : ["Dog", "Donkey"],
                                       "E" : ["Emu"],
                                       "G" : ["Giraffe", "Greater Rhea"],
                                       "H" : ["Hippopotamus", "Horse"],
                                       "K" : ["Koala"],
                                       "L" : ["Lion", "Llama"],
                                       "M" : ["Manatus", "Meerkat"],
                                       "P" : ["Panda", "Peacock", "Pig", "Platypus", "Polar Bear"],
                                       "R" : ["Rhinoceros"],
                                       "S" : ["Seagull"],
                                       "T" : ["Tasmania Devil"],
                                       "W" : ["Whale", "Whale Shark", "Wombat"]
    ]
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnimalDict()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return animalSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let animalKey = animalSectionTitles[section]
        guard let animalValues = animalsDict[animalKey] else {
            return 0
        }
        
        return animalValues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let animalKey = animalSectionTitles[indexPath.section]
        if let animalValues = animalsDict[animalKey] {
            cell.textLabel?.text = animalValues[indexPath.row]
            
            let imageFilename = animalValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFilename)
        }
        
        return cell
        
    }
    
    

    func createAnimalDict() {
        for animal in animals {
            let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
            let animalKey = String(animal[..<firstLetterIndex])
            
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
        }
        animalSectionTitles = [String](animalsDict.keys)
        animalSectionTitles = animalSectionTitles.sorted(by: { $0 < $1 })
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return animalSectionTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = animalSectionTitles.firstIndex(of: title) else {
            return -1
        }
        return index
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        headerView.textLabel?.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0,
                                                  blue: 60.0/255.0, alpha: 1.0)
        
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    

}


}
