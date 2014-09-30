//
//  ViewController.swift
//  rSwift
//
//  Created by Andrei Puni on 30/09/14.
//  Copyright (c) 2014 Andrei Puni. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    var posts = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100//self.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

