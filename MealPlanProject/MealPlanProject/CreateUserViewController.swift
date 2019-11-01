//
//  CreateUserViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 3/9/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import CoreData

class CreateUserViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm: UITextField!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func create(_ sender: UIButton) {
        if name.text!.isEmpty || email.text!.isEmpty || password.text!.isEmpty || confirm.text!.isEmpty{
            let alertController = UIAlertController(title: "Error", message: "The textfields cannot be empty", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

            
        }
        else
        {
            if password.text == confirm.text{
                let ent = NSEntityDescription.entity(forEntityName: "UserEntity", in: self.managedObjectContext)
                
                // create a contact object instance for insert
                let user = UserEntity(entity: ent!, insertInto: managedObjectContext)
                
                // add data to each field in the entity
                user.name = name.text!
                user.email = email.text!
                user.password = password.text!
                
                // save the new entity
                do {
                    try managedObjectContext.save()
                    
                } catch let error {
                    print(error.localizedDescription)
                }
                performSegue(withIdentifier: "toMealPlanView", sender: self)
            }
            else
            {
                let alertController = UIAlertController(title: "Error", message: "The passwords must match", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)

                
            }
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
