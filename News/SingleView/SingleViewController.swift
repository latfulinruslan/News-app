//
//  SingleViewController.swift
//  News
//
//  Created by Ruslan on 01.12.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit
import  SafariServices

class SingleViewController: UIViewController {
    
    var article: Article!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var enableButton: UIBarButtonItem!
    
    @IBAction func pushOpenSafariAction(_ sender: Any) {
        if let url = URL(string: article.url){
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleText.text = ""
        descriptionText.text = ""
        titleText.text.append((article?.title)!)
        descriptionText.text.append((article?.content)!)
        
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage){
                if let data = try? Data(contentsOf: url) {
                    self.imageView.image = UIImage(data: data)
                } else {
                    //self.activityLoading.alpha = 0
                    //self.imageView.image = #imageLiteral(resourceName: "Unknown")
                    
                }
            }
        }
        if URL(string: article.url) == nil {
            enableButton.isEnabled = false
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
