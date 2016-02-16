//
//  ViewController.swift
//  ScrabbleQ
//
//  Created by Parth Mishra on 1/26/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var clothesTypeList = Clothes()
    let kfilename = "data.plist"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path:String?
        let filePath = docFilePath(kfilename)
        
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
        
        
        clothesTypeList.clothesData = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        clothesTypeList.clothes = Array(clothesTypeList.clothesData.keys)
        
        let app = UIApplication.sharedApplication()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive:", name: "UIApplicationWillResignActive", object: app)


       
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothesTypeList.clothesData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath:  indexPath)
        cell.textLabel?.text = clothesTypeList.clothes[indexPath.row]
        return cell
    }
    

    //Handles segues to other view controllers
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "clothessegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = clothesTypeList.continents[indexPath.row]
            detailVC.clothesTypeListDetail=clothesTypeList
            detailVC.selectedContinent = indexPath.row
        } //for detail disclosure
        else if segue.identifier == "clothestypesegue"{
            let infoVC = segue.destinationViewController as! ContinentInfoTableViewController
            let editingCell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(editingCell)
            infoVC.name = clothesTypeList.continents[indexPath!.row]
            let countries = clothesTypeList.continentData[infoVC.name]! as [String]
            infoVC.number = String(countries.count)
        }
    }

    
    //UITableViewDatasource methods
    
    func docFilePath(filename: String) -> String?{
        //locate the documents directory
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let dir = path[0] as NSString //document directory
        //creates the full path to our data file
        return dir.stringByAppendingPathComponent(filename)
    }
    
    func applicationWillResignActive(notification: NSNotification){
        let filePath = docFilePath(kfilename)
        let data = NSMutableDictionary()
        //adds our whole dictionary to the data dictionary
        data.addEntriesFromDictionary(clothesTypeList.clothesData)
        print(data)
        //write the contents of the array to our plist file
        data.writeToFile(filePath!, atomically: true)
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
