//
//  MasterViewController.swift
//  Lab7
//
//  Created by Parth Mishra on 3/26/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [[String:String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
    }

    func loadjson(){
        let urlPath = "https://na.api.pvp.net/api/lol/na/v2.5/league/challenger?type=RANKED_SOLO_5x5&api_key=4bf388db-f2aa-4d18-9d76-b70b3186a3b9"
        guard let url = NSURL(string: urlPath)
            else {
                print("url error")
                return
        }
        
        let session = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {(data, response, error) in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            //download successful
            print("download complete")
            dispatch_async(dispatch_get_main_queue()) {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }

    
    func parsejson(data: NSData){
        do {
            // get json data
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
            //get all results
            let allresults = json["entries"] as! NSArray
            let results = Array(allresults)
            //add results to objects
            for result in results {
                //check that data exists
                guard let playerName = result["playerOrTeamName"]! as? String,
                    let leaguePoints = result["leaguePoints"] as? NSNumber,
                    let playerId = result["playerOrTeamId"]!as? String,
                    let playerWins = result["wins"] as? NSNumber,
                    let playerLosses = result["losses"] as? NSNumber
                    else {
                        continue
                }
                //create new object
                let obj = ["playerOrTeamName": playerName,
                            "leaguePoints": leaguePoints.stringValue,
                            "playerOrTeamId": playerId,
                            "wins": playerWins.stringValue,
                            "losses": playerLosses.stringValue]
                //add object to array
                self.objects.append(obj)
            }
            //handle thrown error
        } catch {
            print("Error with JSON: \(error)")
            return
        }
        //reload the table data after the json data has been downloaded
        tableView.reloadData()
    }
    

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let player = objects[indexPath.row]
                let playerName = player["playerOrTeamName"]
                let playerId = player["playerOrTeamId"]
                let playerWins = player["wins"]
                let playerLosses = player["losses"]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = playerId
                controller.detailName = playerName
                controller.detailWins = playerWins
                controller.detailLosses = playerLosses
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object["playerOrTeamName"]
        if object["leaguePoints"] != nil {
            cell.detailTextLabel!.text = object["leaguePoints"]! + " LP"
        }
        return cell
    }

}

