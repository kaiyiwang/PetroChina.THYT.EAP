//
//  ERP_GongYSGLXXXXTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-15.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit

class ERP_GongYSGLXXXXTV: UITableViewController {
    
    var finalData:Detail_602_Base! //基本信息
    
    //接收列表界面的ID
    var approId:NSString = ""
    var perTaskId:NSString = ""
    var providerDetailId:NSString = ""
    var admitId:NSString = ""
    var isHse:NSString = ""
    var statusType:NSString = ""
    var businessId:NSString = ""
    var appUserId:NSString = ""
    //   var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE602"
    var soapStr1:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:ResultDetailsQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
    
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    var b = ERP_GongYShGL_Detail_602()
    
    let dataArrLeft = ["供应商序号：","供应商名称：","组织机构：","营业执照号：","住所：","注册资金：","法人姓名：","法人身份证：","被授权人姓名：","被授权人身份证：","联系人：","联系手机号：","预约日期：","相对人性质：","单位类别：","预审单位：","经营范围："]
    let dataArrRight = ["汇总编号","编制标号","物料组","物料名","物料名称","计量单位","需求数量","预计单价","预计采购数量","技术要求","处理意见"]
    let dataTitle = ["基本页面","附件信息","扩展信息"]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    
    
    
    @IBOutlet weak var myview: UIView!
    
