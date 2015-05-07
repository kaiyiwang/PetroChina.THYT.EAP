//
//  ERP_WuZGLXXXXTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-15.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit


class ERP_WuZGLXXXXTV: UITableViewController,NSXMLParserDelegate {
    
    var approveId:NSString = "" //界面的ID
    var personTaskId:NSString = ""//界面的ID
    var businessId:NSString = ""//界面的ID
    var moduleId:NSString = ""//界面的ID
    
    var unitId:NSString = ""
    var userId:NSString = "" //审核人编号
//    @IBOutlet weak var textShenPYJ: UITextField!//审批意见
    @IBOutlet weak var textYJ: UITextField!
    @IBOutlet weak var buttonYES: UIButton!
    @IBOutlet weak var buttonNO: UIButton!
    
    var type:NSString = "" //纪录是否同意
    var parserXml:NSXMLParser! //处理返回的状态信息
    var stateOk:NSString = "" //极了返回过来的状态，处理成功与否
    var currentNodeName:String! //当前的node
//    var bb:NSString = ""
    //显示数据
    var finalDatas:Array<Detail_102> = []
    var finalDict:Dictionary<String,String> = [:]
    
    //    var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE102"
    //    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:planAppDetailsQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
    //     var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sap="http://sap.move.com/"><soapenv:Header/><soapenv:Body><sap:planAppDetailsQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
    
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    let dataArrLeft = ["汇总编号：","编制标号：","物料组：","物料号：","物料名称：","计量单位：","需求数量：","预计单价：","采购数量："]
    let dataArrRight = ["汇总编号","编制标号","物料组","物料名","物料名称","计量单位","需求数量","预计单价","预计采购数量","技术要求","处理意见"]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    
    var b = ERP_XuQJHShP_Detail_102()
    var refresh = UIRefreshControl()//刷新
    override func viewDidLoad() {
        super.viewDidLoad()
//        println("bb:\(bb)")
//        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.view.setTranslatesAutoresizingMaskIntoConstraints(false)
//        println(self.tableView.translatesAutoresizingMaskIntoConstraints())
        
        //设置按钮边框
        buttonYES.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonYES.layer.borderWidth = 1.0
//        submitBit.layer.cornerRadius = 2.0
//        submitBit.layer.masksToBounds = true
        
        buttonNO.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonNO.layer.borderWidth = 1.0
               //刷新
        refresh.attributedTitle = NSAttributedString(string: "正在刷新")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        //test youxiang
//        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
        var dictSoapData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("soapString", ofType: "plist")!)!)//获取soap
