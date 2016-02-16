//
//  AddClothesViewController.swift
//  Lab3
//
//  Created by Parth Mishra on 2/16/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class AddClothesViewController: UIViewController {
    
    @IBOutlet weak var clothesTextField: UITextField!
    var addedClothes = String()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "donesegue" {
            if ((clothesTextField.text?.isEmpty) == false) {
                addedClothes = clothesTextField.text!
            }
        }
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
