//
//  DetailViewController.swift
//  Lab7
//
//  Created by Parth Mishra on 3/26/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailWinsLabel: UILabel!
    @IBOutlet weak var detailLossesLabel: UILabel!
    
    var detailName: AnyObject?
    var detailItem: AnyObject?
    var detailWins: AnyObject?
    var detailLosses: AnyObject?
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
        
        if let detail = self.detailName {
            if let label = self.detailNameLabel {
                label.text = detail.description
            }
        }
        
        if let detail = self.detailWins {
            if let label = self.detailWinsLabel {
                label.text = detail.description
            }
        }
        
        if let detail = self.detailLosses {
            if let label = self.detailLossesLabel {
                label.text = detail.description
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

