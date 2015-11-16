//
//  Meal.swift
//  FoodTracker
//
//  Created by flybywind on 15/11/14.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class Meal:NSObject, NSCoding {
    // MARK: Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory,
        inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        // 必须放到stored properties的初始化下面
        // 因为继承了父类，init又是designated init，所以需要调用super.init
        super.init()
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(photo, forKey: "photo")
        aCoder.encodeInteger(rating, forKey: "rating")
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("name") as! String
        let photo = aDecoder.decodeObjectForKey("photo") as? UIImage
        let rating = aDecoder.decodeIntegerForKey("rating")
        
        self.init(name: name, photo: photo, rating: rating)
    }
    
}
