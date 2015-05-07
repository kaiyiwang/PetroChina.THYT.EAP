//
//  ERP_HeTGLTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-14.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit


import UIKit

class ERP_HeTGLTV: UITableViewController ,UITableViewDelegate{
    //    UIScrollViewDelegate,
    var approId:NSString = "" //要发送给显示详细内容界面的ID
    var perTaskId:NSString = ""//要发送给显示详细内容界面的ID
    var userId:NSString = "" //要发送给显示详细内容界面的ID 审核人编号
    var finalDatas:Array<List_201> = [] //要显示的列表的数据
    
    @IBOutlet weak var headerView: UIView!
    //    var url:NSString = "http://10.218.8.213:8630/pt/services/MOVE201" //声明wsdl的url
    //要发送的soap的内容
    //    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:xuanShangAppDataList><!--Optional:--><xuanShangAppQuery>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;0000000128&lt;/userId&gt; &lt;unitId&gt;010101&lt;/unitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</xuanShangAppQuery></sap:xuanShangAppDataList></soapenv:Body></soapenv:Envelope>"
    //    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:xuanShangAppDataList><!--Optional:--><xuanShangAppQuery>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;gfEmail&gt;shiyf@petrochina.com.cn&lt;/gfEmail&gt;&lt;/row&gt; &lt;/xuanShang&gt;</xuanShangAppQuery></sap:xuanShangAppDataList></soapenv:Body></soapenv:Envelope>"
    
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    var b = ERP_HTXSh_List_201() //获取RecData对象
    // MARK: - UITableViewDelegate
    //格式化列表页面Row间隔显示方式&颜色
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
    
    //滑动导航
    @IBOutlet var scrollView: UITableView!
    var containerView: UIView!
    var refresh = UIRefreshControl()//刷新
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //404界面
        var imageView = UIImageView(image: UIImage(named: "404.png"))
        imageView.center = CGPointMake(self.view.center.x,self.view.center.y - 30)
        self.view.addSubview(imageView)
        
        var uiview = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150))
        self.tableView.tableFooterView = uiview
        
        self.tableView.addSubview(headerView)
        
        
        //刷新
        refresh.attributedTitle = NSAttributedString(string: "正在刷新")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
//        self.refreshControl = refresh
        
        //        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
        //        var url:NSString = dictUrlData!["HeTGL201"] as NSString
        //
        var sendData:NSString = (HeTXuanShangFirst_Global as String) + "\(getUserId_Global())" + (HeTXuanShangSecond_Global as String) + "\(getUnitId_Global())" + (HeTXuanShangThird_Global as String)
        
        println("合同管理SendData：\(sendData)")
        b.connectToUrl(HeTXuanShangURL_Global, soapStr: sendData)
        finalDatas = b.parserDatas //获取到数据
        println("返回的数据是-----" + "\(b.parserDatas)")
        //设置图标显示的数字 （必须要在读取到数据之后）
        if hetongguanliXianshi == 0 {
            UIApplication.sharedApplication().applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + finalDatas.count
            hetongguanliXianshi = 1
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
    //使tableviewcell的第一行不能被点击
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
    }
    func reload(){
        
        println("reload")
        var b = ERP_HTXSh_List_201() //获取RecData对象
        var sendData:NSString = (HeTXuanShangFirst_Global as String) + "\(getUserId_Global())" + (HeTXuanShangSecond_Global as String) + "\(getUnitId_Global())" + (HeTXuanShangThird_Global as String)
        b.connectToUrl(HeTXuanShangURL_Global, soapStr: sendData)
        finalDatas = b.parserDatas //获取到数据
        //                 refresh.attributedTitle = NSAttributedString(string: "开始刷新")
        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
        var date = NSDate()
        println(date)
        //                 refresh.attributedTitle = NSAttributedString(string: "结束刷新")
    }
    //
    //    override func beginRefreshing(){
    //        println("begin")
    //    }
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
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        headerView.frame = CGRectMake(headerView.frame.origin.x, 100+self.tableView.contentOffset.y, headerView.frame.size.width, headerView.frame.size.height)
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
        return b
    }
    //    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    ////        println("headerView")
    //
    //        return headerView
    //    }
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
                //                data.appendString(approId)
                //                data.appendString(perTaskId)
                data.appendString("\(approId),") //继续添加字符
                data.appendString("\(perTaskId),")
                data.appendString("\(userId),")
                if let b = url?.path {
                    data.writeToFile(b, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
                }
                
            }
            
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        if indexPath.row == 0 {
            label1.text = "待办业务名称"
            
            label2.text = "业务编号"
        } else {
            var dataObj = finalDatas[indexPath.row-1]
            
            label1.text = dataObj.personTaskName
            
            label2.text = dataObj.approveId
        }
        
        return cell
        
        
        
        
        
        //        func viewDidLoad(){
        //            if(self.edgesForExtendedLayout(selector(edgesForExtendedLayout))){
        //                self.edgesForExtendedLayout = UIRectEdge;
        //            }
        //        }
        
    }
    
    
}
