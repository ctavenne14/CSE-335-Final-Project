//
//  MealPlanViewController.swift
//  MealPlanProject
//
//  Created by Cody Tavenner on 3/9/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import CoreData

class MealPlanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mealTable: UITableView!
    @IBOutlet weak var food: UITextField!
    
    var counter = 1
    
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
        initCounter()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meal1", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.textLabel?.text = fetchResults[indexPath.row].name
        
        if let picture = fetchResults[indexPath.row].picture {
            cell.imageView?.image =  UIImage(data: picture  as Data)
        } else {
            cell.imageView?.image = nil
        }
        
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
            mealTable.reloadData()
        }
        
    }
    
    @IBAction func addMeal(_ sender: UIBarButtonItem) {
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "MealEntity", in: self.managedObjectContext)
        //add to the manege object context
        let newItem = MealEntity(entity: ent!, insertInto: self.managedObjectContext)
        newItem.name = "Meal"
        newItem.instructions = "Instructions"
        newItem.ingredients = "Ingredients"
        newItem.picture = nil
        newItem.date = NSDate()
        print(newItem.date?.description)
        
        // one more item added
        updateCounter()
        
        
        
        // show the alert controller to select an image for the row
        let alertController = UIAlertController(title: "Add Meal", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the Meal Here"
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Instructions of the Meal Here"
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Ingredients of the Meal Here"
        })
        
        let serachAction = UIAlertAction(title: "Picture", style: .default) { (action) in
            if let name = alertController.textFields?.first?.text{
                newItem.name = name
                let det = alertController.textFields?[1].text
                newItem.instructions = det
                let det1 = alertController.textFields?[2].text
                newItem.ingredients = det1
            }
            // load image
            let photoPicker = UIImagePickerController ()
            photoPicker.delegate = self
            photoPicker.sourceType = .photoLibrary
            // display image selection view
            self.present(photoPicker, animated: true, completion: nil)
            
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            if let name = alertController.textFields?.first?.text{
                newItem.name = name
                let det = alertController.textFields?[1].text
                newItem.instructions = det
                let det1 = alertController.textFields?[2].text
                newItem.ingredients = det1
            }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                self.present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
        
        
        
        
        
        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
        
        
        print(newItem)
        // reload the table with added row
        // this happens before getting the image, so first we add the row
        // without the image and then add the image
        mealTable.reloadData()
    }
    
    func updateLastRow() {
        let indexPath = IndexPath(row: fetchResults.count - 1, section: 0)
        mealTable.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func initCounter() {
        counter = UserDefaults.init().integer(forKey: "counter")
    }
    
    func updateCounter() {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.mealTable.indexPath(for: sender as! UITableViewCell)!
        
        let meal = fetchResults[selectedIndex.row].name
        
        
        
        if(segue.identifier == "toDetailView"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedMeal = meal;
            }
        }
        
        
    }
    
    @IBAction func onlineRecipe(_ sender: UIButton) {
        DispatchQueue.main.async(execute: {
            self.getJsonData()
        })
        
    }
    
    func getJsonData(){
        let fName = food.text
        
        let urlAsString = "http://www.recipepuppy.com/api/?q="+fName!+"&p=1"
        
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            print(jsonResult)
            
            
            let setOne = jsonResult["results"]! as! NSArray
            
            
            let y = setOne[0] as? [String: AnyObject]
            
            print(y!["title"]!)
            print(y!["ingredients"]!)
            
            let title: String = (y!["title"] as? NSString)! as String
            let ing: String = (y!["ingredients"] as? NSString)! as String
            
            let ent = NSEntityDescription.entity(forEntityName: "MealEntity", in: self.managedObjectContext)
            //add to the manege object context
            let newItem = MealEntity(entity: ent!, insertInto: self.managedObjectContext)
            newItem.name = title
            newItem.instructions = "Instructions can be found on RecipePuppy.com"
            newItem.ingredients = ing
            let pic = UIImage(named: "homepic.jpg")
            newItem.picture = pic!.pngData()! as NSData
            
            // one more item added
            self.updateCounter()
            
            do {
                try self.managedObjectContext.save()
            } catch _ {
            }
           
            
            
            
            
            print(newItem)
            // reload the table with added row
            // this happens before getting the image, so first we add the row
            // without the image and then add the image
            DispatchQueue.main.async
                {
                    self.mealTable.reloadData()
                    
            }
            
        })
        
        jsonQuery.resume()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker .dismiss(animated: true, completion: nil)
        
        // fetch resultset has the recently added row without the image
        // this code ad the image to the row
        if let meal = fetchResults.last, let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            meal.picture = image.pngData()! as NSData
            //update the row with image
            updateLastRow()
            do {
                try managedObjectContext.save()
            } catch {
                print("Error while saving the new image")
            }
            
        }
        
    }
    
    @IBAction func returnedDetailView(segue: UIStoryboardSegue)
    {
        print("Coming from Detail View")
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
