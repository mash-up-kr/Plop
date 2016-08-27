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
            let uuid = Device.uuid
            let parameters = ["userKey" : uuid]
            let response = Alamofire.request(.GET, "http://118.131.253.37:8080/constipation/shit/shit_list", parameters: parameters, encoding: .URL)
                .log(level: .Verbose)
                .responseObject() as Response<ShitListResponse, NSError>
            
            if response.result.isSuccess {
                Async.main {
                    self.statuses = response.result.value?.data ?? []
                    if self.statuses.isEmpty {
                        self.defaultView.hidden = false
                    } else {
                        self.defaultView.hidden = true
                    }
                    self.MainTableView.reloadData()
                }
            }
            
//            self.create(status: Status())
        }
    }
    
    func create(status status: Status) {
        Async.background {
            let uuid = Device.uuid
            var parameters = status.toJSON()
            parameters["userKey"] = uuid
            let response = Alamofire.request(.POST, "http://118.131.253.37:8080/constipation/shit/shit_add", parameters: parameters, encoding: .URL)
                .log(level: .Verbose)
                .responseString()
            
            if response.result.isSuccess {
                Async.main {
                    print("만들기 성공")
                }
            } else {
                print("만들기 실패")
            }

        }
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