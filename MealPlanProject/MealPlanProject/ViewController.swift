//
//  ViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 3/9/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLoginView"
        {
            print("Going to Login View")
        }
        else if segue.identifier == "toCreateUserView"
        {
            print("Going to Create User View")
        }
    }
    
    @IBAction func returnedLogin(segue: UIStoryboardSegue)
    {
        print("Coming from Login View")
    }
    
    @IBAction func returnedCreateUser(segue: UIStoryboardSegue)
    {
        print("Coming from Create User View")
    }



}

