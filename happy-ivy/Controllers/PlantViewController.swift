//
//  ViewController.swift
//  happy-ivy
//
//  Created by Jake Johnson on 2/8/18.
//  Last modified: 2/9/18
//  Copyright © 2018 Happy Ivy App. All rights reserved.
//

import UIKit
import CoreData

class PlantViewController: UIViewController {

    // User Managed Object
    var User: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //* TODO: put the user variable and all these lines of code into a global class (as well as User Managed Object)
        //      See https://stackoverflow.com/questions/24333142/access-variable-in-different-class-swift
        
        // Get User Data store in user
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do { User = try managedContext.fetch(fetchRequest) }
            catch let error as NSError { print("Could not fetch. \(error), \(error.userInfo)") }
        let user : NSObject = User[0]
        
        // Set background color
        self.view.backgroundColor = UIColor(red:0.98, green:0.89, blue:0.84, alpha:1.0)
        
        // Get height, width, and x/y center of screen values
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let xCenter = CGRect(x:0, y: 0, width: width, height: height).midX
        let yCenter = CGRect(x:0, y: 0, width: width, height: height).midY
        
        // Add plant image
        let plantImageView : UIImageView = UIImageView(frame: CGRect(x: xCenter-(width/2), y: yCenter-(187.5), width: width, height: 375))
        plantImageView.image = UIImage(named: "new-plant.png")
        self.view.addSubview(plantImageView)
        
        // Add plant label
        let plantNameLabel : UILabel = UILabel(frame: CGRect(x: xCenter-100, y: yCenter-262.25, width: 200, height: 60))
        plantNameLabel.font = UIFont.systemFont(ofSize: 15)
        let resizedNameLabelImage = resizeImage(image: UIImage(named: "plant-name-label-bkgnd.png")!, targetSize: CGSize(width: 200, height: 60))
        plantNameLabel.backgroundColor = UIColor(patternImage: resizedNameLabelImage)
        plantNameLabel.text = user.value(forKey: "name") as? String // add user's name
        plantNameLabel.textColor = UIColor(red:0.94, green:0.66, blue:0.50, alpha:1.0)
        plantNameLabel.font = UIFont(name: "ArialMT", size: 20)
        plantNameLabel.textAlignment = NSTextAlignment.center
        /* // Properties of label shadow
        plantNameLabel.layer.shadowColor = UIColor.black.cgColor
        plantNameLabel.layer.shadowRadius = 3.0
        plantNameLabel.layer.shadowOpacity = 0.05
        plantNameLabel.layer.shadowOffset = CGSize(width: 2, height: 4)
        plantNameLabel.layer.masksToBounds = false*/
        self.view.addSubview(plantNameLabel)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     Resizes an image
     */
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }


}

