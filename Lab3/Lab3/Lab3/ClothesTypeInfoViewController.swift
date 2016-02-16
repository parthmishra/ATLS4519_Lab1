//
//  ClothesTypeInfoViewController.swift
//  Lab3
//
//  Created by Parth Mishra on 2/16/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class ClothesTypeInfoViewController: UITableViewController {
    
    @IBOutlet weak var clothesName: UILabel!
    @IBOutlet weak var clothesDescription: UILabel!
    
    var name = String()
    var descript = String()
    
    override func viewWillAppear(animated: Bool) {
        clothesName.text = name
        clothesDescription.text = descript
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

    // MARK: - Table view data source


}
