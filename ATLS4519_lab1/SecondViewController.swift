//
//  SecondViewController.swift
//  Dress Me MAD
//
//  Created by Parth Mishra on 1/28/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let mainClothesComponent = 0
    let subClothesComponent = 1
    
    var clothesCategory : [String:[String]]!
    var mainCategory : [String]!
    var subCategory : [String]!
    
    var searchTerm = "coats"
    
    
    @IBOutlet var clothesPicker: UIPickerView!
    
    @IBAction func goToAmazon(sender: UIButton) {
        
        // create a URL friendly search term
        let urlsearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string: "amazon://")!)){
            //open the app with this URL scheme
            UIApplication.sharedApplication().openURL(NSURL(string: "amazon://")!)
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=\(urlsearchTerm)")!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("clothes", ofType: "plist")
        
        clothesCategory = NSDictionary(contentsOfFile: path!) as! [String :[String]]
        
        mainCategory = Array(clothesCategory.keys)
        subCategory = clothesCategory[mainCategory[0]]! as [String]
        
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component ==  mainClothesComponent {
            return mainCategory.count
        } else {
            return subCategory.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == mainClothesComponent {
            return mainCategory[row]
        } else {
            return subCategory[row]
        }
        
        
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == mainClothesComponent {
            let selectedCategory = mainCategory[row]
            subCategory = clothesCategory[selectedCategory]
            clothesPicker.reloadComponent(subClothesComponent)
            clothesPicker.selectRow(0, inComponent: subClothesComponent, animated: true)
        }
        
        let clothesRow = pickerView.selectedRowInComponent(subClothesComponent)
        // set a search term for a potential amazon search
        searchTerm = subCategory[clothesRow]
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

