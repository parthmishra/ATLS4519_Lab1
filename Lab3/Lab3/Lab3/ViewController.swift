//
//  ViewController.swift
//
//
//  Created by Parth Mishra on 2/14/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var clothesTypeList = Clothes()
    let kfilename = "data.plist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        //use a NSBundle object of the directory for our application to retrieve the pathname of clothesType.plist
        let path = NSBundle.mainBundle().pathForResource("clothesType", ofType: "plist")
        //load the data of the plist file into the dictionary
        clothesTypeList.clothesTypeData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        //puts all the clothesType in an array
        clothesTypeList.clothesType = Array(clothesTypeList.clothesTypeData.keys)
        */
        
        let path:String?
        let filePath = docFilePath(kfilename) //path to data file
        
        //if the data file exists, use it
        if NSFileManager.defaultManager().fileExistsAtPath(filePath!){
            path = filePath
            print(path)
        }
        else {
            //use a NSBundle object of the directory for our application to retrieve the pathname of our initial plist
            path = NSBundle.mainBundle().pathForResource("clothes", ofType: "plist")
            print(path)
        }
        
        
        clothesTypeList.clothesTypeData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
    
        clothesTypeList.clothesTypes = Array(clothesTypeList.clothesTypeData.keys)
        
        //application instance
        let app = UIApplication.sharedApplication()
        //subscribe to the UIApplicationWillResignActiveNotification notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: "UIApplicationWillResignActiveNotification", object: app)
    }
    
    //Required methods for UITableViewDataSource
    //Number of rows in the section
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothesTypeList.clothesTypeData.count
    }
    
    // Displays table view cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = clothesTypeList.clothesTypes[indexPath.row]
        return cell
    }
    
    //Handles segues to other view controllers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "clothessegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = clothesTypeList.clothesTypes[indexPath.row]
            detailVC.clothesTypeListDetail=clothesTypeList
            detailVC.selectedClothesType = indexPath.row
        } //for detail disclosure
        else if segue.identifier == "categorysegue"{
            let infoVC = segue.destinationViewController as! ClothesTypeInfoViewController
            let editingCell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(editingCell)
            infoVC.name = clothesTypeList.clothesTypes[indexPath!.row]
            let countries = clothesTypeList.clothesTypeData[infoVC.name]! as [String]
            infoVC.descript = String(countries.count)
        }
    }
    
    func docFilePath(filename: String) -> String?{
        //locate the documents directory
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString //document directory
        //creates the full path to our data file
        return dir.stringByAppendingPathComponent(filename)
    }
    
    //called when the UIApplicationWillResignActiveNotification notification is posted
    //all notification methods take a single NSNotification instance as their argument
    func applicationWillResignActive(notification: NSNotification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        //adds our whole dictionary to the data dictionary
        data.addEntriesFromDictionary(clothesTypeList.clothesTypeData)
        print(data)
        //write the contents of the array to our plist file
        data.writeToFile(filePath!, atomically: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
