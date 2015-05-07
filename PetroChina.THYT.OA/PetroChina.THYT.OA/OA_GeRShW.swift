//
//  OA_GeRShW.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_GeRShW: UITableViewController {

    let TAG_CELL_LABELLeft = 1001
    let TAG_CELL_LABELRight = 1002
    var myRefresh = UIRefreshControl() //刷新控件
    var finalDataOfGeRenShW:Array<DaiBanData> = [] //存储个人收文信息
    var finalDataOfDaiBan:Array<DaiBanData> = [] //存储代办信息
    //菊花
    var myview:JvHua!

    override func viewDidLoad() {
        super.viewDidLoad()
        //菊花显示
        myview = JvHua(frame: CGRect(x: self.view.center.x-50, y: self.view.center.y-150, width: 100, height: 100))
//        self.view.addSubview(myview)
        
        
        //移除空得单元格
//        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        //刷新实现
        myRefresh.attributedTitle = NSAttributedString(string: "正在刷新")
        myRefresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = myRefresh
        //获取数据
        finalDataOfDaiBan = getParserData_DaiBan()
        finalDataOfGeRenShW = findGeRenShW(finalDataOfDaiBan)
        if finalDataOfGeRenShW.count == 0 {
			var timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: false)
        }else{
            myview.activityIndicatorView.stopAnimating()
        }
        
//        //设置图标显示的数字 （必须要在读取到数据之后）
//        UIApplication.sharedApplication().applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + finalDatas.count
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
	func stop(){
		myview.activityIndicatorView.stopAnimating()
	}
    //将个人收文信息找出
    func findGeRenShW(strArray:Array<DaiBanData>) -> Array<DaiBanData> {
        var findData:Array<DaiBanData> = []
        for obj in strArray {
            if obj.dbsyhead.isEqualToString(GeRenShW_Global) {
                findData.append(obj)
            }
        }
        return findData
    }
    //返回大厅按钮触发事件
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    //刷新触发的事件
    func reload(){
//        myview.hidden = true
        println("reload GeRenShW")
        //获取所有的代办信息
        getDaiBanData()
        //赋值
        finalDataOfDaiBan = getParserData_DaiBan()
        finalDataOfGeRenShW = findGeRenShW(finalDataOfDaiBan)
        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
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
        return finalDataOfGeRenShW.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
//        label2.sizeToFit()
//        textview.editable = true
//        textview.selectable = false
        var obj = finalDataOfGeRenShW
        //表示已查看
        if obj[indexPath.row].state.isEqualToString("01"){
            //            println("已查看:\(indexPath.row)")
            textview.textColor = UIColor.grayColor()
            label2.textColor = UIColor.grayColor()
            
        }else {
            textview.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()

        }

        textview.text = obj[indexPath.row].title as String
        
        label2.text = returnTimerNum(obj[indexPath.row].gtime) as String
        
        return cell
    }

    //格式化ListView隔行现实效果。
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(red: 1.0, green: 0.99, blue: 0.97, alpha: 1.0) : UIColor(red: 0.96, green: 0.97, blue: 0.92, alpha: 1.0)
        
        //cell.backgroundColor = indexPath.row % 2 == 0 ?
        cell.imageView?.layer.cornerRadius = 22.0
        cell.imageView?.layer.masksToBounds = true
        //呈现动态效果图
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
        
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //点击cell，表示已查看，然后将文字显示灰色
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft) as! UITextView
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        textview.textColor = UIColor.grayColor()
        label2.textColor = UIColor.grayColor()
        //将看过的状态发送给后台,将后台状态改变
        var sendHouTai:NSString = changeDbsyStateFirst_Global + "\(finalDataOfGeRenShW[indexPath.row].id)" + changeDbsyStateSecond_Global
        var sendStateDbsy = ReturnHttpConnection()
        var dataLast = sendStateDbsy.connectionData(UrlString_Global, soapStr: sendHouTai)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//                        println("receiveState:\(str)")
        //界面跳转
        var dest = self.storyboard?.instantiateViewControllerWithIdentifier("GeRShWDetail") as! OA_GeRShWDetail
        let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
        dest.workflowId = finalDataOfGeRenShW[index].docid
        dest.mailName = YouXiang_Global
        dest.senderName = finalDataOfGeRenShW[index].sendername
        self.navigationController?.pushViewController(dest, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        println("selected:\(self.tableView.indexPathForSelectedRow()!.row)")
//        if segue.identifier == "GeRenShW" {
//            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
//            let myVC = segue.destinationViewController as OA_GeRShWDetail
//            myVC.workflowId = finalDataOfGeRenShW[index].docid
//            myVC.mailName = YouXiang_Global
//            myVC.senderName = finalDataOfGeRenShW[index].sendername
//        }
//GeRShWDetail

//    }


}
