//
//  DetailViewController.swift
//  Lab3
//
//  Created by Parth Mishra on 2/13/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var clothing = [String]()
    var selectedClothesType = 0
    var clothesTypeListDetail = Clothes()

    override func viewWillAppear(animated: Bool) {
        clothesTypeListDetail.clothesTypes = Array(clothesTypeListDetail.clothesTypeData.keys)
        let chosenClothesType = clothesTypeListDetail.clothesTypes[selectedClothesType]
        clothing = clothesTypeListDetail.clothesTypeData[chosenClothesType]! as [String]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return clothing.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = clothing[indexPath.row]
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source = segue.sourceViewController as! AddClothingViewController
            if ((source.addedClothing.isEmpty) == false){
                clothing.append(source.addedClothing)
                tableView.reloadData()
                let chosenContinent = clothesTypeListDetail.clothesTypes[selectedClothesType]
                clothesTypeListDetail.clothesTypeData[chosenContinent]?.append(source.addedClothing)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
