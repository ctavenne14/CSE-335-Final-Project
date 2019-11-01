//
//  LoginViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 3/9/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "UserEntity",
                                       in: managedObjectContext)
        // create a fetch request
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        // associate the request with contact handler
        request.entity = entityDescription
        
        // build the search request predicate (query)
        let pred = NSPredicate(format: "(email = %@)", email.text!)
        request.predicate = pred
        
        // perform the query and process the query results
        do {
            var results =
                try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                
                if email.text == match.value(forKey: "email") as? String && password.text == match.value(forKey: "password") as? String {
                    match.setValue(true, forKey: "online")
                    performSegue(withIdentifier: "toMealPlanView", sender: self)
                }
                else
                {
                    let alertController = UIAlertController(title: "Error", message: "No match", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    }
                    
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            } else {
                let alertController = UIAlertController(title: "Error", message: "No match", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        } catch let error {
            print(error.localizedDescription)
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
