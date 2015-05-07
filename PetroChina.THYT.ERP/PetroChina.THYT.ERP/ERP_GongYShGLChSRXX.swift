//
//  ERP_GongYShGLChSRXX.swift
//  PetroChina.THYT.ERP
//
//  Created by zhaitingting on 14/10/25.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ERP_GongYShGLChSRXX: UITableViewController,NSXMLParserDelegate {


    var parserXml:NSXMLParser! //处理返回的状态信息
     var stateOk:NSString = "" //极了返回过来的状态，处理成功与否
    
     var hasChaoSR = 0  //有没有抄送人信息
    @IBOutlet weak var cellChao: UITableViewCell! //抄送人复选框
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    var finalData:Array<Detail_602_ChaoSR> = [] // 抄送人
     var currentNodeName:String! //当前的node
    var dataBase:Detail_602_Base! //基本信息
    var dataFuJXX:Array<Detail_602_FuJXX> = [] //附件信息
    var currentDataFuJXX:Detail_602_FuJXX!
    
    var dataFuJBase:Array<Detail_602_FuJXX> = [] //附件基本信息
//    var currentDataFuJBase:Detail_602_FuJXX!
    var dataFuJKuoZh:Array<Detail_602_FuJXX> = [] // 附件扩展信息
//    var currentDataFuJKuoZh:Detail_602_FuJXX!
    var dataFuJShenH:Array<Detail_602_FuJXX> = [] //附件审核信息
//    var currentDataFuJShenH:Detail_602_FuJXX!
    var dataWuCQShXX:Array<Detail_602_WuCQShWZXX> = [] // 物采缺少物资信息
    var dataWuCXX:Array<Detail_602_WuCQShWZXX> = [] //物采缺少信息
    var dataPingTXX:Array<Detail_602_WuCQShWZXX> = [] //平台缺少信息
    @IBOutlet weak var showChaoSR: UILabel!
    //接收列表界面的ID
    var approId:NSString = ""
    var perTaskId:NSString = ""
    var providerDetailId:NSString = ""
    var admitId:NSString = ""// 准入序号
    var isHse:NSString = ""
    var statusType:NSString = ""
    var businessId:NSString = ""
    var appUserId:NSString = ""
    
    //要发送给服务器字符串
//    var unitId:NSString = "" //审核人单位
//    var appScope:NSString = "" // 审批准入范围
    var email:NSString = "" //邮箱
    var tempProId:NSString = "" // 供应商编号
    var tempProDetailId:NSString = "" //供应商详情编号
    var proName:NSString = "" //供应商名称
    
    //业务类型变更的radioBtn的状态
    var stateLeft = 0
    var stateRight = 0
    
    
    
