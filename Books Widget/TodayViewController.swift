//
//  TodayViewController.swift
//  Books Widget
//
//  Created by Asad Khaliq on 12/6/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDelegate, UITableViewDataSource {
    
    //     UITableViewDataSource, UITableViewDelegate
    
    var bookList = [String: Int]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookList["Zero to One"] = 76
        bookList["Meditations"] = 12
        bookList["Lean In"] = 50
        
        // Here we set up a sample dictionary. In a released app we would utilize NSUserDefaults to transfer the reader's queue 
        // to the today widget, but to do this we have to register the app and widget with Apple, so we are simply using a demonstration here. 
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = 44
        self.preferredContentSize = self.tableView.contentSize
        self.preferredContentSize.height = 132

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodayWidgetCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = Array(bookList.keys)[indexPath.row]
        cell.detailTextLabel!.text = String(bookList[Array(bookList.keys)[indexPath.row]]!) + " pages left"
        return cell
    }
    
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.NewData)
    }
    
}
