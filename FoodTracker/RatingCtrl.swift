//
//  RatingCtrl.swift
//  FoodTracker
//
//  Created by flybywind on 15/11/13.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

class RatingCtrl: UIView {
    // MARK: Properties
    var rating:Int = 4 {
        didSet {
        // setNeedsLayout() which will trigger a layout update every time the rating changes. This ensures that the UI is always showing an accurate representation of the rating property value.
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let btGap:CGFloat = 5
    let starsNum = 5
    
    // MARK: Initialization
    // Every UIView subclass that implements an initializer must include an implementation of init?(coder:). The Swift compiler knows this, and offers a fix-it to make this change in your code. Fix-its are provided by the compiler as potential solutions to errors in your code.
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let img0 = UIImage(named: "emptyStar")
        let img1 = UIImage(named: "activeStar")
        for _ in 0..<starsNum {
            let b = UIButton()
            b.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            b.setImage(img0, forState: .Normal)
            b.setImage(img1, forState: .Selected)
            b.setImage(img1, forState: [.Selected, .Highlighted])
            addSubview(b)
            ratingButtons.append(b)
        }
    }
    override func intrinsicContentSize() -> CGSize {
        let btSize = frame.size.height

        return CGSize(width: (btSize+btGap)*CGFloat(starsNum), height: btSize)
    }
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
    }
    override func layoutSubviews() {
        let btHeight = frame.size.height
        var btRect = CGRect(x: 0, y: 0, width: btHeight, height: btHeight)
        for (i, b) in ratingButtons.enumerate() {
            btRect.origin.x = CGFloat(i) * (btHeight + btGap)
            b.frame = btRect
        }
        updateButtonSelectionStates()
    }
    func updateButtonSelectionStates() {
        for (i, b) in ratingButtons.enumerate() {
            b.selected = i < rating
        }
    }
}
