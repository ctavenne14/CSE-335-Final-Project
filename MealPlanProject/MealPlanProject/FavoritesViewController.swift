//
//  FavoritesViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/15/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favoriteTable: UITableView!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchResults = [MealEntity]()
    
    func fetchRecord() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"MealEntity")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x = 0
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [MealEntity])!
        
        x = fetchResults.count
        
        print(x)
        
        return x
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fav1", for: indexPath)
        cell.layer.borderWidth = 1.0
        if fetchResults[indexPath.row].fav == true
        {
            cell.textLabel?.text = fetchResults[indexPath.row].name
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
