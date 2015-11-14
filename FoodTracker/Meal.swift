//
//  Meal.swift
//  FoodTracker
//
//  Created by flybywind on 15/11/14.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class Meal {
    // MARK: Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
}
