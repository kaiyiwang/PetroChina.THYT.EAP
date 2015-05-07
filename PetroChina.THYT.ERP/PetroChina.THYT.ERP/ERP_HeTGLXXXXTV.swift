//
//  ERP_WuZGLXXXXTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-15.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit


class ERP_HeTGLXXXXTV: UITableViewController ,NSXMLParserDelegate {
    
    var approId:NSString = ""
    var perTaskId:NSString = ""
    var userId:NSString = "" //审核人编号
    var type:NSString = "" //纪录是否同意
    //    let TAG_CELL_LABELLeft = 1
    //    let TAG_CELL_LABELRight = 2
    var parserXml:NSXMLParser! //处理返回的状态信息
    var stateOk:NSString = "" //极了返回过来的状态，处理成功与否
    var currentNodeName:String! //当前的node
//    @IBOutlet weak var aaaaa: UITextField!
    var str:NSString = ""
    var dataArrRight = [String]()
    var finalData:Detail_202!
    
    @IBOutlet weak var buttonYES: UIButton!
    @IBOutlet weak var buttonNO: UIButton!
    @IBOutlet weak var bbbbb: UITextField!  //建议
    var dataNiXDW:Array<Detail_202_NiXDW> = [] //拟选单位
    var dataWenJXX:Array<Detail_202_WenJXX> = []//文件信息
    var dataChaoSYHXX:Array<Detail_202_ChaoSYHXX> = []//抄送用户信息
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
//    var url:NSString = "http://10.218.8.213:8630/pt/services/MOVE202"
    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:xuanShangAppDetail><!--Optional:--><xuanShangAppDetailQuery>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
    let dataArrLeft = ["合同名称:","合同类型:","报审序号:","承办人单位:","资金流向:","资金渠道:","招标方式:","预算金额:","货币类型:","招标组织:","划分标段:"]
    //    let dataArrRight = ["2014-06-04","2014-06-04","2014-06-04","2014-06-04","2014-06-04","2014-06-04","2014-06-04","2014-06-04","2014-06-04","2014-06-04","2014-06-04"]
    var b = ERP_HeTXSh_202()
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置按钮边框
        buttonYES.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonYES.layer.borderWidth = 1.0
        //        submitBit.layer.cornerRadius = 2.0
        //        submitBit.layer.masksToBounds = true
        
        buttonNO.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonNO.layer.borderWidth = 1.0
        var data:NSData!
        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
        if sp.count > 0 {
            var urlTxt = NSURL(fileURLWithPath: "\(sp[0])/data.txt")
            if let b = urlTxt?.path {
                data = NSData(contentsOfFile: b)
            }
            var strId:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!//获取到aproId
            var strArray:NSArray = strId.componentsSeparatedByString(",")
//            println(strArray.count)
//                                    for str in strArray {
//                                        println(str)
//                                    }

            if let str:NSString = strArray[0] as? NSString{
                approId = strArray[0] as! NSString
            }
            if let str:NSString = strArray[1] as? NSString{
                perTaskId = strArray[1] as! NSString
            }
            if let str:NSString = strArray[2] as? NSString{
                userId = strArray[2] as! NSString
            }
            }
            
        
            
            //            println(approId)
            //            println(perTaskId)
            //根据id获取数据
            soapStr.appendString(approId as String)
            soapStr.appendString("&lt;/approveId&gt; &lt;personTaskId&gt;")
            soapStr.appendString(perTaskId as String)
            soapStr.appendString("&lt;/personTaskId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</xuanShangAppDetailQuery></sap:xuanShangAppDetail></soapenv:Body></soapenv:Envelope>")
            b.connectToUrl(HeTXuanShangDetailUrl_Global, soapStr: soapStr)
            finalData = b.currentParserData
            dataNiXDW = b.dataNiXDW  //拟选单位
            dataWenJXX = b.dataWenJXX //文件信息
            dataChaoSYHXX = b.dataChaoSYHXX //抄送用户信息

