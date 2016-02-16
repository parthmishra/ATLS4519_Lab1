//
//  DetailViewController.swift
//  countries
//
//  Created by Aileen Pierce on 1/26/16.
//  Copyright © 2016 Aileen Pierce. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    var countries = [String]()
    var selectedClothesType = 0
    var clothesTypeListDetail = Clothes()

    override func viewWillAppear(animated: Bool) {
        clothesTypeListDetail.clothesTypes = Array(clothesTypeListDetail.clothesTypeData.keys)
        let chosenContinent = clothesTypeListDetail.clothesTypes[selectedClothesType]
        countries = clothesTypeListDetail.clothesTypeData[chosenContinent]! as [String]
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
        return countries.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
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
            //Delete the country from the array
            countries.removeAtIndex(indexPath.row)
            let chosenContinent = clothesTypeListDetail.clothesTypes[selectedClothesType]
            //Delete from the data model
            clothesTypeListDetail.clothesTypeData[chosenContinent]?.removeAtIndex(indexPath.row)
            // Delete the row from the table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fromRow = fromIndexPath.row //row being moved from
        let toRow = toIndexPath.row //row being moved to
        let moveCountry = countries[fromRow] //country being moved
        //move in array
        countries.removeAtIndex(fromRow)
        countries.insert(moveCountry, atIndex: toRow)
        //move in data model
        let chosenContinent = clothesTypeListDetail.clothesTypes[selectedClothesType]
        clothesTypeListDetail.clothesTypeData[chosenContinent]?.removeAtIndex(fromRow)
        clothesTypeListDetail.clothesTypeData[chosenContinent]?.insert(moveCountry, atIndex: toRow)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        if segue.identifier=="doneSegue"{
            let source = segue.sourceViewController as! AddCountryViewController
            //only add a country if there is text in the textfield
            if ((source.addedCountry.isEmpty) == false){
                countries.append(source.addedCountry)
                tableView.reloadData()
                let chosenContinent = clothesTypeListDetail.clothesTypes[selectedClothesType]
                clothesTypeListDetail.clothesTypeData[chosenContinent]?.append(source.addedCountry)
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
