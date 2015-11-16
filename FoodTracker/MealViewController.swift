//
//  MealViewController.swift
//  FoodTracker
//
//  Created by flybywind on 15/11/13.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    // mark注释能帮助Xcode分类显示代码结构。
    // 注意不要多次绑定一个控件，否则会出现错误：
    // this class is not key value coding-compliant for the key
    // 此时需要去connection inspector中检查一下，删除重复的绑定！
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var ratingCtrl: RatingCtrl!
    
    @IBOutlet weak var saveMeal: UIBarButtonItem!
    /*
    这个值可以来自2个途径：MealTableViewController的prepareForSegue函数，此时是一个已经存在的meal，或者save按钮按下之后，此时是创建一个meal。
    */
    var meal: Meal?
    
    // MARK: delegate functions
    //  gets called when the user taps Return (or in this case, Done) on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        return mealName.resignFirstResponder()
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if validateMealName() {
            navigationItem.title = mealName.text!
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: own method
    func validateMealName() -> Bool {
        if let meal_name = mealName.text where meal_name == "" {
            saveMeal.enabled = false
            return true
        } else {
            saveMeal.enabled = true
            return false
        }
    }
    // MARK: overide
    override func viewDidLoad() {
        super.viewDidLoad()
        mealName.delegate = self
        
        if let m = meal {
            navigationItem.title = m.name
            mealName.text = m.name
            imageView.image = m.photo
            ratingCtrl.rating = m.rating
        }
        validateMealName()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: actions
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }else {
            // The else clause gets executed when the meal scene was pushed onto the navigation stack on top of the meal list scene
            navigationController?.popViewControllerAnimated(true)
        }
    }
    @IBAction func selectImage(sender: UITapGestureRecognizer) {
        
        mealName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (sender === saveMeal) {
            let name = mealName.text ?? ""
            let photo = imageView.image
            let rating = ratingCtrl.rating
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
}

