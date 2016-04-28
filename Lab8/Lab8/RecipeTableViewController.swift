//
//  RecipeTableViewController.swift
//  recipes
//
//  Created by Parth Mishra on 3/17/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit
import Firebase

class RecipeTableViewController: UITableViewController {

    let ref = Firebase(url: "https://recipes-pmishra.firebaseio.com")
    var recipes = [Recipe]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ref.observeEventType(FEventType.Value, withBlock: {snapshot in self.recipes=[]

            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot]{
                for item in snapshots {
                    guard let recipeName = item.value["name"] as? String,
                        let recipeURL = item.value["url"] as? String
                        else {
                            continue
                    }
                    let newRecipe = Recipe(newname: recipeName, newurl: recipeURL)
                    self.recipes.append(newRecipe)
                }
            }
            self.tableView.reloadData()
        })
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
        return recipes.count
    }
    
    
    @IBAction func unwindSegue(segue:UIStoryboardSegue){
        if segue.identifier == "savesegue" {
            let source = segue.sourceViewController as! AddViewController
            if source.addedrecipe.isEmpty == false {
                let newRecipe = Recipe(newname: source.addedrecipe, newurl: source.addedurl)
                recipes.append(newRecipe)
                let newRecipeDict = ["name": sqwource.addedrecipe, "url": source.addedurl]
                let reciperef = ref.childByAppendingPath(source.addedrecipe)
                reciperef.setValue(newRecipeDict)
            }
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showdetail" {
            let detailVC = segue.destinationViewController as! WebViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
            let recipe = recipes[indexPath.row]
            //sets the data for the destination controller
            detailVC.title = recipe.name
            detailVC.webpage = recipe.url
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recipecell", forIndexPath: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel!.text = recipe.name
        
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
            let recipe = recipes[indexPath.row]
            // Delete the row from the data source
            let reciperef = ref.childByAppendingPath(recipe.name)
            reciperef.ref.removeValue()
        } /*
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }   
        */
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
