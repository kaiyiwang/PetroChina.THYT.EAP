//
//  ERP_HeTGLTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-14.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit


import UIKit

class ERP_HeTShBTV: UITableViewController ,UIScrollViewDelegate{
    
    var approId:NSString = "" //要发送给显示详细内容界面的ID
    var perTaskId:NSString = ""//要发送给显示详细内容界面的ID
    var userId:NSString = "" //要发送给显示详细内容界面的ID 审核人编号
    var finalDatas:Array<List_211> = [] //要显示的列表的数据
    //    var url:NSString = "http://10.218.152.3:8600/tuham2/ws/MOVE101" //声明wsdl的url
    //var url:NSString = "http://10.218.8.213:8630/pt/services/MOVE211"
    
    //要发送的soap的内容
    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:shenBaoAppDataList><!--Optional:--><shenBaoAppQuery>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;0000000010&lt;/userId&gt; &lt;unitId&gt;010101&lt;/unitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</shenBaoAppQuery></sap:shenBaoAppDataList></soapenv:Body></soapenv:Envelope>"
    var b = ERP_HeTShB_211() //获取RecData对象
    // MARK: - UITableViewDelegate
    //格式化列表页面Row间隔显示方式&颜色
    var refresh = UIRefreshControl()//刷新
    override func tableView(
        tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(red: 1.0, green: 0.99, blue: 0.97, alpha: 1.0) : UIColor(red: 0.96, green: 0.97, blue: 0.92, alpha: 1.0)
        cell.imageView?.layer.cornerRadius = 22.0
        cell.imageView?.layer.masksToBounds = true
        //呈现动态效果图
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })

    }
    
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    
    //滑动导航
    @IBOutlet var scrollView: UITableView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //刷新
        refresh.attributedTitle = NSAttributedString(string: "正在刷新")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        
//        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
//        var url:NSString = dictUrlData!["HeTShB211"] as NSString
//        
        var sendData = (HeTShenBaoFirst_Global as String) + "\(getUserId_Global())" + (HeTShenBaoSecond_Global as String) + "\(getUnitId_Global())" + (HeTShenBaoThird_Global as String)
        println("合同申报SendData：\(sendData)")
        b.connectToUrl(HeTShenBaoURL_Global, soapStr: sendData) //连接url获取数据
        finalDatas = b.parserDatas //获取到数据
        //设置图标显示的数字 （必须要在读取到数据之后）
        if hetongtanpanXianshi == 0 {
                    UIApplication.sharedApplication().applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + finalDatas.count
            hetongtanpanXianshi = 1
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
         var b = ERP_HeTShB_211() //获取RecData对象
        var sendData = (HeTShenBaoFirst_Global as String) + "\(getUserId_Global())" + (HeTShenBaoSecond_Global as String) + "\(getUnitId_Global())" + (HeTShenBaoThird_Global as String)
        b.connectToUrl(HeTShenBaoURL_Global, soapStr: sendData) //连接url获取数据
        finalDatas = b.parserDatas //获取到数据
        println("reload")
        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
        //                 refresh.attributedTitle = NSAttributedString(string: "结束刷新")
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
    
    let dataArrLeft = ["备注","承办人","承办时间","承办单位／部门","状态／阶段","下载（选商审查审批表）"]
    let dataArrRight = ["2014-05-05","2014-05-05","2014-05-05","2014-05-05","2014-05-05","2014-05-05"]
    
    //var data:NSDictionary
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // data = NSDictionary(contentsOfURL: NSBundle.mainBundle().URLForResource("data", withExtension: "plist")!)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        // Uncomment the following line to preserve selection between presentations
    //        // self.clearsSelectionOnViewWillAppear = false
    //
    //        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    //    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var b = finalDatas.count
        return b+1
    }
    
    //根据点击的cell Index将相应的信息保存在本地
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.row != 0 {
            
            var dataObj = finalDatas[indexPath.row-1]
            approId = dataObj.approveId
            perTaskId = dataObj.personTaskId
            userId = "\(getUserId_Global())" //要动态
            //                    println("selected->approveId:\(approId) personTaskId:\(perTaskId)")
            
            //访问沙盒
            var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
            if sp.count > 0 {
                var url = NSURL(fileURLWithPath: "\(sp[0])/data.txt")
                //                            println(url)
                var data = NSMutableString()
//                data.appendString(approId) //继续添加字符
//                data.appendString(perTaskId)
//                data.appendString("\(userId),")
                data.appendString("\(approId),") //继续添加字符
                data.appendString("\(perTaskId),")
                data.appendString("\(userId),")
//                println(data)
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
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        //        println("hahhahaha")
        // Configure the cell...
        if indexPath.row == 0 {
            label1.text = "待办业务名称"
            label2.text = "业务编号"
        }else {
            var dataObj = finalDatas[indexPath.row-1]
            label1.text = dataObj.personTaskName as String
            label2.text = dataObj.approveId as String
        }
        
        return cell
        
        
        
        
        
        //        func viewDidLoad(){
        //            if(self.edgesForExtendedLayout(selector(edgesForExtendedLayout))){
        //                self.edgesForExtendedLayout = UIRectEdge;
        //            }
        //        }
        
    }
    
    
}
