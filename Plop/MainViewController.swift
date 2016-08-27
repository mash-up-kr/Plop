//
//  MainViewController.swift
//  Plop
//
//  Created by 김혜원 on 2016. 8. 27..
//  Copyright © 2016년 seolheelee. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Async

class MainViewController: UIViewController {

    @IBOutlet weak var MainTableView: UITableView!
    
    @IBOutlet weak var defaultView: UIView!
    
    var statuses: [Status] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Async.background {
            let response = Alamofire.request(.GET, "http://118.131.253.37:8080/constipation/shit/shit_list")
                .log(level: .Verbose)
                .responseObject() as Response<ShitListResponse, NSError>
            
            if response.result.isSuccess {
                print(response.result.value?.data?.first)
                
                Async.main {
                    self.statuses = response.result.value?.data ?? []
                    if self.statuses.isEmpty {
                        //self.defaultView.hidden = false
                    } else {
                        //self.defaultView.hidden = true
                    }
                    self.MainTableView.reloadData()
                }
            }
        }
        
        
        
        
        
      // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension MainViewController: UITabBarDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return statuses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCellWithIdentifier("mainTableViewCell", forIndexPath: indexPath) as! MainTableViewCell
        let status = statuses[indexPath.row]
        let dateStrings = status.dateStrings
        
        cell.yearLabel.text = "\(dateStrings[0])"
        cell.dateLabel.text = "\(dateStrings[1])/\(dateStrings[2])"
        cell.statusImageView.image = status.scoreImage
        cell.statusLabel.text = "\(status.shitTypeText), \(status.shitThickText), \(status.shitColorText), \(status.shitAmountText)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            // handle delete (by removing the data from your array and updating the tableview)
//        }
        if editingStyle == UITableViewCellEditingStyle.Delete {
            statuses.removeAtIndex(indexPath.row)
            MainTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

}