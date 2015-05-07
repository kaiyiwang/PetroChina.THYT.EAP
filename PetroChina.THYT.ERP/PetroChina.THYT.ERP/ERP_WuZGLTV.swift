//
//  ERP_WuZGLTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-14.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit


class ERP_WuZGLTV: UITableViewController ,UITableViewDelegate{
    
    
    
    var approveId:NSString = "" //要发送给显示详细内容界面的ID
    var personTaskId:NSString = ""//要发送给显示详细内容界面的ID
    var businessId:NSString = ""//要发送给显示详细内容界面的ID
    var moduleId:NSString = ""//要发送给显示详细内容界面的ID
    var useId:NSString = "" //要发送给显示详细内容界面的ID
    var unitId:NSString = ""
    
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    var finalDatas:Array<List_101> = []
    
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    //    var url:NSString = "http://10.218.152.3:8600/tuham2/ws/MOVE101"
    //var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:planAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;gfEmail&gt;sjld@petrochina.com.cn&lt;/gfEmail&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:planAppListQuery></soapenv:Body></soapenv:Envelope>"
    //    planAppListQuery
    
    
    var b = ERP_XuQJHShP_101()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    var refresh = UIRefreshControl()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NSLog("\(getPersons_Global().count)")
        NSLog("getUserId_Global():\(getUserId_Global())  getUnitId_Global():\(getUnitId_Global())")
        self.refreshControl?.beginRefreshing()
        //判断用户当前ios系统
        var version = UIDevice.currentDevice().systemVersion
        var isIos8 = version.hasPrefix("8")
        println("isIos8:\(isIos8)")
        if isIos8 {
            var setting = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(setting)
        }
        
        //            println(url)
        //刷新
        refresh.attributedTitle = NSAttributedString(string: "正在刷新")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        //
        //youxiang test
        //        //获取用户的邮箱
        //        var data:NSData!
        //        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
        //        if sp.count > 0 {
        //            var urlTxt = NSURL(fileURLWithPath: "\(sp[0])/config.txt")
        //            if let b = urlTxt?.path {
        //                data = NSData(contentsOfFile: b)
        //            }
        //            var youXiang = NSString(data: data, encoding: NSUTF8StringEncoding)//获取用户的邮箱
        //            println(youXiang)
        //        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
        //        var dictSoapData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("soapString", ofType: "plist")!)!)//获取soap
        //        var url:NSString = dictUrlData!["WuZGL101"] as NSString
        //        var soapStr1:NSMutableString = dictSoapData!["WuZGL101"] as NSMutableString
        //        var soapStr2 = soapStr1.stringByAppendingString(youXiang!)
        //        var soapStr = soapStr2.stringByAppendingString("&lt;/gfEmail&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:planAppListQuery></soapenv:Body></soapenv:Envelope>")
        //youxiang test
        //        println(soapStr)
        var sendData = (WuZiFirst as String) + "\(getUserId_Global())" + (WuZiSecond as String) + "\(getUnitId_Global())" + (WuZiThird as String)
        println("物资SendData:\(sendData)")
        b.connectToUrl(WuZiURL_Global, soapStr: sendData)//获取数据
        finalDatas = b.parserDatas//得到数据
        
            UIApplication.sharedApplication().applicationIconBadgeNumber = finalDatas.count
        
        
        //        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.refreshControl?.endRefreshing()
        
        
    }
    func reload(){
        println("reload")
        var b = ERP_XuQJHShP_101()
        var sendData = (WuZiFirst as String) + "\(getUserId_Global())" + (WuZiSecond as String) + "\(getUnitId_Global())" + (WuZiThird as String)
        b.connectToUrl(WuZiURL_Global, soapStr: sendData)//获取数据
        println("b.parserDatas.count:\(b.parserDatas.count)")
        finalDatas = b.parserDatas//得到数据
        println("finalDatas:\(finalDatas.count)")
        self.refreshControl?.endRefreshing()
        sleep(1)
        self.tableView.reloadData()
        //        refresh.attributedTitle = NSAttributedString(string: "结束刷新")
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
    
    //    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    //
    //
    //    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        var b  =
//        println("-----------------\(b)")
        return finalDatas.count+1
        
    }
    
    // MARK: - UITableViewDelegate
    //格式化ListView隔行现实效果。
    override func tableView(
        tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("cellw", for IndexPath) as! UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
        // Configure the cell...
        //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            //let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
           // var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
           // var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel

        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
//                label1.text = dataArrLeft[indexPath.row]
        
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        //        label2.text = dataArrRight[indexPath.row]
        if indexPath.row == 0 {
            label1.text = "计划汇总编号"
            
            label2.text = "业务编号"
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        } else {
            var dataObj = finalDatas[indexPath.row-1]
            
            label1.text = dataObj.collectNum as String
            
            label2.text = dataObj.approveId as String
        }
        
        cell.accessoryType =  UITableViewCellAccessoryType.None
        
        return cell
    }
    
    //根据点击的cell Index将相应的信息保存在本地
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        if indexPath.row != 0 {
            
            var dataObj = finalDatas[indexPath.row-1]
            approveId = dataObj.approveId
            personTaskId = dataObj.personTaskId
            businessId = dataObj.businessId
            moduleId = dataObj.moduleId
            useId = getUserId_Global() //动态的哦
            unitId = getUnitId_Global()
            //                                println("selected->approveId:\(businessId) personTaskId:\(collectNum)")
            
            //访问沙盒
            var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
            if sp.count > 0 {
                var url = NSURL(fileURLWithPath: "\(sp[0])/data101.txt")
                //                            println(url)
                var data = NSMutableString()
                data.appendString("\(approveId),") //继续添加字符
                data.appendString("\(personTaskId),")
                data.appendString("\(businessId),")
                data.appendString("\(moduleId),")
                data.appendString("\(useId),")
                data.appendString("\(unitId),")
                //                println(data)
                if let b = url?.path {
                    data.writeToFile(b, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
                }
                
            }
            
        }
    }
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    //override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        //println("moved")
    //}
    //    //传值
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "WuZGL" {
    //        let index = tableView.indexPathForSelectedRow()
    //        let tvController = segue.destinationViewController as ERP_WuZGLXXXXTV
    //
    //        tvController.bb = finalDatas[index!.row-1].approveId
    //        
    //        }
    //    }
    
    
}
