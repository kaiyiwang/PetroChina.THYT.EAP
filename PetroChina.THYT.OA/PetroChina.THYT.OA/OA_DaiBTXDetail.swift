//
//  OA_DaiBTXDetail.swift
//  PetroChina.THYT.OA
//
//  Created by Mensp on 14/10/27.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_DaiBTXDetail: UITableViewController {

    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    var workflowId:NSString = "" //工作流ID（待办中的docid）
    var mailName:NSString = "" //中油信箱登陆名
    var dataArrLeft = ["标题","提交人","接收时间","文件类型","当前环节","查看流程"]
    var dataArrRight = ["消息产业关于表彰2013先进党员","吐哈油田信字（2014）3号","2014-05-13","2014-05-13"," "," "]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("workflowId:\(workflowId) mailName:\(mailName)")
//        DaiBanDetailFirst_Global.appendString(workflowId)
//        DaiBanDetailFirst_Global.appendString(DaiBanDetailSecond_Global)
//        DaiBanDetailFirst_Global.appendString(mailName)
//        DaiBanDetailFirst_Global.appendString(DaiBanDetailThird_Global)
//        println(DaiBanDetailFirst_Global)
        var sendData:NSString = DaiBanDetailFirst_Global+"\(workflowId.intValue)"+DaiBanDetailSecond_Global + "\(mailName)" + DaiBanDetailThird_Global
        
        var detailDataObj = DetailDataOfDaiBan()
        detailDataObj.connectToUrl(UrlString_Global, soapStr: sendData)
        
//        var detailDataObj = DetailDataOfDaiBan()
//        detailDataObj.connectToUrl(UrlString_Global, soapStr: DaiBanDetailFirst_Global)
//        var dataLast = detailDataObj.connectionData(UrlString_Global, soapStr: DaiBanDetailFirst_Global)
//         var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//        println(str)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 6
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        label1.text = dataArrLeft[indexPath.row]
        
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        label2.text = dataArrRight[indexPath.row]
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
