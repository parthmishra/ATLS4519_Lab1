//
//  alarmViewController.swift
//  Alarm
//
//  Created by Aileen Pierce on 2/17/16.
//  Copyright © 2016 Aileen Pierce. All rights reserved.
//

import UIKit

class alarmViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var alarmtextfield: UITextField!
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    
    var addedalarm : Alarm?
    
    @IBAction func checkNotify() {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings?.types.rawValue == 0 {
            let alert = UIAlertController(title: "Can't schedule notifications", message: "Please go to Settings to enable notifications", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmtextfield.delegate=self
        checkNotify()
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            if ((alarmtextfield.text?.isEmpty) == false){  //save new alarm
                // initialize added alarm
                addedalarm = Alarm(newName: alarmtextfield.text!, newReminderDate: reminderDatePicker.date, newId: NSUUID().UUIDString)
            }
        }
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
