//
//  Model.swift
//  News
//
//  Created by Ruslan on 29.11.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import Foundation

var firstArticles: [Article] = []
var secondArticles: [Article] = []
var thirdArticles: [Article] = []

var urlToDataFirst: URL{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data1.json"
    
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

var urlToDataSecond: URL{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data2.json"
    
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}

var urlToDataThird: URL{
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data3.json"
    
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
}
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=9718d6987bb242178bb2eafc1bafb383
//https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=9718d6987bb242178bb2eafc1bafb383
//https://newsapi.org/v2/everything?domains=wsj.com&apiKey=9718d6987bb242178bb2eafc1bafb383
func loadNews(newsTopic: String, completionHandler: (()-> Void)?){
    var currentUrl: URL?
    var currentUrlToData: URL?
    switch newsTopic {
    case "first":
        currentUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=9718d6987bb242178bb2eafc1bafb383")
        currentUrlToData = urlToDataFirst
    case "second":
        currentUrl = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=9718d6987bb242178bb2eafc1bafb383")
        currentUrlToData = urlToDataSecond
    case "third":
        currentUrl = URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=9718d6987bb242178bb2eafc1bafb383")
        currentUrlToData = urlToDataThird
    default:
        currentUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=9718d6987bb242178bb2eafc1bafb383")
        currentUrlToData = urlToDataFirst
    }
    
    let session = URLSession(configuration: .default)
    
    let downloadTask = session.downloadTask(with: currentUrl!) { (urlFile, responce, error) in
        
        if urlFile != nil {
            
            try? FileManager.default.copyItem(at: urlFile!, to: currentUrlToData!)
            //print(currentUrlToData)
            print(newsTopic)
            parseNews(newsTopic: newsTopic, urlToData: currentUrlToData!)
            
            completionHandler?()
        }
    }
    downloadTask.resume()
}

func parseNews(newsTopic: String, urlToData: URL){

    let data = try? Data(contentsOf: urlToData)
    if data == nil{
        return
    }
    
    let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, Any>
    if rootDictionaryAny == nil{
        return
    }
    
    let rootDictionary = rootDictionaryAny as? Dictionary<String, Any>
    if rootDictionaryAny == nil{
        return
    }
    
    if let array = rootDictionary!["articles"] as? [Dictionary<String, Any>]{
        var returnArray: [Article] = []
        
        for dict in array{
            let newArticle = Article(dictionary: dict)
            returnArray.append(newArticle)
        }
        switch newsTopic {
        case "first":
            firstArticles = returnArray
        case "second":
            secondArticles = returnArray
        case "third":
            thirdArticles = returnArray
        default:
            return
        }
    }
}
    




