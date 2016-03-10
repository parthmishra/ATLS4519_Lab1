//
//  StoreTableViewController.swift
//  midterm
//
//  Created by Parth Mishra on 3/10/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {

    var storeList = Stores()
    let kfilename = "data.plist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path:String?
        let filePath = docFilePath(kfilename)
        

        if NSFileManager.defaultManager().fileExistsAtPath(filePath!){
            path = filePath
            print(path)
        }
        else {
            
            print("Hello World!")
            path = NSBundle.mainBundle().pathForResource("stores", ofType: "plist")
            print(path)
        }
        
        //load the data of the plist file into the dictionary
        storeList.storeData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        //puts all the continents in an array
        storeList.stores = Array(storeList.storeData.keys)
        
        //application instance
        let app = UIApplication.sharedApplication()
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: "UIApplicationWillResignActiveNotification", object: app)
    }
    
    
    
    func docFilePath(filename: String) -> String?{
        //locate the documents directory
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString //document directory
        //creates the full path to our data file
        return dir.stringByAppendingPathComponent(filename)
    }
    

    //Required methods for UITableViewDataSource
    //Number of rows in the section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.storeData.count
    }
    
    // Displays table view cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = storeList.stores[indexPath.row]
        return cell
    }
    
    //Handles segues to other view controllers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "additemsegue" {
            let detailVC = segue.destinationViewController as! StoreItemTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = storeList.stores[indexPath.row]
            detailVC.storeListDetail=storeList
            detailVC.selectedStore = indexPath.row
    }
    func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    
    func applicationWillResignActive(notification: NSNotification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        // adds our whole dictionary to the data dictionary
        data.addEntriesFromDictionary(storeList.storeData)
        print(data)
        // write the contents of the array to our plist file
        data.writeToFile(filePath!, atomically: true)
    }
    

    
    
}



}