    var refresh = UIRefreshControl()//刷新
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.addSubview(myview)//防止tableview盖住
        //刷新
        refresh.attributedTitle = NSAttributedString(string: "正在刷新")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        
        
//        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
//        //        var dictSoapData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("soapString", ofType: "plist")!)!)//获取soap
//        var url:NSString = dictUrlData!["GongYShGL602"] as NSString
        
//        var url:NSString = "http://10.218.219.239:8600/tuham2/ws/MOVE602"
//        var url:NSString = "http://10.218.219.239:8080/tuham2/ws/MOVE602"
        //        var soapStr1:NSMutableString = dictSoapData!["GongYShGL602"] as NSMutableString
        //
        var data:NSData!
        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) //获取目录
        
        if sp.count > 0{
            var urlText = NSURL(fileURLWithPath: "\(sp[0])/data601.txt")
            if let b = urlText?.path{
                data = NSData(contentsOfFile: b)
            }
            if data == nil{
                println("nil")
                finalData = Detail_602_Base()
            }else {
            var strId:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!//获取到aproId
//            println("not nil")
//                println(strId)
            var strArray:NSArray = strId.componentsSeparatedByString(",")
            //                        for str in strArray {
            //                            println(str)
            //                        }
            //            self.tbview.addSubview(myView)
            approId = strArray[0] as! NSString
            perTaskId = strArray[1] as! NSString
            providerDetailId = strArray[2] as! NSString
            admitId = strArray[3] as! NSString
            isHse = strArray[4] as! NSString
            statusType = strArray[5] as! NSString
            businessId = strArray[6] as! NSString
            appUserId = strArray[7] as! NSString
            
            soapStr1.appendString(approId as String)
            soapStr1.appendString("&lt;/approveId&gt; &lt;personTaskId&gt;")
            soapStr1.appendString(perTaskId as String)
            soapStr1.appendString("&lt;/personTaskId&gt;&lt;providerDetailId&gt;")
            soapStr1.appendString(providerDetailId as String)
            soapStr1.appendString("&lt;/providerDetailId&gt;&lt;admitId&gt;")
            soapStr1.appendString(admitId as String)
            soapStr1.appendString("&lt;/admitId&gt;&lt;isHse&gt;")
            soapStr1.appendString(isHse as String)
            soapStr1.appendString("&lt;/isHse&gt;&lt;statusType&gt;")
            soapStr1.appendString(statusType as String)
            soapStr1.appendString("&lt;/statusType&gt;&lt;businessId&gt;")
            soapStr1.appendString(businessId as String)
            soapStr1.appendString("&lt;/businessId&gt;&lt;appUserId&gt;")
            soapStr1.appendString(appUserId as String)
            soapStr1.appendString("&lt;/appUserId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:ResultDetailsQuery></soapenv:Body></soapenv:Envelope>")
            //test youxiang
            //            var soapStr2 = soapStr1.stringByAppendingString(approId)
            //            var soapStr3 = soapStr2.stringByAppendingString("&lt;/approveId&gt; &lt;personTaskId&gt;")
            //            var soapStr4 = soapStr3.stringByAppendingString(perTaskId)
            //            var soapStr5 = soapStr4.stringByAppendingString("&lt;/personTaskId&gt;&lt;providerDetailId&gt;")
            //            var soapStr6 = soapStr5.stringByAppendingString(providerDetailId)
            //            var soapStr7 = soapStr6.stringByAppendingString("&lt;/providerDetailId&gt;&lt;admitId&gt;")
            //            var soapStr8 = soapStr7.stringByAppendingString(admitId)
            //            var soapStr9 = soapStr8.stringByAppendingString("&lt;/admitId&gt;&lt;isHse&gt;")
            //            var soapStr10 = soapStr9.stringByAppendingString(isHse)
            //            var soapStr11 = soapStr10.stringByAppendingString("&lt;/isHse&gt;&lt;statusType&gt;")
            //            var soapStr12 = soapStr11.stringByAppendingString(statusType)
            //            var soapStr13 = soapStr12.stringByAppendingString("&lt;/statusType&gt;&lt;businessId&gt;")
            //            var soapStr14 = soapStr13.stringByAppendingString(businessId)
            //            var soapStr15 = soapStr14.stringByAppendingString("&lt;/businessId&gt;&lt;gfEmail&gt;")
            //            var soapStr16 = soapStr15.stringByAppendingString(appUserId)
            //            var soapStr = soapStr16.stringByAppendingString("&lt;/gfEmail&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:ResultDetailsQuery></soapenv:Body></soapenv:Envelope>")
            //test youxiang
            b.connectToUrl(GongYingDetailUrl_Global, soapStr: soapStr1)
            finalData = b.parserDataBase
            }
            //            println(finalDataDict)
        }
        
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
     override func viewWillAppear(animated: Bool) {
        self.tableView.addSubview(myview)
    }
    override func viewDidAppear(animated: Bool) {
        self.tableView.addSubview(myview)
    }
    func reload(){
        
        println("reload")
        self.tableView.reloadData()
        
        self.refreshControl?.endRefreshing()
        //                 refresh.attributedTitle = NSAttributedString(string: "结束刷新")
    }
    //    override func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
    //        println("scroll")
    //    }
    override func scrollViewDidScroll(scrollView: UIScrollView){
//        println("scrole")
        myview.frame = CGRectMake(myview.frame.origin.x, 64+self.tableView.contentOffset.y, myview.frame.size.width, myview.frame.size.height) //固定位置
        //        println("x:\(myView.frame.origin.x)y:\(80+self.tableView.contentOffset.y)Width:\(myView.frame.size.width)height:\(myView.frame.size.height)")
        //         println("change")
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
        return dataArrLeft.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellg", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        label1.text = dataArrLeft[indexPath.row]
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        switch indexPath.row {
        case 0:
            label2.text = finalData.tempProviderId
        case 1:
            label2.text = finalData.providerName
        case 2:
            label2.text = finalData.organizeNum
        case 3:
            label2.text = finalData.businessCode
        case 4:
            label2.text = finalData.providerAddr
        case 5:
            label2.text = finalData.registerMoney
        case 6:
            label2.text = finalData.juridicalPerson
        case 7:
            label2.text = finalData.juridicalIdCard
        case 8:
            label2.text = finalData.bentrustPerson
        case 9:
            label2.text = finalData.bentrustIdCard
        case 10:
            label2.text = finalData.linkPerson
        case 11:
            label2.text = finalData.linkCellphone
        case 12:
            label2.text = finalData.createCate
        case 13:
            label2.text = finalData.providerKindName
        case 14:
            label2.text = finalData.providerLevelName
        case 15:
            label2.text = finalData.acceptUnitName
        case 16:
            label2.text = finalData.tempProviderId
        case 17:
            label2.text = finalData.marketScope
        default:
            println("err in gongyingshang_base")
        }
        
        return cell
    }
    
}
