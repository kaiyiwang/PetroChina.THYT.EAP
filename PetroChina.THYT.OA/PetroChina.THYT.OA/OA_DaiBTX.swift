//
//  OA_DaiBTX.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_DaiBTX: UITableViewController {

    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    //菊花
    var myview:JvHua!
    var myRefresh = UIRefreshControl() //刷新控件
    var finalDataOfDaiBan:Array<DaiBanData> = [] //存储代办信息
    var biaoti = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //菊花显示
        myview = JvHua(frame: CGRect(x: self.view.center.x-50, y: self.view.center.y-150, width: 100, height: 100))
        self.view.addSubview(myview)
        //移除空得单元格
//        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        //刷新实现
        myRefresh.attributedTitle = NSAttributedString(string: "正在刷新")
        myRefresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = myRefresh
        
        finalDataOfDaiBan = getParserData_DaiBan()
		if finalDataOfDaiBan.count == 0 {
			var timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: true)
		}else{
			myview.activityIndicatorView.stopAnimating()
		}
        //设置图标显示的数字 （必须要在读取到数据之后）
        UIApplication.sharedApplication().applicationIconBadgeNumber = finalDataOfDaiBan.count
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
	func stop(){
		myview.activityIndicatorView.stopAnimating()
	}
    //返回大厅按钮触发事件
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    //刷新触发的事件
    func reload(){
        
        println("reload DaiBTX")
        var sendData:NSString = DaiBanFirst_Global + YouXiang_Global + DaiBanSecond_Global
        var bb = allDataOfDaiBan()
        bb.connectToUrl(UrlString_Global, soapStr: sendData)
        finalDataOfDaiBan = getParserData_DaiBan()
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
        return finalDataOfDaiBan.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        var textview1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        var label3 = cell.viewWithTag(3) as! UILabel
        label3.hidden = true
        var obj = finalDataOfDaiBan
        //表示已查看
        if obj[indexPath.row].state.isEqualToString("01"){
//            println("已查看:\(indexPath.row)")
            textview1.textColor = UIColor.grayColor()
            label2.textColor = UIColor.grayColor()
            label3.textColor = UIColor.grayColor()

        }else {
            textview1.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
            label3.textColor = UIColor.blackColor()
        }
        // Configure the cell...
        
//        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as UILabel
//        label1.text = dataArrLeft[indexPath.row]
        

        textview1.text = obj[indexPath.row].title as String
        self.biaoti = textview1.text!
        label2.text = returnTimerNum(obj[indexPath.row].gtime) as String
        label3.text = obj[indexPath.row].dbsyhead as String
        
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
        var label3 = cell.viewWithTag(3) as! UILabel
        textview.textColor = UIColor.grayColor()
        label2.textColor = UIColor.grayColor()
        label3.textColor = UIColor.grayColor()
        label3.sizeToFit()
        //将看过的状态发送给后台,将后台状态改变
        var sendHouTai:NSString = changeDbsyStateFirst_Global + "\(finalDataOfDaiBan[indexPath.row].id)" + changeDbsyStateSecond_Global
        var sendStateDbsy = ReturnHttpConnection()
        var dataLast = sendStateDbsy.connectionData(UrlString_Global, soapStr: sendHouTai)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//                println("receiveState:\(str)")
        //判断点击的cell的代办事项的类型，然后跳转到相应的详细显示页面
        var strOfDB = finalDataOfDaiBan[indexPath.row].dbsyhead
        switch strOfDB {
        case ErJiDanWeiFaWen_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("WenGQFDetail") as! OA_WenGQFDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case ErJiDanWeiShW_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("FaWZhShDetail") as! OA_FaWZhShDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case ChuShiShW_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("FaWZhShDetail") as! OA_FaWZhShDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case ShiYeBuShW_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("FaWZhShDetail") as! OA_FaWZhShDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case GeRenShW_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("GeRShWDetail") as! OA_GeRShWDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.mailName = YouXiang_Global
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case LingDaoQingXiaoJiaGL_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("YeWShPDetail") as! OA_YeWShPDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowIdgg = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case YuanGongQingXiaoJiaGL_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("YeWShPDetail") as! OA_YeWShPDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowIdgg = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case KaiFaJingGongChengShP_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("OtherYeWShPDetail") as! OtherYeWShPDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case ZuanJingDiZhiSP_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("OtherYeWShPDetail") as! OtherYeWShPDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case KanTanDiZhiShenPi_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("OtherYeWShPDetail") as! OtherYeWShPDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case BiaoWaiZiJinCaiWuFKShP_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("CaiWuFuKuan") as! OA_CaiWuFuKuanDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case CaiWuFuKuanShP_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("CaiWuFuKuan") as! OA_CaiWuFuKuanDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case ZuanJingDiZhiSPQi_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("OtherYeWShPDetail") as! OtherYeWShPDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)
        case TanJingZuanJingGongChengShP_Global:
            //界面跳转
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("OtherYeWShPDetail") as! OtherYeWShPDetail
            dest.wenJianBiaoTi = self.biaoti
            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
            dest.workflowId = finalDataOfDaiBan[index].docid
            dest.senderName = finalDataOfDaiBan[index].sendername
            self.navigationController?.pushViewController(dest, animated: true)

        default:
            NSLog("=================================")
        }
        
    }
 
//    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        return nil
//    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
////         println("selected:\(self.tableView.indexPathForSelectedRow()!.row)")
//        if segue.identifier == "DaiBan" {
//           let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
//           let myVC = segue.destinationViewController as OA_DaiBTXDetail
//            myVC.workflowId = finalDataOfDaiBan[index].docid
//            myVC.mailName = YouXiang_Global
//            
//        }
//    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
////        if segue.identifier == "FaWenZhShW" {
//            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
//            let myVC = segue.destinationViewController as OA_FaWZhShDetail
//            myVC.workflowId = finalDataOfDaiBan[index].docid
//            myVC.senderName = finalDataOfDaiBan[index].sendername
////        }
//        
//    }


}