//        var url:NSString = dictUrlData!["WuZGL102"] as NSString
        var soapStr1:NSMutableString = dictSoapData!["WuZGL102"] as! NSMutableString
        //获取查询id
        var data:NSData!
        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) //获取目录
        
        if sp.count > 0{
            var urlText = NSURL(fileURLWithPath: "\(sp[0])/data101.txt")
            if let b = urlText?.path{
                data = NSData(contentsOfFile: b)
            }
            //测试获取到得数据
            var domain = NSURL(fileURLWithPath: "\(sp[0])/domain.txt")
            if let a = domain?.path {
                var bb = NSData(contentsOfFile: a)
                if bb == nil {
                    
                }else {
                    var str:NSString = NSString(data: bb!, encoding: NSUTF8StringEncoding)!
                    var strArray1:NSArray = str.componentsSeparatedByString(",")
                    var domain = strArray1[0] as! NSString
                    var loginID = strArray1[1] as! NSString
                    var all = strArray1[2] as! NSString
                    var alert = UIAlertView(title: "平台数据测试", message: "domain:\(str) LoginID:\(loginID) all:\(all)", delegate: self, cancelButtonTitle: "确定")
                    alert.show()
                }
                
            }
            var strId:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!//获取到aproId
            var strArray:NSArray = strId.componentsSeparatedByString(",")
            approveId = strArray[0] as! NSString
            personTaskId = strArray[1] as! NSString
            businessId = strArray[2] as! NSString
            moduleId = strArray[3] as! NSString
            userId = strArray[4] as! NSString
            unitId = strArray[5] as! NSString
            var soapStr2 = soapStr1.stringByAppendingString(approveId as String)
            var soapStr3 = soapStr2.stringByAppendingString("&lt;/approveId&gt;&lt;personTaskId&gt;")
            var soapStr4 = soapStr3.stringByAppendingString(personTaskId as String)
            var soapStr5 = soapStr4.stringByAppendingString("&lt;/personTaskId&gt;&lt;businessId&gt;")
            var soapStr6 = soapStr5.stringByAppendingString(businessId as String)
            var soapStr7 = soapStr6.stringByAppendingString("&lt;/businessId&gt;&lt;moduleId&gt;")
            var soapStr8 = soapStr7.stringByAppendingString(moduleId as String)
            var soapStr = soapStr8.stringByAppendingString("&lt;/moduleId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:planAppDetailsQuery></soapenv:Body></soapenv:Envelope>")
            b.connectToUrl(WuZiDetailUrl_Global, soapStr: soapStr)
            finalDatas = b.parserDatas
            finalDict = b.dictDatas
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func reload(){
        
        println("reload")
        self.tableView.reloadData()
        
        self.refreshControl?.endRefreshing()
        //                 refresh.attributedTitle = NSAttributedString(string: "结束刷新")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btn_BTYClicked(sender: AnyObject) {
        type = "0"
        sendHuiFa(approveId, perId: personTaskId, bussId: businessId, modId: moduleId, tp: type, appCommt: textYJ.text, planMxId: finalDatas[0].plan2ndMxId , usId: userId,unitId:unitId)
        
    }
    @IBAction func btn_TYClicked(sender: AnyObject) {
        type = "1"
        sendHuiFa(approveId, perId: personTaskId, bussId: businessId, modId: moduleId, tp: type, appCommt: textYJ.text, planMxId: finalDatas[0].plan2ndMxId , usId: userId,unitId:unitId)
    }
 
    //当点击同意／不同意按钮时，发送相关的请求，获取操作是否成功的状态
    func sendHuiFa(apId:NSString,perId:NSString,bussId:NSString,modId:NSString,tp:NSString,appCommt:NSString,planMxId:NSString,usId:NSString,unitId:NSString){
       // var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE103"
//         var url:NSString = "http://10.218.8.213:8080/thwlpt/ws/MOVE103"
        var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:planAppResultManage><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
        soapStr.appendString(apId as String)
        soapStr.appendString("&lt;/approveId&gt;&lt;personTaskId&gt;")
        soapStr.appendString(perId as String)
        soapStr.appendString("&lt;/personTaskId&gt;&lt;businessId&gt;")
        soapStr.appendString(bussId as String)
        soapStr.appendString("&lt;/businessId&gt;&lt;moduleId&gt;")
        soapStr.appendString(modId as String)
        soapStr.appendString("&lt;/moduleId&gt;&lt;isPassed&gt;")
        soapStr.appendString(tp as String)
        soapStr.appendString("&lt;/isPassed&gt;&lt;approveComment&gt;")
        soapStr.appendString(appCommt as String)
        soapStr.appendString("&lt;/approveComment&gt;&lt;plan2ndMxId&gt;")
        soapStr.appendString(planMxId as String)
        soapStr.appendString("&lt;/plan2ndMxId&gt;&lt;appUserId&gt;")
        soapStr.appendString(usId as String)
        soapStr.appendString("&lt;/appUserId&gt; &lt;appUnitId&gt;")
        soapStr.appendString(unitId as String)
        soapStr.appendString("&lt;/appUnitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:planAppResultManage></soapenv:Body></soapenv:Envelope>")
        println("soapStr请求头：\(soapStr)")
        connectResult(WuZiSendUrl_Global, soapStr: soapStr)
    }
    //获取103返回的数据
    func connectResult(ur:NSString,soapStr:NSMutableString) {
        
        var conData = ReturnHttpConnectionAuth() // 获取返回的数据类对象
        var data = conData.connectionData(ur, soapStr: soapStr)
        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
        if  str == "nil"{
            var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络没有连接")
        }else {
            println("返回值：\(str)")
            var data = str?.dataUsingEncoding(NSUTF8StringEncoding)
             var ps = ProcessData(proData:data!)
            var str1 = NSString(data: ps.returnTo, encoding: NSUTF8StringEncoding)
                        println("经过处理的返回值：\(str1)")
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            NSLog("stateOkstateOkstateOkstateOk:\(stateOk)")
            if stateOk.isEqualToString("1") {
                println("审批成功")
                var alert = UIAlertView(title: "温馨提示", message: "您已审批成功", delegate: self, cancelButtonTitle: "确定")
//
                alert.show()
                
                //                performSegueWithIdentifier("HeTXSh", sender: self)
            }else if stateOk.isEqualToString("0")
            {
                var alert = UIAlertView(title: "温馨提示", message: "审批失败", delegate: self, cancelButtonTitle: "确定")
                alert.show()
                //                self.dismissViewControllerAnimated(true, completion: nil)
                //                performSegueWithIdentifier("HeTXSh", sender: self)
                println("审批失败")
            }else if stateOk.isEqualToString("") {
                println("wrong")
            }
        }
    }
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
        print("currentNodeName\(currentNodeName)")
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        println("charactor:\(string)")
        if currentNodeName == "state" {
            stateOk = string!
            println("赋值成功\(string)")
        }

    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        var b  = finalDatas.count
       
        return dataArrLeft.count
        
    }
    
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
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        //        label1.text = dataArrLeft[indexPath.row]
        
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        //        label2.text = dataArrRight[indexPath.row]
//        if indexPath.row == 0 {
//            label1.text = "汇总编号"
//            
//            label2.text = "物料名称"
//        } else {
//            var dataObj = finalDatas[indexPath.row]
//            
//            label1.text = dataObj.collectNum
//            
//            label2.text = dataObj.matName
//        }
//        if indexPath.row < 9 {
            label1.text = dataArrLeft[indexPath.row]
//        }
        
        var dataObj = finalDatas[0]
        switch indexPath.row {
        case 0:
            label2.text = dataObj.collectNum as String
        case 1:
            label2.text = dataObj.plan2ndNum as String
        case 2:
            label2.text = dataObj.matGroupId as String
        case 3:
            label2.text = dataObj.matId as String
        case 4:
            label2.text = dataObj.matName as String
        case 5:
            label2.text = dataObj.matUnit as String
        case 6:
            label2.text = dataObj.reqAmount as String
        case 7:
            label2.text = dataObj.matPrice as String
        case 8:
            label2.text = dataObj.preAmount as String
//        case 9:
//            label2.text = dataObj.technicReq

        default:
            println("wuziguanli default")
        }
        

        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
