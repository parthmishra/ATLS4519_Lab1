//
//  AddClothingItemViewController.swift
//  Project2
//
//  Created by Parth Mishra on 4/7/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class AddClothingItemViewController: UIViewController {

    @IBOutlet weak var clothesName: UITextField!
    @IBOutlet weak var clothesType: UITextField!
    @IBOutlet weak var clothesColor: UITextField!
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