//    var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE602"
//    var url:NSString = "http://10.218.219.239:8600/tuham2/ws/MOVE602"

    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:ResultDetailsQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;approveId&gt;"
    
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    var b = ERP_GongYShGL_Detail_602()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置按钮边框
        buttonOK.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonOK.layer.borderWidth = 1.0
        //        submitBit.layer.cornerRadius = 2.0
        //        submitBit.layer.masksToBounds = true
        //防止键盘遮挡输入框
        DaiDodgeKeyboard.addRegisterTheViewNeedDodgeKeyboard(self.view)
        
        buttonSave.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        buttonSave.layer.borderWidth = 1.0
        
        var data:NSData!
        var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) //获取目录
        
        if sp.count > 0{
            var urlText = NSURL(fileURLWithPath: "\(sp[0])/data601.txt")
            if let b = urlText?.path{
                data = NSData(contentsOfFile: b)
            }
            var strId:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!//获取到aproId
            var strArray:NSArray = strId.componentsSeparatedByString(",")
            //            for str in strArray {
            //                println(str)
            //            }
            //            self.tbview.addSubview(myView)
            approId = strArray[0] as! NSString
            perTaskId = strArray[1] as! NSString
            providerDetailId = strArray[2] as! NSString
            admitId = strArray[3] as! NSString
            isHse = strArray[4] as! NSString
            statusType = strArray[5] as! NSString
            businessId = strArray[6] as! NSString
            appUserId = strArray[7] as! NSString
            soapStr.appendString(approId as String)
            soapStr.appendString("&lt;/approveId&gt; &lt;personTaskId&gt;")
            soapStr.appendString(perTaskId as String)
            soapStr.appendString("&lt;/personTaskId&gt;&lt;providerDetailId&gt;")
            soapStr.appendString(providerDetailId as String)
            soapStr.appendString("&lt;/providerDetailId&gt;&lt;admitId&gt;")
            soapStr.appendString(admitId as String)
            soapStr.appendString("&lt;/admitId&gt;&lt;isHse&gt;")
            soapStr.appendString(isHse as String)
            soapStr.appendString("&lt;/isHse&gt;&lt;statusType&gt;")
            soapStr.appendString(statusType as String)
            soapStr.appendString("&lt;/statusType&gt;&lt;businessId&gt;")
            soapStr.appendString(businessId as String)
            soapStr.appendString("&lt;/businessId&gt;&lt;appUserId&gt;")
            soapStr.appendString(appUserId as String)
            soapStr.appendString("&lt;/appUserId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:ResultDetailsQuery></soapenv:Body></soapenv:Envelope>")
            b.connectToUrl(GongYingDetailUrl_Global, soapStr: soapStr)
            NSLog("---------------------\(soapStr)")
            finalData = b.parserDataChaoSR
            dataBase = b.parserDataBase
            dataFuJXX = b.parserDataFuJXX
            dataWuCQShXX = b.parserDataWuCQShWZXX
            //将附件信息区分，1.附件信息2.扩展附件信息3.审核附件信息
            distinguishDataOfFujian(dataFuJXX)
            distinguishDataOfWuC(dataWuCQShXX)
            var bbbb = finalData[0]
            showChaoSR.text = bbbb.approvePerson
            
            //判断是否有抄送人信息
            
            if finalData.count == 1 && finalData[0].approvePerson == "" {
                hasChaoSR = 0
            }else{
                hasChaoSR = finalData.count
            }
            
          
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    //将附件信息区分，1.附件信息2.扩展附件信息3.审核附件信息
    func distinguishDataOfFujian(dataArray:Array<Detail_602_FuJXX>){
        for obj in dataArray {
            if obj.isExtecsion == 0 {
//                println(0) 
                dataFuJBase.append(obj)
                
            }
            if obj.isExtecsion == 1 {
//                println(1)
                dataFuJKuoZh.append(obj)
            }
            if obj.isExtecsion == 2 {
//                println(2)
                dataFuJShenH.append(obj)
            }
        }
//        println("\(dataFuJBase.count)")
    }
    //将物采信息区分
    func distinguishDataOfWuC(dataArray:Array<Detail_602_WuCQShWZXX>) {
        for obj in dataArray {
            if obj.isWuZQShXX == true {
                dataWuCXX.append(obj)
            }
            if obj.isWuZQShXX == false {
                dataPingTXX.append(obj)
            }
        }
    }
   
    
    //radio控件
    @IBOutlet weak var radioBianG_R: UIButton!
    @IBOutlet weak var radioBianG_L: UIButton!
    @IBAction func radioBtn_BianG_LeftClicked(sender: AnyObject) {
        if stateRight == 1 || stateLeft == 0{
            if stateLeft == 0 {
                var image = UIImage(named: "radio_on")
                radioBianG_L.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                radioBianG_R.setBackgroundImage(imageOff, forState: nil)
                stateLeft = 1
                stateRight = 0
            }
        }
     
        
    }
  
    @IBAction func radioBtn_BianG_RightClicked(sender: AnyObject) {
        if stateLeft == 1 || stateRight == 0{
            if stateRight == 0 {
                var image = UIImage(named: "radio_on")
                radioBianG_R.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                radioBianG_L.setBackgroundImage(imageOff, forState: nil)
                stateRight = 1
                stateLeft = 0
            }

        }
            }
    //安全环保审批radio
    var st1L = 0
    var st1R = 0
    @IBOutlet weak var HuanBaoRight: UIButton!
    @IBOutlet weak var HuanBaoLeft: UIButton!
    @IBAction func radioHuanBLeft(sender: AnyObject) {
        if st1R == 1 || st1L == 0{
            if st1L == 0 {
                var image = UIImage(named: "radio_on")
                HuanBaoLeft.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                HuanBaoRight.setBackgroundImage(imageOff, forState: nil)
                st1L = 1
                st1R = 0
            }
        }

    }
    @IBAction func radioHuanBRight(sender: AnyObject) {
        if st1L == 1 || st1R == 0{
            if st1R == 0 {
                var image = UIImage(named: "radio_on")
                HuanBaoRight.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                HuanBaoLeft.setBackgroundImage(imageOff, forState: nil)
                st1R = 1
                st1L = 0
            }
        }

    }
    //物资审批radio
    var st2L = 0
    var st2R = 0
    @IBOutlet weak var ShenPLeft: UIButton!
    @IBOutlet weak var ShenPRight: UIButton!
    @IBAction func radioShenPLeft(sender: AnyObject) {
        if st2R == 1 || st2L == 0{
            if st2L == 0 {
                var image = UIImage(named: "radio_on")
                ShenPLeft.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                ShenPRight.setBackgroundImage(imageOff, forState: nil)
                st2L = 1
                st2R = 0
            }
        }

    }
    @IBAction func radioShenPRight(sender: AnyObject) {
        if st2L == 1 || st2R == 0{
            if st2R == 0 {
                var image = UIImage(named: "radio_on")
                ShenPRight.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                ShenPLeft.setBackgroundImage(imageOff, forState: nil)
                st2R = 1
                st2L = 0
            }
        }
    }
    //审批结果radio
    var st3L = 0
    var st3R = 0
    @IBOutlet weak var JieGRight: UIButton!
    @IBOutlet weak var JieGLeft: UIButton!
    @IBAction func radioJieGRight(sender: AnyObject) {
        if st3L == 1 || st3R == 0{
            if st3R == 0 {
                var image = UIImage(named: "radio_on")
                JieGRight.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                JieGLeft.setBackgroundImage(imageOff, forState: nil)
                st3L = 0
                st3R = 1
            }
        }

    }
    
    @IBAction func radioJieGLeft(sender: AnyObject) {
        if st3R == 1 || st3L == 0{
            if st3L == 0 {
                var image = UIImage(named: "radio_on")
                JieGLeft.setBackgroundImage(image, forState: nil)
                var imageOff = UIImage(named: "radio_off")
                JieGRight.setBackgroundImage(imageOff, forState: nil)
                st3R = 0
                st3L = 1
            }
        }
    }
    
    @IBOutlet weak var remarkXX: UITextField!  //物资备注
    @IBOutlet weak var approveCommentXX: UITextField! //审批意见
    @IBOutlet weak var wzRemarkXX: UITextField! //备注信息
    //checkBox 控件
    @IBOutlet weak var check: UIButton!
    var isCheck = 0
    @IBAction func btn_Checked(sender: AnyObject) {
        if isCheck == 0 {
           
            var checkImage = UIImage(named: "check_on")
            check.setBackgroundImage(checkImage, forState: nil)
            isCheck = 1
        }else if isCheck == 1 {
            var checkImage = UIImage(named: "check_off")
            check.setBackgroundImage(checkImage, forState: nil)
            isCheck = 0
        }
    }
    
    @IBOutlet weak var btn_QueD: UIButton!
    var status:NSInteger = 0 //当前的状态 0表示临时保存 1表示提交
    @IBAction func btn_QueDing(sender: AnyObject) {
        status = 1
        //获取数据
        updateAllSendData()
        //发送数据
//        status
//        passedState
//        changeTypeState
//        productPassedState
        
        //改过
        sendHuiFa(appUserId, appUnitId: "001001006", aproId: approId, pertaskId: perTaskId, busId: businessId, admId: admitId, temProDetId: providerDetailId, temProId: dataBase.tempProviderId, proName: dataBase.providerName, sts: "\(status)", organNum:dataBase.organizeNum, busCode: dataBase.businessCode, proAddr: dataBase.providerAddr, registMoney: dataBase.registerMoney, juridPerson: dataBase.juridicalPerson, juridIdCard: dataBase.juridicalIdCard, bentrustPer: dataBase.bentrustPerson, bentrustIdCard: dataBase.bentrustIdCard, linkPer: dataBase.linkPerson, linkCellPhone: dataBase.linkCellphone, creatCate: dataBase.createCate, providerKindName: dataBase.providerKindName, providerLevelName: dataBase.providerLevelName, acceptUnitName: dataBase.acceptUnitName, marketScope: dataBase.marketScope, isHse: dataBase.ishse, approveComment: approveCommentXX.text, admitTypeId: dataBase.admitTypeId, appoverAdmitScope: dataBase.appoverAdmitscope, admitScope: dataBase.appoverAdmitscope, isPassed: "\(passedState)", remark:remarkXX.text, email: dataBase.email, changeType: "\(changeTypeState)", productIsPassed: "\(productPassedState)", wzRemark: wzRemarkXX.text, admitDwList: finalData, annexDeList: dataFuJBase, expanAnnexDeList: dataFuJKuoZh, materialProDeList: dataWuCXX, platMaterialDeList: dataPingTXX, approDeList: dataFuJShenH)
        
    }
    @IBAction func btn_LinShBaoCun(sender: AnyObject) {
        status = 0
        //获取数据
        updateAllSendData()
        //发送数据
        //没改过
        sendHuiFa(appUserId, appUnitId: "001001006", aproId: approId, pertaskId: perTaskId, busId: businessId, admId: admitId, temProDetId: tempProDetailId, temProId: tempProId, proName: proName, sts: "\(status)", organNum:dataBase.organizeNum, busCode: dataBase.businessCode, proAddr: dataBase.providerAddr, registMoney: dataBase.registerMoney, juridPerson: dataBase.juridicalPerson, juridIdCard: dataBase.juridicalIdCard, bentrustPer: dataBase.bentrustPerson, bentrustIdCard: dataBase.bentrustIdCard, linkPer: dataBase.linkPerson, linkCellPhone: dataBase.linkCellphone, creatCate: dataBase.createCate, providerKindName: dataBase.providerKindName, providerLevelName: dataBase.providerLevelName, acceptUnitName: dataBase.acceptUnitName, marketScope: dataBase.marketScope, isHse: dataBase.ishse, approveComment: approveCommentXX.text, admitTypeId: dataBase.admitTypeId, appoverAdmitScope: dataBase.appoverAdmitscope, admitScope: dataBase.appoverAdmitscope, isPassed: "\(passedState)", remark:remarkXX.text, email: email, changeType: "\(changeTypeState)", productIsPassed: "\(productPassedState)", wzRemark: wzRemarkXX.text, admitDwList: finalData, annexDeList: dataFuJBase, expanAnnexDeList: dataFuJKuoZh, materialProDeList: dataWuCXX, platMaterialDeList: dataPingTXX, approDeList: dataFuJShenH)
        
    }
    //当点击同意／不同意按钮时，发送相关的请求，获取操作是否成功的状态
    func sendHuiFa(appUseId:NSString,appUnitId:NSString,aproId:NSString,pertaskId:NSString,busId:NSString,admId:NSString,temProDetId:NSString,temProId:NSString,proName:NSString,sts:NSString,organNum:NSString,busCode:NSString,proAddr:NSString,registMoney:NSString,juridPerson:NSString,juridIdCard:NSString,bentrustPer:NSString,bentrustIdCard:NSString,linkPer:NSString,linkCellPhone:NSString,creatCate:NSString,providerKindName:NSString,providerLevelName:NSString,acceptUnitName:NSString,marketScope:NSString,isHse:NSString,approveComment:NSString,admitTypeId:NSString,appoverAdmitScope:NSString,admitScope:NSString,isPassed:NSString,remark:NSString,email:NSString,changeType:NSString,productIsPassed:NSString,wzRemark:NSString,admitDwList:Array<Detail_602_ChaoSR>,annexDeList:Array<Detail_602_FuJXX>,expanAnnexDeList:Array<Detail_602_FuJXX>,materialProDeList:Array<Detail_602_WuCQShWZXX>,platMaterialDeList:Array<Detail_602_WuCQShWZXX>,approDeList:Array<Detail_602_FuJXX>){
//        var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE603"
//        var url:NSString = "http://10.218.219.239:8600/tuham2/ws/MOVE603"
//        var url:NSString = "http://10.218.219.239:8080/tuham2/ws/MOVE603"
        var soapString:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:ExaminationResultDetails><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;appUserId&gt;"
        soapString.appendString(appUseId as String)
        soapString.appendString("&lt;/appUserId&gt;&lt;appUnitId&gt;")
        soapString.appendString(appUnitId as String)
        soapString.appendString("&lt;/appUnitId&gt;&lt;approveId&gt;")
        soapString.appendString(aproId as String)
        soapString.appendString("&lt;/approveId&gt;&lt;personTaskId&gt;")
        soapString.appendString(pertaskId as String)
        soapString.appendString("&lt;/personTaskId&gt;&lt;businessId&gt;")
        soapString.appendString(busId as String)
        soapString.appendString("&lt;/businessId&gt;&lt;admitId&gt;")
        soapString.appendString(admId as String)
        soapString.appendString("&lt;/admitId&gt;&lt;tempProviderDetailId&gt;")
        soapString.appendString(temProDetId as String)
        soapString.appendString("&lt;/tempProviderDetailId&gt;&lt;tempProviderId&gt;")
        soapString.appendString(temProId as String)
        soapString.appendString("&lt;/tempProviderId&gt;&lt;providerName&gt;")
        soapString.appendString(proName as String)
        soapString.appendString("&lt;/providerName&gt;&lt;status&gt;")
        soapString.appendString(sts as String)
        soapString.appendString("&lt;/status&gt;&lt;organizeNum&gt;")
        soapString.appendString(organNum as String)
        soapString.appendString("&lt;/organizeNum&gt;&lt;businessCode&gt;")
        soapString.appendString(busCode as String)
        soapString.appendString("&lt;/businessCode&gt;&lt;providerAddr&gt;")
        soapString.appendString(proAddr as String)
        soapString.appendString("&lt;/providerAddr&gt;&lt;registerMoney&gt;")
        soapString.appendString(registMoney as String)
        soapString.appendString("&lt;/registerMoney&gt;&lt;juridicalPerson&gt;")
        soapString.appendString(juridPerson as String)
        soapString.appendString("&lt;/juridicalPerson&gt;&lt;juridicalIdCard&gt;")
        soapString.appendString(juridIdCard as String)
        soapString.appendString("&lt;/juridicalIdCard&gt;&lt;bentrustPerson&gt;")
        soapString.appendString(bentrustPer as String)
        soapString.appendString("&lt;/bentrustPerson&gt;&lt;bentrustIdCard&gt;")
        soapString.appendString(bentrustIdCard as String)
        soapString.appendString("&lt;/bentrustIdCard&gt;&lt;linkPerson&gt;")
        soapString.appendString(linkPer as String)
        soapString.appendString("&lt;/linkPerson&gt;&lt;linkCellphone&gt;")
        soapString.appendString(linkCellPhone as String)
        soapString.appendString("&lt;/linkCellphone&gt;&lt;createCate&gt;")
        soapString.appendString(creatCate as String)
        soapString.appendString("&lt;/createCate&gt;&lt;providerKindName&gt;")
        soapString.appendString(providerKindName as String)
        soapString.appendString("&lt;/providerKindName&gt;&lt;providerLevelName&gt;")
        soapString.appendString(providerLevelName as String)
        soapString.appendString("&lt;/providerLevelName&gt;&lt;acceptUnitName&gt;")
        soapString.appendString(acceptUnitName as String)
        soapString.appendString("&lt;/acceptUnitName&gt;&lt;marketScope&gt;")
        soapString.appendString(marketScope as String)
        soapString.appendString("&lt;/marketScope&gt;&lt;isHse&gt;")
        soapString.appendString(isHse as String)
        soapString.appendString("&lt;/isHse&gt;&lt;approveComment&gt;")
        soapString.appendString(approveComment as String)
        soapString.appendString("&lt;/approveComment&gt;&lt;admitTypeId&gt;")
        soapString.appendString(admitTypeId as String)
        soapString.appendString("&lt;/admitTypeId&gt;&lt;appoverAdmitScope&gt;")
        soapString.appendString(appoverAdmitScope as String)
        soapString.appendString("&lt;/appoverAdmitScope&gt;&lt;admitScope&gt;")
        soapString.appendString(admitScope as String)
        soapString.appendString("&lt;/admitScope&gt;&lt;isPassed&gt;")
        soapString.appendString(isPassed as String)
        soapString.appendString("&lt;/isPassed&gt;&lt;remark&gt;")
        soapString.appendString(remark as String)
        soapString.appendString("&lt;/remark&gt;&lt;email&gt;")
        soapString.appendString(email as String)
        soapString.appendString("&lt;/email&gt;&lt;changeType&gt;")
        soapString.appendString(changeType as String)
        soapString.appendString("&lt;/changeType&gt;&lt;productIsPassed&gt;")
        soapString.appendString(productIsPassed as String)
        soapString.appendString("&lt;/productIsPassed&gt;&lt;wzRemark&gt;")
        soapString.appendString(wzRemark as String)
        soapString.appendString("&lt;/wzRemark&gt;")
        //抄送人
        if hasChaoSR == 0
        {
            soapString.appendString("&lt;admitDetailList&gt;&lt;/admitDetailList&gt;")
        }else {
            soapString.appendString("&lt;admitDetailList&gt;")
            for i in 0..<hasChaoSR {
                soapString.appendString("&lt;admitDetail&gt;&lt;approveUserId&gt;")
                soapString.appendString(finalData[i].approveUserId)
                soapString.appendString("&lt;/approveUserId&gt;&lt;approvePerson&gt;")
                soapString.appendString(finalData[i].approvePerson)
                soapString.appendString("&lt;/approvePerson&gt;&lt;approveUnitId&gt;")
                soapString.appendString(finalData[i].approveUnitId)
                soapString.appendString("&lt;/approveUnitId&gt;&lt;approveUnitName&gt;")
                soapString.appendString(finalData[i].approveUnitName)
                soapString.appendString("&lt;/approveUnitName&gt;&lt;tablename&gt;")
                soapString.appendString(finalData[i].tablename)
                soapString.appendString("&lt;/tablename&gt;&lt;moduleName&gt;")
                soapString.appendString(finalData[i].moduleName)
                soapString.appendString("&lt;/moduleName&gt;&lt;/admitDetail&gt;")
            }
            soapString.appendString("&lt;/admitDetailList&gt;")
        }
        //附件基本信息
        if dataFuJBase.count == 0 && dataFuJBase[0].adjunctPreviewPath == ""{
            soapString.appendString("&lt;annexDetailList&gt;&lt;/annexDetailList&gt;")
        }else {
            soapString.appendString("&lt;annexDetailList&gt;")
            for i in 0..<dataFuJBase.count {
            soapString.appendString("&lt;annexDetail&gt;&lt;adjunctPreviewPath&gt;")
            soapString.appendString(dataFuJBase[i].adjunctPreviewPath)
            soapString.appendString("&lt;/adjunctPreviewPath&gt;&lt;adjunctTitle&gt;")
            soapString.appendString(dataFuJBase[i].adjunctTitle)
            soapString.appendString("&lt;/adjunctTitle&gt;&lt;adjunctPath&gt;")
            soapString.appendString(dataFuJBase[i].adjunctPath)
            soapString.appendString("&lt;/adjunctPath&gt;&lt;adjunctAnnexId&gt;")
            soapString.appendString(dataFuJBase[i].adjunctId)
            soapString.appendString("&lt;/adjunctAnnexId&gt;&lt;approveAnnexComment&gt;")
            soapString.appendString(dataFuJBase[i].approveComment)
            soapString.appendString("&lt;/approveAnnexComment&gt;&lt;isPassedAnnex&gt;")
            soapString.appendString(dataFuJBase[i].isPassed)
            soapString.appendString("&lt;/isPassedAnnex&gt;&lt;fieldName&gt;")
            soapString.appendString(dataFuJBase[i].fieldName)
            soapString.appendString("&lt;/fieldName&gt;&lt;/annexDetail&gt;")
            }
            soapString.appendString("&lt;/annexDetailList&gt;")
        }
        //附件扩展信息
        if dataFuJKuoZh.count == 0  {
            soapString.appendString("&lt;expansionAnnexDetailList&gt;&lt;/expansionAnnexDetailList&gt;")
        }else {
            soapString.appendString("&lt;expansionAnnexDetailList&gt;")
            for i in 0..<dataFuJKuoZh.count {
            
            soapString.appendString("&lt;expansionAnnexDetail&gt;&lt;qualifId&gt;")
                soapString.appendString(dataFuJKuoZh[i].qualifId)
                soapString.appendString("&lt;/qualifId&gt;&lt;qualifName&gt;")
                soapString.appendString(dataFuJKuoZh[i].qualifName)
                soapString.appendString("&lt;/qualifName&gt;&lt;qualifNumber&gt;")
                soapString.appendString(dataFuJKuoZh[i].qualifNumber as String)
                soapString.appendString("&lt;/qualifNumber&gt;&lt;adjunctPreviewPath&gt;")
                soapString.appendString(dataFuJKuoZh[i].adjunctPreviewPath)
                soapString.appendString("&lt;/adjunctPreviewPath&gt;&lt;adjunctTitle&gt;")
                soapString.appendString(dataFuJKuoZh[i].adjunctTitle)
                soapString.appendString("&lt;/adjunctTitle&gt;&lt;adjunctPath&gt;")
                soapString.appendString(dataFuJKuoZh[i].adjunctPath)
                soapString.appendString("&lt;/adjunctPath&gt;&lt;adjunctExpansionId&gt;")
                soapString.appendString(dataFuJKuoZh[i].adjunctId)
                soapString.appendString("&lt;/adjunctExpansionId&gt;&lt;expansionAnnexComment&gt;")
                soapString.appendString(dataFuJKuoZh[i].approveComment)
                soapString.appendString("&lt;/expansionAnnexComment&gt;&lt;isPassedExpansion&gt;")
                soapString.appendString(dataFuJKuoZh[i].isPassed)
                soapString.appendString("&lt;/isPassedExpansion&gt;&lt;/expansionAnnexDetail&gt;")
    
            }
            soapString.appendString("&lt;/expansionAnnexDetailList&gt;")
        }
        if dataWuCXX.count == 0 && dataWuCXX[0].matGroupId == "" {
            soapString.appendString("&lt;materialProductionDetailList&gt;&lt;/materialProductionDetailList&gt;")
        }else {
            soapString.appendString("&lt;materialProductionDetailList&gt;")
            for i in 0..<dataWuCXX.count {
                soapString.appendString("&lt;materialProductionDetail&gt;&lt;matGroupId&gt;")
            soapString.appendString(dataWuCXX[i].matGroupId)
                soapString.appendString("&lt;/matGroupId&gt;&lt;matGroupName&gt;")
                soapString.appendString(dataWuCXX[i].matGroupName)
                soapString.appendString("&lt;/matGroupName&gt;&lt;matLevel&gt;")
                soapString.appendString(dataWuCXX[i].matLevel)
                soapString.appendString("&lt;/matLevel&gt;&lt;/materialProductionDetail&gt;")
            }
            soapString.appendString("&lt;/materialProductionDetailList&gt;")
        }
        if dataPingTXX.count == 0 {
            soapString.appendString("&lt;platformMaterialDetailList&gt;&lt;/platformMaterialDetailList&gt;")
        }else {
            soapString.appendString("&lt;platformMaterialDetailList&gt;")
            for i in 0..<dataPingTXX.count {
                soapString.appendString("&lt;platformMaterialDetail&gt;&lt;matGroupId&gt;")
                soapString.appendString(dataPingTXX[i].matGroupId)
                soapString.appendString("&lt;/matGroupId&gt;&lt;matGroupName&gt;")
                soapString.appendString(dataPingTXX[i].matGroupName)
                soapString.appendString("&lt;/matGroupName&gt;&lt;matLevel&gt;")
                soapString.appendString(dataPingTXX[i].matLevel)
                soapString.appendString("&lt;/matLevel&gt;&lt;/platformMaterialDetail&gt;")
            }
            soapString.appendString("&lt;/platformMaterialDetailList&gt;")
        }
        
        soapString.appendString("&lt;ApprovalDetailList&gt;&lt;/ApprovalDetailList&gt;")
        soapString.appendString("&lt;/row&gt;&lt;/xuanShang&gt;</arg0></sap:ExaminationResultDetails></soapenv:Body></soapenv:Envelope>")
        connectResult(GongYingSendUrl_Global, soapStr: soapString)
        NSLog("发送的数据:\(soapString)")
    }
    //获取603返回的数据
    func connectResult(ur:NSString,soapStr:NSMutableString) {
        
        var conData = ReturnHttpConnectionAuth() // 获取返回的数据类对象
        var data = conData.connectionData(ur, soapStr: soapStr)
         var str = NSString(data: data, encoding: NSUTF8StringEncoding)
        if  data == "nil"{
            var alert = UIAlertView(title: "提示", message: "请开启网络连接", delegate: self, cancelButtonTitle: "确定")
            alert.show()
            println("网络没有连接")
        }else {
            var data = str?.dataUsingEncoding(NSUTF8StringEncoding)
            var ps = ProcessData(proData:data!)
//             var str1 = NSString(data: data, encoding: NSUTF8StringEncoding)
//             NSLog("返回的数据：\(str1)")
//            var ps = ProcessData(proData:conData.connectionData(ur, soapStr: soapStr))
//            var str1 = NSString(data: ps.returnTo, encoding: NSUTF8StringEncoding)
            
            parserXml = NSXMLParser(data: ps.returnTo)
            parserXml.delegate = self
            parserXml.shouldProcessNamespaces = true
            parserXml.shouldReportNamespacePrefixes = true
            parserXml.shouldResolveExternalEntities = true
            parserXml.parse()
            if stateOk.isEqualToString("1") {
                println("审批成功")
                var alert = UIAlertView(title: "温馨提示", message: "已审批成功", delegate: self, cancelButtonTitle: "确定")
                
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
                var alert = UIAlertView(title: "温馨提示", message: "审批失败", delegate: self, cancelButtonTitle: "确定")
                alert.show()
            }
        }
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        currentNodeName = elementName
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
//        if currentNodeName == "state" {
//            stateOk = string
//            println("赋值成功\(string)")
//        }errCode
                if currentNodeName == "state" {
                    stateOk = string!
                    println("赋值成功\(string)")
                }
    }

    //定义 = 0要发送的数据
    var changeTypeState:NSInteger = 0 //业务类型是否变更
    var isHseState:NSInteger = 0 //安全环保处审批
    var productPassedState:NSInteger = 0 //物资审批
    var passedState:NSInteger = 0 //审批结果
    
    func updateAllSendData(){
        if stateLeft == 1 {
            changeTypeState = 1
        }else if stateRight == 1 {
            changeTypeState = 0
        }
        if st1L == 1 {
            isHseState = 1
        }else if st1R == 1 {
            isHseState = 0
        }
        if st2L == 1 {
            productPassedState = 1
        }else if st2R == 1 {
            productPassedState = 0
        }
        if st3L == 1{
            passedState = 1
        }else if st3R == 1 {
            passedState = 0
        }
        
       
//        println("抄送人：\(hasChaoSR)")
//        println("\(changeTypeState)  \(isHseState)  \(productPassedState) \(passedState)")
        for btns in checkBtns{
            println(btns.tag)
//            println(checkBtns.count)
        }
        
//        println("stateLeft:\(stateLeft) stateRight:\(stateRight)")
//        println("stateLeft1:\(st1L) stateRight:\(st1R)")
//        println("stateLeft2:\(st2L) stateRight:\(st2R)")
//        println("stateLeft3:\(st3L) stateRight:\(st3R)")
//        println("check:\(isCheck)")
    }
    var checkBtns = [UIButton]() //抄送人button数组
    var labels = [UILabel]() //抄送人label数组
    //执行两次，第二次会把第一次覆盖掉，多以控件只能使用第二次的。
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //当index.row为7且抄送人数量大于1时，动态地创建button
        if indexPath.row == 7 && hasChaoSR > 1 {
            var x3 = 60
            var x1 = 130
            var x2 =  220
            var y1 = 11
            
            for i in 1..<hasChaoSR{
                switch i {
                case 1:
                    var checkBtn = createButton(CGRect(x: x2, y: y1, width: 22, height: 22))
                    checkBtn.tag = i
                    checkBtns.append(checkBtn)
                    var lbl = createLabel(CGRect(x: x2+25, y: y1, width: 105, height: 21))
                    labels.append(lbl)
                case 2:
                    var checkBtn3 = createButton(CGRect(x: x3, y: y1+44, width: 22, height: 22))
                    checkBtn3.tag = i
                    checkBtns.append(checkBtn3)
                    var lbl = createLabel(CGRect(x: x3+25, y: y1+44, width: 105, height: 21))
                    labels.append(lbl)
                case 3:
                    var checkBtn1 = createButton(CGRect(x: x1, y: y1+44, width: 22, height: 22))
                    checkBtn1.tag = i
                    checkBtns.append(checkBtn1)
                    var lbl = createLabel(CGRect(x: x1+25, y: y1+44, width: 105, height: 21))
                    labels.append(lbl)
                case 4:
                    var checkBtn2 = createButton(CGRect(x: x2, y: y1+44, width: 22, height: 22))
                    checkBtn2.tag = i
                    checkBtns.append(checkBtn2)
                    var lbl = createLabel(CGRect(x: x2+25, y: y1+44,width: 105, height: 21))
                    labels.append(lbl)
                case 5:
                    var checkBtn3 = createButton(CGRect(x: x3, y: y1+88, width: 22, height: 22))
                    checkBtn3.tag = i
                    checkBtns.append(checkBtn3)
                    var lbl = createLabel(CGRect(x: x3+25, y: y1+88, width: 105, height: 21))
                    labels.append(lbl)
                case 6:
                    var checkBtn1 = createButton(CGRect(x: x1, y: y1+88, width: 22, height: 22))
                    checkBtn1.tag = i
                    checkBtns.append(checkBtn1)
                    var lbl = createLabel(CGRect(x: x1+25, y: y1+88, width: 105, height: 21))
                    labels.append(lbl)
                case 7:
                    var checkBtn2 = createButton(CGRect(x: x2, y: y1+88, width: 22, height: 22))
                    checkBtn2.tag = i
                    checkBtns.append(checkBtn2)
                    var lbl = createLabel(CGRect(x: x2+25, y: y1+88, width: 105, height: 21))
                    labels.append(lbl)
                default:
                    var checkBtn2 = createButton(CGRect(x: x2, y: y1+88, width: 22, height: 22))
                    checkBtn2.tag = i
                    checkBtns.append(checkBtn2)
                    var lbl = createLabel(CGRect(x: x2+25, y: y1+122, width: 105, height: 21))
                    labels.append(lbl)
                    
                }
//                println(checkBtns.count)
            }
            //将btn添加进cell
            for btn in checkBtns {
                cellChao.contentView.addSubview(btn)
            }
            //将lbl赋值
            for lbl in labels {
                for i in 1..<finalData.count{
                    lbl.text = finalData[i].approvePerson
                }
            }
            //将lbl添加进cell
            for lbl in labels {
                cellChao.contentView.addSubview(lbl)
            }
            var cellHeight = CGFloat(hasChaoSR/2)*44
            return cellHeight
            
        }
        return 44
    }
    
    //创建label
    func createLabel(frame:CGRect)->UILabel {
        var lbl = UILabel(frame: frame)
//        lbl.textColor = UIColor.blackColor()
//        lbl.backgroundColor = UIColor.blueColor()
        return lbl
    }
    //创建button
    func createButton(frame:CGRect)->UIButton{
        
        var checkBtn =  UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        checkBtn = UIButton(frame: frame)
        checkBtn.setBackgroundImage(UIImage(named: "check_off"), forState: nil)
        checkBtn.userInteractionEnabled = true
        checkBtn.addTarget(self, action: "checkCliced:", forControlEvents: UIControlEvents.TouchUpInside)
        return checkBtn
    }
    var isCheck1 = 0
    func checkCliced(check:UIButton){
      
        if isCheck1 == 0 {
            var checkImage = UIImage(named: "check_on")
            check.setBackgroundImage(checkImage, forState: nil)
            isCheck1 = 1
            check.tag = 111
        }else if isCheck1 == 1 {
            var checkImage = UIImage(named: "check_off")
            check.setBackgroundImage(checkImage, forState: nil)
            isCheck1 = 0
            check.tag = 110
        }
          println("tag:\(check.tag)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    
}
