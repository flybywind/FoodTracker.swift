//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by flybywind on 15/11/15.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            loadSampleMeals()
        }
    }
    func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")!
        let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4)!
        
        let photo2 = UIImage(named: "meal2")!
        let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "meal3")!
        let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3)!
        
        meals += [meal1, meal2, meal3]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Sections are visual groupings of cells within table views, which is especially useful in table views with a lot of data. For a simple table view like the one in the FoodTracker app, you just need the table view to display a single section
        return 1
    }
    // tells the table view how many rows to display in a given section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell


        let m = meals[indexPath.row]
        cell.nameLabel.text = m.name
        cell.photoImageView.image = m.photo
        cell.ratingControl.rating = m.rating
        return cell
    }
    
    // 通过sourceViewController和destinationViewController传输数据
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? MealViewController, meal = sourceViewController.meal {
            if let selectRow = tableView.indexPathForSelectedRow {
                // update an existing meal
                meals[selectRow.row] = meal
                tableView.reloadRowsAtIndexPaths([selectRow], withRowAnimation: .None)
            } else {
                // Add a new meal.
                let newIndexPath = NSIndexPath(forRow: meals.count, inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveMeals()
        }
    }
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveMeals()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowDetail"){
            let mealCtrl = segue.destinationViewController as! MealViewController
            if let mealSelect = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(mealSelect)!
                let m = meals[indexPath.row]
                mealCtrl.meal = m
            }
        }else if (segue.identifier == "AddItem"){
            print("Add new Meal")
        }
    }
    // MARK: persist data
    func saveMeals() {
        if NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!) {
            print("save meals successfully")
        } else {
            print("failed to save meals")
        }
    }
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }

}
