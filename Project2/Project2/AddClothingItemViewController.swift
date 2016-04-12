//
//  AddClothingItemViewController.swift
//  Project2
//
//  Created by Parth Mishra on 4/7/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class AddClothingItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {


    @IBOutlet weak var uploadImage: UIButton!
    @IBOutlet weak var clothesImage: UIImageView!
    @IBOutlet weak var clothesName: UITextField!
    @IBOutlet weak var clothesType: UITextField!
    @IBOutlet weak var clothesColor: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func buttonClicked() {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }

    }
    
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
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        clothesImage.image = image
        
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