            //            if finalData.errCode != "0" {
            //                finalData = nil
            //            }
            
            
            
            
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    @IBAction func btn_dissAgree(sender: AnyObject) {
        type = "0"
        println("approId:\(approId) perTaskId:\(perTaskId) type:\(type) bbbbb.text:\(bbbbb.text) copyP:  userId:\(userId)")
        sendHuiFa(approId, perId: perTaskId, tp: type, appCommt: bbbbb.text, copyP: "", usId: userId)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    @IBAction func btn_Agree(sender: AnyObject) {
        type = "1" //
        
        println("approId:\(approId) perTaskId:\(perTaskId) type:\(type) bbbbb.text:\(bbbbb.text) copyP:  userId:\(userId)")
        sendHuiFa(approId, perId: perTaskId, tp: type, appCommt: bbbbb.text, copyP: "", usId: userId)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func btn_TongYClicked(sender: AnyObject) {
        
    }
    @IBAction func btn_BuTYClicked(sender: AnyObject) {
            }
    //当点击同意／不同意按钮时，发送相关的请求，获取操作是否成功的状态
    func sendHuiFa(apId:NSString,perId:NSString,tp:NSString,appCommt:NSString,copyP:NSString,usId:NSString){
//        var url:NSString = "http://10.218.8.213:8630/pt/services/MOVE203"
//          var url:NSString = "http://10.218.8.213:8080/pt/services/MOVE203"
        var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:xuanShangAppResult><!--Optional:--><xuanShangAppResult>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;"
        soapStr.appendString(usId as String)
        soapStr.appendString("&lt;/userId&gt; &lt;type&gt;")
        soapStr.appendString(tp as String)
        soapStr.appendString("&lt;/type&gt;&lt;approveId&gt;")
        soapStr.appendString(apId as String)
        soapStr.appendString("&lt;/approveId&gt; &lt;personTaskId&gt;")
        soapStr.appendString(perId as String)
        soapStr.appendString("&lt;/personTaskId&gt;&lt;approveComment&gt;&lt;/approveComment&gt;&lt;copyToUsers&gt;&lt;/copyToUsers&gt;&lt;/row&gt; &lt;/xuanShang&gt;</xuanShangAppResult></sap:xuanShangAppResult></soapenv:Body></soapenv:Envelope>")
        connectResult(HeTXuanShangSendUrl_Global, soapStr: soapStr)
    }
    //获取203返回的数据
    func connectResult(ur:NSString,soapStr:NSMutableString) {
        
        var conData = ReturnHttpConnection() // 获取返回的数据类对象
        var data = conData.connectionData(ur, soapStr: soapStr)
         var str = NSString(data: data, encoding: NSUTF8StringEncoding)
        if  data == "nil"{
            var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络没有连接")
        }else {
            var data = str?.dataUsingEncoding(NSUTF8StringEncoding)
            var ps = ProcessData(proData:data!)
//            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
            var str1 = NSString(data: ps.returnTo, encoding: NSUTF8StringEncoding)
//            println(str1)
            NSLog("返回的数据：\(str1)")
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            if stateOk.isEqualToString("1") {
                println("审批成功")
            var alert = UIAlertView(title: "温馨提示", message: "合同:\(finalData.ctrName)已审批成功", delegate: self, cancelButtonTitle: "确定")
                
                alert.show()
                
//                performSegueWithIdentifier("HeTXSh", sender: self)
            }else if stateOk.isEqualToString("0")
            {
                var alert = UIAlertView(title: "温馨提示", message: "合同:\(finalData.ctrName)审批失败", delegate: self, cancelButtonTitle: "确定")
                alert.show()
//                self.dismissViewControllerAnimated(true, completion: nil)
//                performSegueWithIdentifier("HeTXSh", sender: self)
                println("审批失败")
            }else if stateOk.isEqualToString("") {
                println("wrong")
            }
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
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
            label2.text = finalData.ctrName as String
        case 1:
            label2.text = finalData.ctrTypeName as String
        case 2:
            label2.text = finalData.reportNo as String
        case 3:
            label2.text = finalData.inputPersonDept as String
        case 4:
            label2.text = finalData.fundAllocation as String
        case 5:
            label2.text = finalData.fundDitchName as String
        case 6:
            label2.text = finalData.inviteBidTypeName as String
        case 7:
            label2.text = finalData.budgetSum as String
        case 8:
            label2.text = finalData.priceTypeName as String
        case 9:
            label2.text = finalData.inviteBidKind as String
        case 10:
            label2.text = finalData.divideBid as String
        default:
            print("wrong in HeTGLDATA")
        }
        return cell
        
    }
    
    
}
