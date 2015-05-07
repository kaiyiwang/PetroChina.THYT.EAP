//
//  OA_YeWShP.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_YeWShP: UITableViewController {

    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    var lingDao = false
    var yuanGong = false
    //菊花
    var myview:JvHua!
    var myRefresh = UIRefreshControl() //刷新控件
    var finalDataOfLingDaoQingXiaoJia:Array<DaiBanData> = [] //存储领导请销假信息
    var finalDataOfYuanGongQingXiaoJia:Array<DaiBanData> = []//存储员工请销假信息
    var finalDataOfDaiBan:Array<DaiBanData> = [] //存储代办信息
    var showData:Array<DaiBanData> = [] //显示的数据
    var dataArrLeft = ["标题","提交人","接收时间","文件类型","当前环节","查看流程"]
    var dataArrRight = ["消息产业关于表彰2013先进党员","吐哈油田信字（2014）3号","2014-05-13","2014-05-13"," "," "]
    
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
//        println("LingDao:\(lingDao)YuanGong:\(yuanGong)")
        //获取数据
        finalDataOfDaiBan = getParserData_DaiBan()
        finalDataOfLingDaoQingXiaoJia = findLingDaoQingXiaoJia(finalDataOfDaiBan) //获得请销假管理的数据
        finalDataOfYuanGongQingXiaoJia = findYuanGongQingXiaoJia(finalDataOfDaiBan)//获得员工请销假的数据
        //判断显示哪个数据
        if lingDao == true {
            showData = finalDataOfLingDaoQingXiaoJia
        }else if yuanGong == true {
            showData = finalDataOfYuanGongQingXiaoJia
        }
        if showData.count == 0 {
            var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: false)
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
    //将领导请销假信息找出来
    func findLingDaoQingXiaoJia(strArray:Array<DaiBanData>) -> Array<DaiBanData> {
        var findData:Array<DaiBanData> = []
        for obj in strArray {
            if obj.dbsyhead.isEqualToString(LingDaoQingXiaoJiaGL_Global) {
                findData.append(obj)
            }
        }
        return findData
    }
    //将员工请销假信息找出来
    func findYuanGongQingXiaoJia(strArray:Array<DaiBanData>) -> Array<DaiBanData> {
        var findData:Array<DaiBanData> = []
        for obj in strArray {
            if obj.dbsyhead.isEqualToString(YuanGongQingXiaoJiaGL_Global) {
                findData.append(obj)
            }
        }
        return findData
    }
//    //将勘探地质审批信息找出来
//    func findKanTanDiZhiShenPi(strArray:Array<DaiBanData>) -> Array<DaiBanData> {
//        var findData:Array<DaiBanData> = []
//        for obj in strArray {
//            if obj.dbsyhead.isEqualToString(KanTanDiZhiShenPi_Global) {
//                findData.append(obj)
//            }
//        }
//        return findData
//    }
    //返回大厅按钮触发事件
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    //刷新触发的事件
    func reload(){
        getDaiBanData()
        //获取数据
        finalDataOfDaiBan = getParserData_DaiBan()
        finalDataOfLingDaoQingXiaoJia = findLingDaoQingXiaoJia(finalDataOfDaiBan) //获得请销假管理的数据
        finalDataOfYuanGongQingXiaoJia = findYuanGongQingXiaoJia(finalDataOfDaiBan)//获得员工请销假的数据
        //判断显示哪个数据
        if lingDao == true {
            showData = finalDataOfLingDaoQingXiaoJia
        }else if yuanGong == true {
            showData = finalDataOfYuanGongQingXiaoJia
        }
        if showData.count == 0 {
            myview.hidden = false
        }else{
            myview.hidden = true
        }
        

        println("reload WenGQF")
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
        return showData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        label2.sizeToFit()
//        textview.editable = true
//        textview.selectable = false
        var obj = showData
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
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //点击cell，表示已查看，然后将文字显示灰色
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
//        textview.textColor = UIColor.grayColor()
//        label2.textColor = UIColor.grayColor()
        //将看过的状态发送给后台,将后台状态改变
        var sendHouTai:NSString = changeDbsyStateFirst_Global + "\(showData[indexPath.row].id)" + changeDbsyStateSecond_Global
        var sendStateDbsy = ReturnHttpConnection()
        var dataLast = sendStateDbsy.connectionData(UrlString_Global, soapStr: sendHouTai)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
        //                                println("receiveStateinOAFWZSW:\(str)")
        
        //界面跳转
        var dest = self.storyboard?.instantiateViewControllerWithIdentifier("YeWShPDetail") as! OA_YeWShPDetail
        let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
        dest.workflowIdgg = showData[index].docid
        dest.senderName = showData[index].sendername
        self.navigationController?.pushViewController(dest, animated: true)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        
//        
//        if segue.identifier == "QingXiaoJiaYeWu" {
//            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
//            let myVC = segue.destinationViewController as OA_YeWShPDetail
//            myVC.workflowIdgg = showData[index].docid
//            myVC.senderName = showData[index].sendername
//        }
//
//    }
 


}
