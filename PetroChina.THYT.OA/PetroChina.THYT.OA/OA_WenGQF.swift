//
//  OA_WenGQF.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_WenGQF: UITableViewController{
    
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    var myRefresh = UIRefreshControl() //刷新控件
    var finalDataOfDaiBan:Array<DaiBanData> = [] //存储代办信息
    var finalDataOfErJiLingDaoQianFa:Array<DaiBanData> = [] //存储个人收文信息
    
    //菊花
    var myview:JvHua!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取所有代办信息
        getDaiBanData()
        //菊花显示
        myview = JvHua(frame: CGRect(x: self.view.center.x-50, y: self.view.center.y-150, width: 100, height: 100))
        self.view.addSubview(myview)
        
//        UITableView
//        var showHud = HudShow()
//        showHud.showTitleHUD("成功保存")
//        showHud.hudShowTime(2)
               //移除空得单元格
//        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        //刷新实现
        myRefresh.attributedTitle = NSAttributedString(string: "正在刷新")
        myRefresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = myRefresh
        //获取数据
        finalDataOfDaiBan = parserData_Global
        finalDataOfErJiLingDaoQianFa = findErJiDanWeiFaWen(finalDataOfDaiBan)
		if finalDataOfErJiLingDaoQianFa.count == 0 {
			var timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: false)
		}else{
			myview.activityIndicatorView.stopAnimating()
		}

//        //测试平台数据
//        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) //获取目录
//        if sp.count > 0{
//        //测试获取到得数据
//        var domain = NSURL(fileURLWithPath: "\(sp[0])/domain.txt")
//        if let a = domain?.path {
//            var bb = NSData(contentsOfFile: a)
//            if bb == nil {
////                NSLog("-------------没有平台测试数据")
//            }else {
//                var str:NSString = NSString(data: bb!, encoding: NSUTF8StringEncoding)!
//                var strArray1:NSArray = str.componentsSeparatedByString(",")
//                var domain = strArray1[0] as NSString
//                var loginID = strArray1[1] as NSString
//                var all = strArray1[2] as NSString
//                var alert = UIAlertView(title: "平台数据测试", message: "domain:\(str) LoginID:\(loginID) all:\(all)", delegate: self, cancelButtonTitle: "确定")
//                alert.show()
//                }
//            
//            }
//        }
    
    }
	func stop(){
		myview.activityIndicatorView.stopAnimating()
	}
    //将二级单位收文选出
    func findErJiDanWeiFaWen(strArray:Array<DaiBanData>) -> Array<DaiBanData> {
        var findData:Array<DaiBanData> = []
        for obj in strArray {
            if obj.dbsyhead.isEqualToString(ErJiDanWeiFaWen_Global) {
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
        
        println("reload WenGQF")
        //获取所有的代办信息
        getDaiBanData()
        //赋值
        finalDataOfDaiBan = getParserData_DaiBan()
        finalDataOfErJiLingDaoQianFa = findErJiDanWeiFaWen(finalDataOfDaiBan)
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
        return finalDataOfErJiLingDaoQianFa.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
//        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as UILabel
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
//        textview.editable = true
//        textview.selectable = false
        var obj = finalDataOfErJiLingDaoQianFa
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        
        if obj[indexPath.row].state.isEqualToString("01"){
            //            println("已查看:\(indexPath.row)")
            textview.textColor = UIColor.grayColor()
            label2.textColor = UIColor.grayColor()
            
        }else {
            textview.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
            
        }
        textview.text = finalDataOfErJiLingDaoQianFa[indexPath.row].title as String
        label2.text = returnTimerNum(finalDataOfErJiLingDaoQianFa[indexPath.row].gtime) as String
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
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        textview.textColor = UIColor.grayColor()
        label2.textColor = UIColor.grayColor()
        //将看过的状态发送给后台,将后台状态改变
        var sendHouTai:NSString = changeDbsyStateFirst_Global + "\(finalDataOfErJiLingDaoQianFa[indexPath.row].id)" + changeDbsyStateSecond_Global
        var sendStateDbsy = ReturnHttpConnection()
        var dataLast = sendStateDbsy.connectionData(UrlString_Global, soapStr: sendHouTai)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//                                println("receiveState:\(str)")
        
        
        //界面跳转
        var dest = self.storyboard?.instantiateViewControllerWithIdentifier("WenGQFDetail") as! OA_WenGQFDetail
        let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
        dest.workflowId = finalDataOfErJiLingDaoQianFa[index].docid
        dest.senderName = finalDataOfErJiLingDaoQianFa[index].sendername
        self.navigationController?.pushViewController(dest, animated: true)
        //            NSLog("OA：workflowId:\(finalDataOfErJiLingDaoQianFa[index].docid) mailName:\(finalDataOfErJiLingDaoQianFa[index].sendername)")
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
//        println("sssssssss:\(scrollView.contentOffset)")
        
//        self.tableView.scrollToRowAtIndexPath(5, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
//        if tableView.scrollToRowAtIndexPath(5, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true) {
//            println("endendendendendendendendend")
//        }
    }
//    func scrollToRowAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UITableViewScrollPosition, animated: Bool){
//        println("scrollToRowAtIndexPath:\(indexPath.row)")
//    }
    func scrollToNearestSelectedRowAtScrollPosition(scrollPosition: UITableViewScrollPosition, animated: Bool){
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "WenGQF" {
//            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
//            let myVC = segue.destinationViewController as OA_WenGQFDetail
//            println("index:\(index)")
//            myVC.workflowId = finalDataOfErJiLingDaoQianFa[index].docid
//            myVC.senderName = finalDataOfErJiLingDaoQianFa[index].sendername
////            NSLog("OA：workflowId:\(finalDataOfErJiLingDaoQianFa[index].docid) mailName:\(finalDataOfErJiLingDaoQianFa[index].sendername)")
//        }
//
//    }
    

}
