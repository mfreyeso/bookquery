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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageCover: UIImageView!
    
    
    @IBAction func textFieldDoneEditing(sender:UITextField){
        sender.resignFirstResponder()
    }

    @IBAction func backgroundTap(sender:UIControl){
        isbnBook.resignFirstResponder()
    }
    
    @IBAction func primaryButtonAction(sender: AnyObject) {
        let isbn :String = isbnBook.text!
        if isbn != "" {
            if Reachability.isConnectedToNetwork() {
                queryBookDetails(isbn)
            }else{
                let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
                    print("OK button tapped")
                })
                alertController.addAction(okAction)
                
                presentViewController(alertController, animated: true, completion: nil)
            }
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
    
    func queryBookDetails(isbn:String){
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
        let url = NSURL(string: urls)
        let data = NSData(contentsOfURL: url!)
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)
            let result = json as! NSDictionary
            let keyBook = "ISBN:" + isbn
            let valuesBook = result[keyBook] as! NSDictionary
            renderDetails(valuesBook)
        }catch _ {
            print("Error")
        }
        
    }
    
    func renderDetails(data: NSDictionary){
        
        var authorsValue = "The data not contain authors"
        var title :String = "The data not contain title"
        let cover :String?
        
        if (data.valueForKey("authors") != nil) {
            authorsValue = ""
            let authors = data["authors"] as! NSArray as Array
            for var author in authors{
                author = author as! NSDictionary
                let name = author["name"] as! NSString as String
                authorsValue = authorsValue + name + " "
            }
        }
        
        if (data.valueForKey("title") != nil){
           title = data["title"] as! NSString as String
        }
        
        if (data.valueForKey("cover") != nil){
            let coverDict = data["cover"] as! NSDictionary
            cover = coverDict["large"] as! NSString as String
            
            let url = NSURL(string: cover!)
            if let dataImage = NSData(contentsOfURL: url!) {
                imageCover.image = UIImage(data: dataImage)
            }
            
        }
        
        titleLabel.text = title
        authorLabel.text = authorsValue
        
    }

}

