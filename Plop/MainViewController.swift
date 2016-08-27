//
//  MainViewController.swift
//  Plop
//
//  Created by 김혜원 on 2016. 8. 27..
//  Copyright © 2016년 seolheelee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var MainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MainTableView.dequeueReusableCellWithIdentifier("mainTableViewCell", forIndexPath: indexPath) as! MainTableViewCell
        
        return cell
        
        
    }
}