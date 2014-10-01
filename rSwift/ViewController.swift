//
//  ViewController.swift
//  rSwift
//
//  Created by Andrei Puni on 30/09/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import UIKit

class Post: NSObject {
    var title: String = ""
    var url: String = ""
    var ups: Int = 0
    var downs: Int = 0
    var score: Int = 0
}

extension UITableViewCell {
    func loadInfo(info: NSDictionary) {
        let propertyNames = self.propertyNames()
        let labels: [String] = propertyNames.filter { (name: String) -> Bool in
            return name.hasSuffix("Label")
        }
        for label in labels {
            let propertyName = (label + "$$$").stringByReplacingOccurrencesOfString("Label$$$", withString: "")
            if let value: AnyObject = info[propertyName] {
                let l: UILabel? = valueForKey(label) as UILabel?
                if l != nil {
                    let textValue = "\(value)"
                    l!.text = textValue
                }
            }
        }
    }
}

class PostCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET("http://www.reddit.com/r/swift.json", parameters: nil, success: { operation, response in
            if let data = response["data"] as? NSDictionary {
                if let postsInfo = data["children"] as? [NSDictionary] {
                    let posts: [Post] = postsInfo.map({ info in
                        return Post.fromJson(info["data"] as NSDictionary)
                    })
                    //println(posts)
                    self.posts = posts
                    self.tableView.reloadData()
                }
            }
        }) { operation, error in
            println("error")
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as PostCell
        
        var post = self.posts[indexPath.row]
        
        cell.loadInfo(post.asJson())
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}


