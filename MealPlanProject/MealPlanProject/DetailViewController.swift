//
//  DetailViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/14/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPic: UIImageView!
    @IBOutlet weak var choose: UISegmentedControl!
    @IBOutlet weak var details: UILabel!
    var selectedMeal:String?
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        let entityDescription = NSEntityDescription.entity(forEntityName: "MealEntity",in: managedObjectContext)
        // create a fetch request
        let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest() as NSFetchRequest<MealEntity>
        
        // associate the request with contact handler
        request.entity = entityDescription
        
        // build the search request predicate (query)
        let pred = NSPredicate(format: "(name = %@)", selectedMeal!)
        request.predicate = pred
        
        // perform the query and process the query results
        do {
            var results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                
                
                mealName.text = match.value(forKey: "name") as? String
                let img = match.value(forKey: "picture") as? NSData
                mealPic.image = UIImage(data: img! as Data)
                details.text = match.value(forKey: "ingredients") as? String
                
                
            } else {
                details.text = "No Match"
            }
            
        } catch let error {
            details.text = error.localizedDescription
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func displayText(_ sender: UISegmentedControl) {
        let getIndex = choose.selectedSegmentIndex
        
        switch (getIndex)
        {
        case 0:
            let entityDescription = NSEntityDescription.entity(forEntityName: "MealEntity",in: managedObjectContext)
            // create a fetch request
            let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest() as NSFetchRequest<MealEntity>
            
            // associate the request with contact handler
            request.entity = entityDescription
            
            // build the search request predicate (query)
            let pred = NSPredicate(format: "(name = %@)", selectedMeal!)
            request.predicate = pred
            
            // perform the query and process the query results
            do {
                var results =
                    try managedObjectContext.fetch(request as!
                        NSFetchRequest<NSFetchRequestResult>)
                
                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    
                    
                    
                    mealName.text = match.value(forKey: "name") as? String
                    let img = match.value(forKey: "picture") as? NSData
                    mealPic.image = UIImage(data: img! as Data)
                    details.text = match.value(forKey: "ingredients") as? String

                    
                } else {
                    details.text = "No Match"
                }
                
            } catch let error {
                details.text = error.localizedDescription
            }
        case 1:
            let entityDescription = NSEntityDescription.entity(forEntityName: "MealEntity",in: managedObjectContext)
            // create a fetch request
            let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest() as NSFetchRequest<MealEntity>
            
            // associate the request with contact handler
            request.entity = entityDescription
            
            // build the search request predicate (query)
            let pred = NSPredicate(format: "(name = %@)", selectedMeal!)
            request.predicate = pred
            
            // perform the query and process the query results
            do {
                var results =
                    try managedObjectContext.fetch(request as!
                        NSFetchRequest<NSFetchRequestResult>)
                
                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    
                    
                    
                    mealName.text = match.value(forKey: "name") as? String
                    let img = match.value(forKey: "picture") as? NSData
                    mealPic.image = UIImage(data: img! as Data)
                    details.text = match.value(forKey: "instructions") as? String

                    
                } else {
                    details.text = "No Match"
                }
                
            } catch let error {
                details.text = error.localizedDescription
            }
        
        default:
            print("default")
        }
        
    }
    @IBAction func favorite(_ sender: UIBarButtonItem) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "MealEntity",in: managedObjectContext)
        // create a fetch request
        let request: NSFetchRequest<MealEntity> = MealEntity.fetchRequest() as NSFetchRequest<MealEntity>
        
        // associate the request with contact handler
        request.entity = entityDescription
        
        // build the search request predicate (query)
        let pred = NSPredicate(format: "(name = %@)", selectedMeal!)
        request.predicate = pred
        
        // perform the query and process the query results
        do {
            var results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                
                
                mealName.text = match.value(forKey: "name") as? String
                let img = match.value(forKey: "picture") as? NSData
                mealPic.image = UIImage(data: img! as Data)
                details.text = match.value(forKey: "ingredients") as? String
                match.setValue(true, forKey: "fav")
                let alertController = UIAlertController(title: "Favorites", message: "Meal added to favorites", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Error while saving the new image")
                }
                
                
            } else {
                details.text = "No Match"
            }
            
        } catch let error {
            details.text = error.localizedDescription
        }
        
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
