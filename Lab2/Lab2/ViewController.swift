//
//  ViewController.swift
//  ScrabbleQ
//
//  Created by Parth Mishra on 1/26/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allclothes : [String : [String]]!
    var clothes : [String]!
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("clothes", ofType: "plist")
        allclothes = NSDictionary(contentsOfFile: path!) as! [String : [String]]
        clothes = Array(allclothes.keys)
        clothes.sortInPlace({$0 < $1})
        
        //search results
        let resultsController = SearchResultsController()
        resultsController.allclothes = allclothes
        resultsController.clothes = clothes
        searchController = UISearchController(searchResultsController: resultsController) //create a search controller and initialize with our SearchResultsController instance
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term" //place holder text
        searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController //sets the instance to update search results
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let clothe = clothes[section]
        let clothesection = allclothes[clothe]! as [String]
        return clothesection.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        let clothe = clothes[section]
        let wordsSection = allclothes[clothe]! as [String]
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = wordsSection[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let clothe = clothes[section]
        let clothesSection = allclothes[clothe]! as [String]
        
        
        let alert = UIAlertController(title: "Row selected", message: "Search \(clothesSection[indexPath.row])?", preferredStyle: UIAlertControllerStyle.Alert)
        let searchAction = UIAlertAction(title: "Search", style: UIAlertActionStyle.Default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //UITableViewDatasource methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return clothes.count
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return clothes[section]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}