//
//  Book.swift
//  BookQuery
//
//  Created by Mario on 24/08/16.
//  Copyright © 2016 Mario. All rights reserved.
//

import Foundation

class Book {
    var authors = Array<String>();
    let title: String
    var cover: String?
    let pages: Int
    
    init(authors:Array<String>, title:String, pages: Int){
        self.authors = authors
        self.title = title
        self.pages = pages
    }
    
    func setCoverPage(coverPage: String){
        self.cover = coverPage
    }
    
    func getAuthors() ->String{
        var result: String = ""
        for author in self.authors{
            result = result + author + " "
        }
        return result
    }
    
}
