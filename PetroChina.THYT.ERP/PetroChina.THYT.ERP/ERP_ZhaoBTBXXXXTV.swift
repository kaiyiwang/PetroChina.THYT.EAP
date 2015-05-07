//
//  ERP_ZhaoBTBXXXXTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-15.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit

class ERP_ZhaoBTBXXXXTV: UITableViewController,NSXMLParserDelegate {
    
    var finalData:Detail_302_Base! //基本信息
    //接收列表界面的ID
    var approveId:NSString = ""
    var personTaskId:NSString = ""
    var Resulted:NSString = ""
    var Projected:NSString = ""
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    @IBOutlet weak var textShenPYJ: UITextField!
    @IBOutlet weak var buttonYES: UIButton!
    @IBOutlet weak var buttonNO: UIButton!
    var userId:NSString = "" //审核人编号
//    @IBOutlet weak var textShenPYJ: UITextField!//审批意见
//    @IBOutlet weak var textShenPYJ: UITextField!
    var type:NSString = "" //纪录是否同意
    var parserXml:NSXMLParser! //处理返回的状态信息
    var stateOk:NSString = "" //极了返回过来的状态，处理成功与否
    var currentNodeName:String! //当前的node
    let dataArrLeft = ["结果编号：","项目编号：","待办编号：","审批编号：","项目编号：","项目名称：","物资大类：","预算金额：","货币种类：","税种编号：","税率(%)：","用户单位：","开标时间：","主持人：","主用户单位：","是否投资：","是否直采：","协议物资：","选商方式：","最初价格：","最终价格：","评委：","开标地点：","推荐意见：","交货日期：","质量等期限：","交货地点：","运输及保险：","货物验收：","货款结算：","变更原因：","备注：","附件标题：","附件路径："]
    let dataArrRight = ["汇总编号","编制标号","物料组","物料名","物料名称","计量单位","需求数量","预计单价","预计采购数量","技术要求","处理意见"]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
//    var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE302"
        var soapStr:NSMutableString =  "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:appDetailsQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
    
