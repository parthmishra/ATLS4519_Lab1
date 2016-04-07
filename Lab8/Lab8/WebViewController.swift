//
//  WebViewController.swift
//  recipes
//
//  Created by Parth Mishra on 3/17/16.
//  Copyright © 2016 Parth Mishra. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    
    var webpage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate=self
        loadWebPage()
    }

    func loadWebPage(){
 
        guard let weburl = webpage
            else {
                print("no web page found")
                return
            }
        
        let url = NSURL(string: weburl)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        webSpinner.startAnimating()
    }
    

    func webViewDidFinishLoad(webView: UIWebView) {
        webSpinner.stopAnimating()
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
