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
        

        if NSFileManager.defaultManager().fileExistsAtPath(filePath!) {
            path = filePath
            print(path)
        }
        else {
            
            print("Hello World!")
            path = NSBundle.mainBundle().pathForResource("stores", ofType: "plist")
            print(path)
        }
        

        storeList.storeData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        storeList.stores = Array(storeList.storeData.keys)
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: "UIApplicationWillResignActiveNotification", object: app)
    }
    
    
    
    func docFilePath(filename: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString
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
        if segue.identifier == "storeitemsegue" {
            let detailVC = segue.destinationViewController as! StoreItemTableViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = storeList.stores[indexPath.row]
            detailVC.storeListDetail=storeList
            detailVC.selectedStore = indexPath.row
        }
    }
    
    
    func applicationWillResignActive(notification: NSNotification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        data.addEntriesFromDictionary(storeList.storeData)
        print(data)
        data.writeToFile(filePath!, atomically: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
}



