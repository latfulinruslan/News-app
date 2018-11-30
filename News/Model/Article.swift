//
//  Article.swift
//  News
//
//  Created by Ruslan on 29.11.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import Foundation
struct Article {
    var author: String
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var content: String
    var publishedAt: String
    var sourceName: String
    
    init(dictionary: Dictionary<String, Any>){
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        url = dictionary["url"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        content = dictionary["content"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
        sourceName = (dictionary["source"] as? Dictionary<String, Any> ?? ["":""])["name"] as? String ?? ""
    }
}
