//
//  ERP_ZhaoBTBTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-14.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit

class ERP_ZhaoBTBTV: UITableViewController {
    
    //要发送给显示详细内容界面的ID
    var approveId:NSString = ""
    var personTaskId:NSString = ""
    var Resulted:NSString = ""
    var Projected:NSString = ""
    var usrId:NSString = ""
    var finalData:Array<List_301> = []
    //    var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE301"
//    var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE301"
//    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:resultAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;appUserId&gt;1000000074&lt;/appUserId&gt; &lt;appUnitId&gt;001001006&lt;/appUnitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:resultAppListQuery></soapenv:Body></soapenv:Envelope>"
    //    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sap="http://sap.move.com/"><soapenv:Header/><soapenv:Body><sap:resultAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;gfEmail&gt;lixiaojun@petrochina.com.cn&lt;/gfEmail&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:resultAppListQuery></soapenv:Body></soapenv:Envelope>"
    
    
    
    //滑动导航
    
    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    var b = ERP_ZhaoBJGShP_301()
    var refresh = UIRefreshControl()//刷新
    override func viewDidLoad() {
        super.viewDidLoad()
        //刷新
        refresh.attributedTitle = NSAttributedString(string: "正在刷新")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        
        //test youxiang
        //        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
        //        var dictSoapData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("soapString", ofType: "plist")!)!)//获取soap
        //        var url:NSString = dictUrlData!["ZhaoBTB301"] as NSString
        //        var soapStr1:NSMutableString = dictSoapData!["ZhaoBTB301"] as NSMutableString
        //        var soapStr2 = soapStr1.stringByAppendingString("lixiaojun@petrochina.com.cn")
        //        var soapStr = soapStr2.stringByAppendingString("&lt;/gfEmail&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:resultAppListQuery></soapenv:Body></soapenv:Envelope>")
        //test youxiang
        var sendData = (ZhaoBiaoFirst_Global as String) + "\(getUserId_Global())" + (ZhaoBiaoSecond_Global as String) + "\(getUnitId_Global())" + (ZhaoBiaoThird_Global as String)
        
        println("301接口的List SendData：\(sendData)")
        b.connectToUrl(ZhaoBiaoUrl_Global, soapStr: sendData)
        finalData = b.parserDatas
        //设置图标显示的数字 （必须要在读取到数据之后）
        
        if zhaobiaotoubiaoXianshi == 0 {
                    UIApplication.sharedApplication().applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + finalData.count
            zhaobiaotoubiaoXianshi = 1
        }


        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320.0, 44.0)
        containerView = UIView(frame: CGRect(origin: CGPointMake(0.0, 0.0), size:containerSize))
        scrollView.addSubview(containerView)
        
        
        //        let buttonView = UIButton()
        //        buttonView.center = CGPointMake(320.0, 320.0);
        //        containerView.addSubview(buttonView)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scale
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
    }
    func reload(){
          var b = ERP_ZhaoBJGShP_301()
        println("reload")
        var sendData = (ZhaoBiaoFirst_Global as String) + "\(getUserId_Global())" + (ZhaoBiaoSecond_Global as String) + "\(getUnitId_Global())" + (ZhaoBiaoThird_Global as String)
        b.connectToUrl(ZhaoBiaoUrl_Global, soapStr: sendData)
        finalData = b.parserDatas

        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
        //                 refresh.attributedTitle = NSAttributedString(string: "结束刷新")
    }
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        containerView.frame = contentsFrame
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView!?{
        return containerView
    }
    
    override func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //数据
    
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    let dataArrLeft = ["项目编号","项目名称","物资大类代码","货币种类","汇率","开标时间","用户单位","主持人","主用户单位","备注"]
    let dataArrRight = ["2014-09-05","2014-09-05","2014-09-05","2014-09-09","2014-09-07","2014-09-05","2014-05-12","2014-05-05","2014-05-05",""]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    
    @IBAction func btn_Cliacked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var b  = finalData.count
        return b+1
    }
    
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        //        label1.text = dataArrLeft[indexPath.row]
        
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        //        label2.text = dataArrRight[indexPath.row]
        if indexPath.row == 0{
            label1.text = "项目名称"
            label2.text = "项目编号"
        }else{
            var dataObj = finalData[indexPath.row-1]
            
            label1.text = dataObj.projectName
            
            label2.text = dataObj.projectNum
        }
        
        return cell
    }
    //根据点击的cell Index将相应的信息保存在本地
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        //如果点击的是第一个，删除本地的data301.txt文件
        if indexPath.row == 0 {
            //            var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
            //            if sp.count > 0 {
            //                var url = NSURL(fileURLWithPath: "\(sp[0])/data301.txt")
            //                url?.removeCachedResourceValueForKey("data301.txt")
            //            }
        }
        if indexPath.row != 0 {
            
            var dataObj = finalData[indexPath.row-1]
            approveId = dataObj.approvedId
            personTaskId = dataObj.personTaskId
            Resulted = dataObj.sourceId
            Projected = dataObj.projectPtId
            usrId = getUserId_Global()
            //                    println("selected->approveId:\(approId) personTaskId:\(perTaskId)")
            
            //访问沙盒
            var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
            if sp.count > 0 {
                var url = NSURL(fileURLWithPath: "\(sp[0])/data301.txt")
                
                //                            println(url)
                var data = NSMutableString()
                data.appendString("\(approveId),") //继续添加字符
                data.appendString("\(personTaskId),")
                data.appendString("\(Resulted),")
                data.appendString("\(Projected),")
                data.appendString("\(usrId),")
//                                                println("data:\(data)")
                if let b = url?.path {
                    data.writeToFile(b, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
                }
                
            }
            
        }
    }
    //使tableviewcell的第一行不能被点击
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    
    
}
