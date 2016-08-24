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
                // let BookResult: Book = queryBookDetails(isbn)
                queryBookDetails(isbn)
                //renderResults(BookResult)
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
            // let authors = result["authors"] as! NSArray
            // let pages = valuesBook["number_of_pages"] as! NSInteger
            let title = valuesBook["title"] as! NSString as String
            titleLabel.text = title
            // let bookResult = Book(authors: authors as! Array<String>, title: title, pages: pages)
        }catch _ {
            print("Error")
        }
        
    }
    
    func renderResults(book: Book){
        titleLabel.text = book.title
        authorLabel.text = book.getAuthors()
//        if book.cover != nil{
//            coverLabel.text = book.cover!
//        }
    }

}

