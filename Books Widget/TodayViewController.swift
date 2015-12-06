//
//  TodayViewController.swift
//  Books Widget
//
//  Created by Asad Khaliq on 12/6/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
//     UITableViewDataSource, UITableViewDelegate
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Book.fetchAllBooks(managedObjectContext!).count
//        
//    }
//    
//     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("LibraryCell", forIndexPath: indexPath)
//        
//        let indexInt : Int = indexPath.row
//        
//        cell.textLabel!.text = (Book.fetchAllBooks(managedObjectContext!))[indexInt].title
//        cell.detailTextLabel!.text = (Book.fetchAllBooks(managedObjectContext!))[indexInt].author!.name
//        
//        return cell
//    }

    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
