//
//  NewUserViewController.swift
//  Happy Ivy
//
//  Created by Jake on 2/8/18.
//  Last modified: 2/9/18
//  Copyright © 2018 Happy Ivy App. All rights reserved.
//

import UIKit
import CoreData

class NewUserViewController: UIViewController {
    
    // Get height and width of screen values
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    // Outlet for bucket button
    @IBOutlet weak var bucketButtonOutlet: UIButton!
    
    // Called when bucket button is pressed
    @IBAction func bucketButton(_ sender: Any) {
        
        // Hide button
        bucketButtonOutlet.isHidden = true
        
        // Set adopt plant background
        let adoptPlantBackground : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        adoptPlantBackground.image = UIImage(named: "adopt-plant-background.png")
        self.view.addSubview(adoptPlantBackground)
        
        // Get center of screen
        let xCenter = CGRect(x:0, y: 0, width: width, height: height).midX
        let yCenter = CGRect(x:0, y: 0, width: width, height: height).midY
        
        // Add input text field
        // derived from https://stackoverflow.com/questions/24710041/adding-uitextfield-on-uiview-programmatically-swift/32602425
        let textField : UITextField = UITextField(frame: CGRect(x: xCenter-75, y: yCenter-80, width: 150, height: 30))
        textField.placeholder = "Type Name...";
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate = self
        self.view.addSubview(textField)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add new user background image
        let NewUserBackground : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        NewUserBackground.image = UIImage(named: "new-user-background.png")
        self.view.addSubview(NewUserBackground)
        
    }
    
    // MARK: Save
    
    /**
     Saves input string as user name to User entity in Model data model
     
     - Parameters:
     - name: the user name to be saved
     */
    func saveName(name: String) {
        
        // Instatiate appDelegate and managedContext
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Declare user object to hold the first User data entry
        var user : NSObject
        
        // Initialize an entry in data model.
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        user = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set entry value for name
        user.setValue(name, forKeyPath: "name")
        
        // Perform built in save function
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}

// MARK:- ---> UITextFieldDelegate

extension NewUserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        saveName(name: textField.text!)
        performSegue(withIdentifier: "goToPlantViewFromNewUser", sender: NewUserViewController.self)
        return true
    }
    
}

// MARK: UITextFieldDelegate <---

