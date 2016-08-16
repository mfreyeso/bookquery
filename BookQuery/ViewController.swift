//
//  ViewController.swift
//  BookQuery
//
//  Created by Mario on 16/08/16.
//  Copyright © 2016 Mario. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var isbnBook: UITextField!
    @IBOutlet weak var textResult: UITextView!
    
    @IBAction func textFieldDoneEditing(sender:UITextField){
        sender.resignFirstResponder()
    }

    @IBAction func backgroundTap(sender:UIControl){
        isbnBook.resignFirstResponder()
    }
    
    @IBAction func primaryButtonAction(sender: AnyObject) {
        let isbn :String = isbnBook.text!
        if isbn != "" {
            textResult.text = queryBookDetails(isbn)
        }else{
            let alertController = UIAlertController(title: "Error", message: "You must write the ISBN code", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                print("OK button tapped")
            })
            alertController.addAction(okAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isbnBook.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func queryBookDetails(isbn:String) -> String{
        do{
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
            let url = NSURL(string: urls)
            let data:NSData? = NSData(contentsOfURL: url!)
            let result = String(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            return result
        }
        
        
        
    }


}

