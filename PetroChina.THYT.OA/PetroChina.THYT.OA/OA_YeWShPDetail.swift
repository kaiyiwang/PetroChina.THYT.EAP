//
//  OA_YeWShPDetail.swift
//  PetroChina.THYT.OA
//
//  Created by Mensp on 14/10/27.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_YeWShPDetail: UITableViewController,UITextViewDelegate,NSXMLParserDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    @IBOutlet weak var myPickView: UIPickerView!
    @IBOutlet weak var yijianTextView: UITextView! //意见输入框
    @IBOutlet weak var senderNameLbl: UILabel! //显示待办提交人
    @IBOutlet weak var stepNowLbl: UILabel! //显示当前环节
    @IBOutlet weak var liuZhuanHuanJie: UITextField! //显示用户选择的流转环节
    
    @IBOutlet weak var wenJianBTLbl: UITextView!//显示文件标题
    
    @IBOutlet weak var jiaDanBHLbl: UILabel!//显示假单编号
    
    @IBOutlet weak var shenQingShJLbl: UILabel!//显示申请时间
    
    @IBOutlet weak var qingJiaShYLbl: UILabel! //显示请假事由
    
    @IBOutlet weak var beginTime: UILabel! //显示开始时间
    
    @IBOutlet weak var endTime: UILabel!//显示结束时间
    
    @IBOutlet weak var xiaoJiaTime: UILabel!//显示销假时间
    @IBOutlet weak var submitBit: UIButton!
    @IBOutlet weak var ChaKan: UIButton!
    var parserXml:NSXMLParser! //处理返回的提交信息
    

    var wenJianBiaoTi:NSString! //显示文件标题

    var workflowIdgg:NSString = "" //工作流ID（待办中的docid）
    var senderName:NSString = "" //待办提交人

    var myRefresh = UIRefreshControl() //刷新控件
    
    var parserDataBase:GetDetailData_Base! //存储当前环节基本信息
    var parserDataActionList:Array<GetDetailData_ActionList> = [] //存储的流转环节
    var selectPickerNumber:NSInteger = 0 //记录用户的流程选择
    var huiFaData:NSMutableString = "" //记录返回的字符，判断是否提交成功
    
    var parserDataFieldInfoList:Array<GetDetailData_FieldInfoList> = [] //存储的页面信息
    var fujianDatas:Array<FuJian> = [] //存储附件数据
    var currentFuJian:FuJian!
    var yiJianDict:Dictionary<String,String> = [:] //存储意见型数据
    @IBOutlet weak var fujianTVCell: UITableViewCell!
     var hasZhengWen:Bool = false //有没有正文数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置按钮的边框
        submitBit.layer.borderWidth = 1.0
        submitBit.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        
        ChaKan.layer.borderWidth = 1.0
        ChaKan.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        
        println("QingXiaoJia：workflowId:\(workflowIdgg) senderName:\(senderName)")
        //移除空得单元格
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        //刷新实现
        myRefresh.attributedTitle = NSAttributedString(string: "正在刷新")
        myRefresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = myRefresh
        //设置意见输入框的颜色
        yijianTextView.layer.borderColor = UIColor.grayColor().CGColor
        yijianTextView.layer.borderWidth = 1
        liuZhuanHuanJie.font = UIFont.systemFontOfSize(12)
        //获取数据
