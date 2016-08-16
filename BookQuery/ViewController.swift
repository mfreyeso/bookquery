//
//  ViewController.swift
//  BookQuery
//
//  Created by Mario on 16/08/16.
//  Copyright © 2016 Mario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var isbnBook: UITextField!
    
    @IBAction func primaryButtonAction(sender: AnyObject) {
        print(isbnBook.text!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

