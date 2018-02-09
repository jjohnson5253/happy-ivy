//
//  InitialViewController.swift
//  happy-ivy
//
//  Created by Jake Johnson on 2/8/18
//  Last modified: 2/9/18
//  Copyright © 2018 Happy Ivy App. All rights reserved.
//

import UIKit
import CoreData

class InitialViewController: UIViewController {

    // User managed object
    var User: [NSManagedObject] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        // Get User entity data from Model data model and store in User managed object
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do { User = try managedContext.fetch(fetchRequest) }
        catch let error as NSError { print("Could not fetch. \(error), \(error.userInfo)") }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // If no use data, segue to new user view
        if User.count == 0{
            self.performSegue(withIdentifier: "goToNewUserView", sender: self)
        }
        // Else segue to plant view
        else{
            self.performSegue(withIdentifier: "goToPlantView", sender: self)
        }
    }

    

}