//        DaiBanDetailFirst_Global.appendString("\(workflowIdgg.intValue)")
//        DaiBanDetailFirst_Global.appendString(DaiBanDetailSecond_Global)
//        DaiBanDetailFirst_Global.appendString(YouXiang_Global)
//        DaiBanDetailFirst_Global.appendString(DaiBanDetailThird_Global)
//         println(DaiBanDetailFirst_Global)
//        //        var bb = ReturnHttpConnection()
//        //        bb.connectionData(UrlString_Global, soapStr: DaiBanDetailFirst_Global)
//        var detailDataObj = DetailDataOfDaiBan()
//        detailDataObj.connectToUrl(UrlString_Global, soapStr: DaiBanDetailFirst_Global)
        
        var sendData:NSString = DaiBanDetailFirst_Global + "\(workflowIdgg.intValue)" + DaiBanDetailSecond_Global + YouXiang_Global + DaiBanDetailThird_Global
        var detailDataObj = DetailDataOfDaiBan()
        detailDataObj.connectToUrl(UrlString_Global, soapStr: sendData)

        //
        parserDataBase = detailDataObj.parserDataBase
        parserDataActionList = detailDataObj.parserDataActionList
        parserDataFieldInfoList = detailDataObj.parserDataFieldInfoList
      
        showDataIn()
        NSLog("============================OA_YeWShPDetail附件个数\(fujianDatas.count)")
        NSLog("----------------------------意见：\(yiJianDict.count)")
        hasZhengWen = hasZhengWenData()
        if fujianDatas.count > 0 {
            print("add")
            addTextViewToCell()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    //判断有没有正文
    func hasZhengWenData() -> Bool{
        if fujianDatas.count == 0 {
            return false
        }else {
            var zhengWenTitle:NSString = fujianDatas[0].name.substringToIndex(fujianDatas[0].name.length - 4)
            return zhengWenTitle.isEqualToString(wenJianBiaoTi as String)
        }
    }

    //界面显示
    func showDataIn(){
        
        stepNowLbl.text = parserDataBase.stepname as String
        senderNameLbl.text = senderName as String
        liuZhuanHuanJie.text = parserDataActionList[myPickView.selectedRowInComponent(0)].actionName as String
        for obj in parserDataFieldInfoList {
            if obj.name.isEqualToString("假单编号"){
                jiaDanBHLbl.text = obj.value as String

            }else if obj.name.isEqualToString("申请时间"){
                
                shenQingShJLbl.text = returnDetailTimerNum(obj.value) as String
            }else if obj.name.isEqualToString("标题"){
                wenJianBTLbl.text = obj.value as String
                wenJianBiaoTi = obj.value as String
            }else if obj.name.isEqualToString("请假事由") {
                qingJiaShYLbl.text = obj.value as String 
            }else if obj.name.isEqualToString("开始时间") {
                beginTime.text = returnDetailTimerNum(obj.value) as String
            }else if obj.name.isEqualToString("返回时间") {
                endTime.text = returnDetailTimerNum(obj.value) as String
            }else if obj.name.isEqualToString("销假时间") {
                xiaoJiaTime.text = returnDetailTimerNum(obj.value) as String
            }
            if obj.type.isEqualToString("附件型") {
                //存储附件数据
                currentFuJian = FuJian()
                fujianDatas.append(currentFuJian)
                currentFuJian.name = obj.name
                currentFuJian.value = obj.value
            }
            if obj.type.isEqualToString("意见型") && obj.readonly.isEqualToString("false"){
                yiJianDict["name"] = obj.name as String
                yiJianDict["field"] = obj.field as String
                yiJianDict["readonly"] = obj.readonly as String
                yiJianDict["flag"] = obj.flag as String
                yiJianDict["type"] = obj.type as String
            }


//            if obj.type.isEqualToString("意见型") {
//                niBanYiJianLbl.text = obj.name
//            }
        }
        if wenJianBiaoTi == nil{
            wenJianBTLbl.text = "无"
        } else {
            wenJianBTLbl.text = wenJianBiaoTi as String
        }
    }
    //返回大厅按钮触发事件
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    @IBAction func submitClicked(sender: AnyObject) {
        //提交点击后，发送submit流程。
        var sendData:NSString = ""
        if yiJianDict.count == 0 {
            if parserDataActionList[selectPickerNumber].actor == "" {
                println("-------------------in1 ")
                sendData = ActionMail_Global + YouXiang_Global + ActionId_Global + "\(parserDataActionList[selectPickerNumber].actionId)" + ActionName_Global + "\(parserDataActionList[selectPickerNumber].actionName)" + ActionWorkId_Global + "\(parserDataBase.workflowid)" + ActionFlowId_Global + "\(parserDataBase.flowid)" + ActionFlowName_Global + "\(parserDataBase.flowname)" + ActionTacheId_Global + "\(parserDataBase.stepid)" + ActionTacheName_Global + "\(parserDataBase.stepname)" + ActionNextDocCateIdNoActor_Global + "\(parserDataBase.doccategory)" + ActionDocbt + "\(parserDataBase.bt)" + ActionCmdAction + "submit" + ActionFinal_Global + ActionLast_Global
            }else {
                println("-----------------in2")
                sendData = ActionMail_Global + YouXiang_Global + ActionId_Global + "\(parserDataActionList[selectPickerNumber].actionId)" + ActionName_Global + "\(parserDataActionList[selectPickerNumber].actionName)" + ActionWorkId_Global + "\(parserDataBase.workflowid)" + ActionFlowId_Global + "\(parserDataBase.flowid)" + ActionFlowName_Global + "\(parserDataBase.flowname)" + ActionTacheId_Global + "\(parserDataBase.stepid)" + ActionTacheName_Global + "\(parserDataBase.stepname)" + ActionNextActorIdYes_Global + "\(parserDataActionList[selectPickerNumber].actor)" + ActionNextDocCateIdHasActor + "\(parserDataBase.doccategory)" + ActionDocbt + "\(parserDataBase.bt)" + ActionCmdAction + "submit" + ActionFinal_Global + ActionLast_Global
            }
            
        }else {
            
            NSLog("进入进入进入进入进入进入进入进入进入进入进入进入进入进入意见意见意见")
            var name:String = yiJianDict["name"]!
            var field:String = yiJianDict["field"]!
            var readonly:String = yiJianDict["readonly"]!
            var flag:String = yiJianDict["flag"]!
            var type:String = yiJianDict["type"]!
            
//            var yijian:String = "\(yijianTextView.text)$*$\(getUserInfo().groupName)$*$\(getUserInfo().userName)$*$\(getCurrentTime()[0])$*$\(getCurrentTime()[1])"
            var yijian:String = yijianTextView.text + "$*$" + "\(getUserInfo().groupName)" + "$*$" + "\(getUserInfo().userName)" + "$*$" + "\(getCurrentTime()[0])" + "$*$" + "\(getCurrentTime()[1])"
            var list1 = "<list><!--Optional:--><name>" + "\(name)" + "</name><!--Optional:--><value>" + yijian + "</value><!--Optional:--><field>" + "\(field)" + "</field><readonly>"
            var list2 = "\(readonly)" + "</readonly><flag>" + "\(flag)" + "</flag><!--Optional:--><type>" + "\(type)" + "</type></list>"
            var list = list1 + list2
            if parserDataActionList[selectPickerNumber].actor == "" {
                println("-------------------in1 ")
                sendData = ActionMail_Global + YouXiang_Global + ActionId_Global + "\(parserDataActionList[selectPickerNumber].actionId)" + ActionName_Global + "\(parserDataActionList[selectPickerNumber].actionName)" + ActionWorkId_Global + "\(parserDataBase.workflowid)" + ActionFlowId_Global + "\(parserDataBase.flowid)" + ActionFlowName_Global + "\(parserDataBase.flowname)" + ActionTacheId_Global + "\(parserDataBase.stepid)" + ActionTacheName_Global + "\(parserDataBase.stepname)" + ActionNextDocCateIdNoActor_Global + "\(parserDataBase.doccategory)" + ActionDocbt + "\(parserDataBase.bt)" + ActionCmdAction + "submit" + ActionFinal_Global + "\(list)" + ActionLast_Global
            }else {
                println("-----------------in2")
                sendData = ActionMail_Global + YouXiang_Global + ActionId_Global + "\(parserDataActionList[selectPickerNumber].actionId)" + ActionName_Global + "\(parserDataActionList[selectPickerNumber].actionName)" + ActionWorkId_Global + "\(parserDataBase.workflowid)" + ActionFlowId_Global + "\(parserDataBase.flowid)" + ActionFlowName_Global + "\(parserDataBase.flowname)" + ActionTacheId_Global + "\(parserDataBase.stepid)" + ActionTacheName_Global + "\(parserDataBase.stepname)" + ActionNextActorIdYes_Global + "\(parserDataActionList[selectPickerNumber].actor)" + ActionNextDocCateIdHasActor + "\(parserDataBase.doccategory)" + ActionDocbt + "\(parserDataBase.bt)" + ActionCmdAction + "submit" + ActionFinal_Global + "\(list)" + ActionLast_Global
            }
            
        }
        var sendDoAction = ReturnHttpConnection()
        NSLog("------------------sendData:\(sendData)")
        var dataLast = sendDoAction.connectionData(UrlString_Global, soapStr: sendData)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
        NSLog("返回信息==================================\(str)")
        parserXml = NSXMLParser(data: dataLast)
        parserXml.delegate = self
        parserXml.shouldProcessNamespaces = true
        parserXml.shouldReportNamespacePrefixes = true
        parserXml.shouldResolveExternalEntities = true
        parserXml.parse()
        
        var alert = UIAlertView()
        alert.tag = 1001
        if huiFaData == "" {
            alert = UIAlertView(title: "温馨提示", message: "提交成功", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }else {
            alert = UIAlertView(title: "温馨提示", message: "提交失败", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }
        

//        //提交点击后，发送submit流程。
//        var sendData:NSString = ""
//        if parserDataActionList[selectPickerNumber].actor == "" {
//            println("-------------------in1 ")
//            sendData = ActionMail_Global + YouXiang_Global + ActionId_Global + "\(parserDataActionList[selectPickerNumber].actionId)" + ActionName_Global + "\(parserDataActionList[selectPickerNumber].actionName)" + ActionWorkId_Global + "\(parserDataBase.workflowid)" + ActionFlowId_Global + "\(parserDataBase.flowid)" + ActionFlowName_Global + "\(parserDataBase.flowname)" + ActionTacheId_Global + "\(parserDataBase.stepid)" + ActionTacheName_Global + "\(parserDataBase.stepname)" + ActionNextDocCateIdNoActor_Global + "\(parserDataBase.doccategory)" + ActionDocbt + "\(parserDataBase.bt)" + ActionCmdAction + "submit" + ActionFinal_Global
//        }else {
//            println("-----------------in2")
//            sendData = ActionMail_Global + YouXiang_Global + ActionId_Global + "\(parserDataActionList[selectPickerNumber].actionId)" + ActionName_Global + "\(parserDataActionList[selectPickerNumber].actionName)" + ActionWorkId_Global + "\(parserDataBase.workflowid)" + ActionFlowId_Global + "\(parserDataBase.flowid)" + ActionFlowName_Global + "\(parserDataBase.flowname)" + ActionTacheId_Global + "\(parserDataBase.stepid)" + ActionTacheName_Global + "\(parserDataBase.stepname)" + ActionNextActorIdYes_Global + "\(parserDataActionList[selectPickerNumber].actor)" + ActionNextDocCateIdHasActor + "\(parserDataBase.doccategory)" + ActionDocbt + "\(parserDataBase.bt)" + ActionCmdAction + "submit" + ActionFinal_Global
//        }
//        var sendDoAction = ReturnHttpConnection()
//        var dataLast = sendDoAction.connectionData(UrlString_Global, soapStr: sendData)
//        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//        NSLog("\(str)==================================")
//        parserXml = NSXMLParser(data: dataLast)
//        parserXml.delegate = self
//        parserXml.shouldProcessNamespaces = true
//        parserXml.shouldReportNamespacePrefixes = true
//        parserXml.shouldResolveExternalEntities = true
//        parserXml.parse()
//        if huiFaData == "" {
//            var alert = UIAlertView(title: "温馨提示", message: "提交成功", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//        }else {
//            var alert = UIAlertView(title: "温馨提示", message: "提交失败", delegate: self, cancelButtonTitle: "确定")
//            alert.show()
//        }
//
    }
    
    func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        if alertView.tag == 1001 && buttonIndex == 0 {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        huiFaData.appendString(string!)
    }
    //刷新触发的事件
    func reload(){
        
        println("reload WenGQF")
      
        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //pickerview
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return parserDataActionList.count
    }
    //    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    //        return parserDataActionList[row].actionName
    //    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        println("selected\(row)")
         selectPickerNumber = row //记录用户的流程选择
        liuZhuanHuanJie.text = parserDataActionList[row].actionName as String
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var myView = UILabel(frame: CGRectMake(0, 0, 100, 30))
        myView.textAlignment = NSTextAlignment.Center
        myView.text = parserDataActionList[row].actionName as String
        myView.font = UIFont.systemFontOfSize(12)
        myView.backgroundColor = UIColor.clearColor()
        return myView
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80
    }
    @IBAction func downLoadData(sender: AnyObject) {
        //下载正文按钮点击后，获取正文信息，查看正文
        var sendData = MainTextFirst_Global + "\(workflowIdgg.intValue)" + MainTextSecond_Global
        var obj = ZhengWenData()
        obj.connectToUrl(UrlString_Global, soapStr: sendData,wenjianType:"")
        if obj.dataLenth == 0 {
            var alert = UIAlertView(title: "温馨提示", message: "没有正文数据", delegate: self, cancelButtonTitle: "确定")
            alert.show()
        }else {
            //显示正文数据
            var dest = self.storyboard?.instantiateViewControllerWithIdentifier("ZhW") as! webviewViewController
            dest.WDType = ""
            self.navigationController?.pushViewController(dest, animated: true)
            
        }

        
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 8 {
            if fujianDatas.count == 1 || fujianDatas.count == 0 {
                return  44
            }else {
                if hasZhengWen {
                    return CGFloat(fujianDatas.count-1) * 44 + 10
                }else {
                    return CGFloat(fujianDatas.count) * 44 + 10
                }
                
            }
        }
        return 44
    }
    //创建textview
    func createTextView(frame:CGRect) -> UITextView {
        var fjTV = UITextView(frame: frame)
        fjTV.userInteractionEnabled = true
        return fjTV
    }
    
    var fjTVs = [UITextView]()
    //连续创建
    func createMoreTV() {
        var count = 0
        if hasZhengWen {
            count = 1
        }else {
            count = 0
        }
        
        for i in count..<fujianDatas.count {
            var tv:UITextView!
            if count == 0 {
                tv = createTextView(CGRect(x: 105, y: 4+44*i, width: 210, height: 50))
            }else {
                tv = createTextView(CGRect(x: 105, y: 4+44*(i-1), width: 210, height: 50))
            }
            tv.tag = i
            
            var string:NSString =  "\(fujianDatas[i].name)"
            var attributedString = NSMutableAttributedString(string: string as String)
            attributedString.addAttribute(NSLinkAttributeName, value: "username://\(fujianDatas[i].name)", range: string.rangeOfString("\(fujianDatas[i].name)"))
            var linkAttributes:NSMutableDictionary = NSMutableDictionary()
            linkAttributes.setObject(UIColor.blackColor(), forKey: NSForegroundColorAttributeName)
            linkAttributes.setObject(UIColor.greenColor(), forKey: NSUnderlineColorAttributeName)
            linkAttributes.setObject("NSUnderlineStyle.StyleSingle", forKey: NSUnderlineStyleAttributeName)
            tv.linkTextAttributes = linkAttributes as [NSObject: AnyObject]
            tv.attributedText = attributedString
            tv.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            tv.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin
            tv.autoresizingMask = UIViewAutoresizing.FlexibleWidth
            tv.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
            
            tv.editable = false
            tv.delegate = self
            fjTVs.append(tv)
        }
    }
    //添加textview控件
    func addTextViewToCell() {
        createMoreTV()
        for obj in fjTVs {
            print("fjtvs \(obj.text)")
            fujianTVCell.contentView.addSubview(obj)
        }
    }
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        //        NSLog("shouldInteractWithURL")
        
        NSLog("\(textView.tag)") //tag就是第几个
        //跳转到webview上面
        var sendData = AttachFirst_Global + "\(fujianDatas[textView.tag].value)" + AttachSecond_Global
        var obj = ZhengWenData()
        obj.connectToUrl(UrlString_Global, soapStr: sendData,wenjianType:fujianDatas[textView.tag].name)
        //显示正文数据
        var dest = self.storyboard?.instantiateViewControllerWithIdentifier("ZhW") as! webviewViewController
        dest.WDType = fujianDatas[textView.tag].name
        self.navigationController?.pushViewController(dest, animated: true)
        return true
    }


}
