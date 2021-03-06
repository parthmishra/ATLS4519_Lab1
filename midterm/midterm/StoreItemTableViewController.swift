//
//  StoreItemTableViewController.swift
//  midterm
//
//  Created by Parth Mishra on 3/10/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class StoreItemTableViewController: UITableViewController {
    
    var items = [String]()
    var selectedStore = 0
    var storeListDetail = Stores()
    
    override func viewWillAppear(animated: Bool) {
        storeListDetail.stores = Array(storeListDetail.storeData.keys)
        let chosenStore = storeListDetail.stores[selectedStore]
        items = storeListDetail.storeData[chosenStore]! as [String]
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            items.removeAtIndex(indexPath.row)
            let chosenStore = storeListDetail.stores[selectedStore]
            storeListDetail.storeData[chosenStore]?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fromRow = fromIndexPath.row 
        let toRow = toIndexPath.row
        let moveItem = items[fromRow]
        items.removeAtIndex(fromRow)
        items.insert(moveItem, atIndex: toRow)
        let chosenStore = storeListDetail.stores[selectedStore]
        storeListDetail.storeData[chosenStore]?.removeAtIndex(fromRow)
        storeListDetail.storeData[chosenStore]?.insert(moveItem, atIndex: toRow)

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    
    @IBAction func unwindSegue(segue:UIStoryboardSegue) {
        if segue.identifier=="doneSegue"{
            let source = segue.sourceViewController as! AddItemViewController
            print("done segue reached")
            if ((source.addedItem.isEmpty) == true) {
                print("nothing to add?")
            }
            if ((source.addedItem.isEmpty) == false) {
                print("adding item")
                items.append(source.addedItem)
                tableView.reloadData()
                let chosenStore = storeListDetail.stores[selectedStore]
                storeListDetail.storeData[chosenStore]?.append(source.addedItem)
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
