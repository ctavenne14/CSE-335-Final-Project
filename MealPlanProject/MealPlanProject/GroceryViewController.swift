//
//  GroceryViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/15/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import CoreData

class GroceryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groceryTable: UITableView!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchResults = [GroceryEntity]()
    var counter = 1
    func fetchRecord() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"GroceryEntity")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        var x = 0
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [GroceryEntity])!
        
        x = fetchResults.count
        
        print(x)
        
        return x
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //initCounter()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "grocery1", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.textLabel?.text = fetchResults[indexPath.row].name
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            // delete the selected object from the managed
            // object context
            managedObjectContext.delete(fetchResults[indexPath.row])
            // remove it from the fetch results array
            fetchResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try managedObjectContext.save()
            } catch {
                
            }
            // reload the table after deleting a row
            groceryTable.reloadData()
        }
        
    }

    @IBAction func addGrocery(_ sender: UIBarButtonItem) {
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "GroceryEntity", in: self.managedObjectContext)
        //add to the manege object context
        let newItem = GroceryEntity(entity: ent!, insertInto: self.managedObjectContext)
        newItem.name = "Grocery"
        newItem.details = "Details";
        
        // one more item added
       // updateCounter()
        
        
        
        // show the alert controller to select an image for the row
        let alertController = UIAlertController(title: "Add Grocery", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the Grocery Item Here"
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Details of the Grocery Item Here"
        })
        
        
        
        let compAction = UIAlertAction(title: "Add", style: .default) { (action) in
            if let name = alertController.textFields?.first?.text{
                newItem.name = name
                let det = alertController.textFields?[1].text
                newItem.details = det
                self.groceryTable.reloadData()

        }
        }
        
        
        alertController.addAction(compAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        groceryTable.reloadData()

        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
        groceryTable.reloadData()

        
        print(newItem)
        // reload the table with added row
        // this happens before getting the image, so first we add the row
        // without the image and then add the image
    }
    
    /*func updateLastRow() {
        let indexPath = IndexPath(row: fetchResults.count - 1, section: 0)
        groceryTable.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func initCounter() {
        counter = UserDefaults.init().integer(forKey: "counter")
    }
    
    func updateCounter() {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    } */
    
    @IBAction func returnedMapView(segue: UIStoryboardSegue)
    {
        print("Coming from Map View")
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
