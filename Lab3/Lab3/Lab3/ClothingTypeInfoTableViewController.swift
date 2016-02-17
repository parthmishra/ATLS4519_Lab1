//
//  ContinentInfoTableViewController.swift
//  Lab3
//
//  Created by Parth Mishra on 2/1/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class ClothingTypeInfoTableViewController: UITableViewController {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryDescript: UILabel!
    var name = String()
    var descript = String()
    
    override func viewWillAppear(animated: Bool) {
        categoryName.text = name
        categoryDescript.text = descript
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
