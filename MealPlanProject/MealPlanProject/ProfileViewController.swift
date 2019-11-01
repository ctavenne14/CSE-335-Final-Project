//
//  ProfileViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 4/15/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPic: UIImageView!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MealEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.fetchLimit = 1
        //var error : NSError?
        do{
            let result = try self.managedObjectContext.fetch(request)
        if let objects = result as? [MealEntity] {
            for obj in objects {
                self.mealName.text = obj.name
                self.mealPic.image = UIImage(data: obj.picture! as Data)
            }
        } else {
            print("fetch failed")
        }
        }
        catch{
        
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserEntity",in: managedObjectContext)
        // create a fetch request
        let request2: NSFetchRequest<UserEntity> = UserEntity.fetchRequest() as NSFetchRequest<UserEntity>
        
        // associate the request with contact handler
        request2.entity = entityDescription
       // let isON = true
        // build the search request predicate (query)
        let pred = NSPredicate(format: "online == %@", NSNumber(value: true))
        request2.predicate = pred
        
        // perform the query and process the query results
        do {
            var results =
                try managedObjectContext.fetch(request2 as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                
                
                name.text = match.value(forKey: "name") as? String
                email.text = match.value(forKey: "email") as? String

                
                
            } else {
                print("No Match")
            }
            
        } catch let error {
            print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
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