    var b = ERP_ZhaoBJGShP_Detail_302()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置按钮边框
        buttonYES.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonYES.layer.borderWidth = 1.0
        //        submitBit.layer.cornerRadius = 2.0
        //        submitBit.layer.masksToBounds = true
        buttonNO.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonNO.layer.borderWidth = 1.0
        
        
         var strId:NSString = ""
        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
        var dictSoapData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("soapString", ofType: "plist")!)!)//获取soap
        var url:NSString = dictUrlData!["ZhaoBTB302"] as! NSString
        var soapStr1:NSMutableString = dictSoapData!["ZhaoBTB302"] as! NSMutableString
        
        var data:NSData!
        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) //获取目录
        
        if sp.count > 0{
            var urlText = NSURL(fileURLWithPath: "\(sp[0])/data301.txt")
            if let b = urlText?.path{
                data = NSData(contentsOfFile: b)
            }
//            var strId:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!//获取到aproId
            if data == nil{
                println("nil")
                finalData = Detail_302_Base()
            }else {
                 strId = NSString(data: data, encoding: NSUTF8StringEncoding)!//获取到aproId
                var strArray:NSArray = strId.componentsSeparatedByString(",")
                //            for str in strArray {
                //                println(str)
                //            }
                //            self.tbview.addSubview(myView)
                approveId = strArray[0] as! NSString
                personTaskId = strArray[1] as! NSString
                Resulted = strArray[2] as! NSString
                Projected = strArray[3] as! NSString
                userId = strArray[4] as! NSString
                soapStr.appendString(approveId as String)
                soapStr.appendString("&lt;/approveId&gt; &lt;personTaskId&gt;")
                soapStr.appendString(personTaskId as String)
                soapStr.appendString("&lt;/personTaskId&gt;&lt;resulted&gt;")
                soapStr.appendString(Resulted as String)
                soapStr.appendString("&lt;/resulted&gt;&lt;projected&gt;")
                soapStr.appendString(Projected as String)
                soapStr.appendString("&lt;/projected&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:appDetailsQuery></soapenv:Body></soapenv:Envelope>")
                b.connectToUrl(ZhaoBiaoDetailUrl_Global, soapStr: soapStr)
                finalData = b.parserDataBase
                
            }
           
            //test youxiang
            //            var soapStr2 = soapStr1.stringByAppendingString(approveId)
            //            var soapStr3 = soapStr2.stringByAppendingString("&lt;/approveId&gt; &lt;personTaskId&gt;")
            //            var soapStr4 = soapStr3.stringByAppendingString(personTaskId)
            //            var soapStr5 = soapStr4.stringByAppendingString("&lt;/personTaskId&gt;&lt;resulted&gt;")
            //            var soapStr6 = soapStr5.stringByAppendingString(Resulted)
            //            var soapStr7 = soapStr6.stringByAppendingString("&lt;/resulted&gt;&lt;projected&gt;")
            //            var soapStr8 = soapStr7.stringByAppendingString(Projected)
            //            var soapStr = soapStr8.stringByAppendingString("&lt;/projected&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:appDetailsQuery></soapenv:Body></soapenv:Envelope>")
            //test youxiang
            
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func btn_BuTY(sender: AnyObject) {
        type = "0"
        sendHuiFa(approveId, perId: personTaskId, resId: Resulted, proId: Projected, tp: type, appCommt: textShenPYJ.text, usId: userId)

    }
    
    @IBAction func btn_TongY(sender: AnyObject) {
        type = "1"
        sendHuiFa(approveId, perId: personTaskId, resId: Resulted, proId: Projected, tp: type, appCommt: textShenPYJ.text, usId: userId)
    }
 
    //当点击同意／不同意按钮时，发送相关的请求，获取操作是否成功的状态
    func sendHuiFa(apId:NSString,perId:NSString,resId:NSString,proId:NSString,tp:NSString,appCommt:NSString,usId:NSString){
//        var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE303"
        var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:resultAppResult><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
        soapStr.appendString(apId as String)
        soapStr.appendString("&lt;/approveId&gt; &lt;personTaskId&gt;")
        soapStr.appendString(perId as String)
        soapStr.appendString("&lt;/personTaskId&gt;&lt;resultId&gt;")
        soapStr.appendString(resId as String)
        soapStr.appendString("&lt;/resultId&gt;&lt;projectId&gt;")
        soapStr.appendString(proId as String)
        soapStr.appendString("&lt;/projectId&gt;&lt;isPassed&gt;")
        soapStr.appendString(tp as String)
        soapStr.appendString("&lt;/isPassed&gt;&lt;comment&gt;")
        soapStr.appendString(appCommt as String)
        soapStr.appendString("&lt;/comment&gt;&lt;appUserId&gt;")
        soapStr.appendString(usId as String)
        soapStr.appendString("&lt;/appUserId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:resultAppResult></soapenv:Body></soapenv:Envelope>")
        connectResult(ZhaoBiaoSendUrl_Global, soapStr: soapStr)
    }

    //获取303返回的数据
    func connectResult(ur:NSString,soapStr:NSMutableString) {
        
        var conData = ReturnHttpConnectionAuth() // 获取返回的数据类对象
        var data = conData.connectionData(ur, soapStr: soapStr)
        var str = NSString(data: data, encoding: NSUTF8StringEncoding)
        var str1 = NSString(data: data, encoding: NSUTF8StringEncoding)
        if  data == "nil"{
            var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络没有连接")
        }else {
            var data = str?.dataUsingEncoding(NSUTF8StringEncoding)
            var ps = ProcessData(proData:data!)
            var str1 = NSString(data: ps.returnTo, encoding: NSUTF8StringEncoding)
                        println(str1)
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
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
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        if currentNodeName == "state" {
            stateOk = string!
            println("赋值成功\(string)")
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        label1.text = dataArrLeft[indexPath.row]
        
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        //        label2.text = dataArrRight[indexPath.row]
        switch indexPath.row {
        case 0:
            label2.text = finalData.resultId as String
        case 1:
            label2.text = finalData.projectId as String
        case 2:
            label2.text = finalData.personTaskId as String
        case 3:
            label2.text = finalData.approveId as String
        case 4:
            label2.text = finalData.projectNum as String
        case 5:
            label2.text = finalData.matId as String
        case 6:
            label2.text = finalData.sumMatMoney as String
        case 7:
            label2.text = finalData.currencyTypeName as String
        case 8:
            label2.text = finalData.invoiceTypeName as String
        case 9:
            label2.text = finalData.taxRate as String
        case 10:
            label2.text = finalData.reqUnitName as String
        case 11:
            label2.text = finalData.openBidDate as String
        case 12:
            label2.text = finalData.bidHostPerson as String
        case 13:
            label2.text = finalData.mainReqUnitName as String
        case 14:
            label2.text = finalData.isTz as String
        case 15:
            label2.text = finalData.isZc as String
        case 16:
            label2.text = finalData.isXy as String
        case 17:
            label2.text = finalData.isOne as String
        case 18:
            label2.text = finalData.stockMethodName as String
        case 19:
            label2.text = finalData.firstMoney as String
        case 20:
            label2.text = finalData.resultMoney as String
        case 21:
            label2.text = finalData.bidJudgePerson as String
        case 22:
            label2.text = finalData.openBidPlace as String
        case 23:
            label2.text = finalData.bidProposal as String
        case 24:
            label2.text = finalData.deliveryDesc as String
        case 25:
            label2.text = finalData.technicReq as String
        case 26:
            label2.text = finalData.deliveryPlace as String
        case 27:
            label2.text = finalData.transportWay as String
        case 28:
            label2.text = finalData.Pack as String
        case 29:
            label2.text = finalData.matPay as String
        case 30:
            label2.text = finalData.changeCause as String
        case 31:
            label2.text = finalData.remark as String
        case 32:
            label2.text = finalData.adjunctTitle as String
        case 33:
            label2.text = finalData.adjunctPath as String
        default:
            println("err in gongyingshang_base")
        }
        
        return cell
    }
    
    
}
