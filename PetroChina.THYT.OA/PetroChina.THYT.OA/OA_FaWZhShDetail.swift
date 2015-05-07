//
//  OA_FaWZhShDetail.swift
//  PetroChina.THYT.OA
//
//  Created by Mensp on 14/10/27.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_FaWZhShDetail: UITableViewController,UITextViewDelegate,NSXMLParserDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UIAlertViewDelegate {

    
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    
    var workflowId:NSString = "" //工作流ID（待办中的docid）
    var senderName:NSString = "" //待办提交人
    
    @IBOutlet weak var myPickView: UIPickerView!
    @IBOutlet weak var yijianTextView: UITextField! //意见输入框
    @IBOutlet weak var senderNameLbl: UILabel! //显示待办提交人
    @IBOutlet weak var stepNowLbl: UILabel! //显示当前环节
    @IBOutlet weak var liuZhuanHuanJie: UITextField! //显示用户选择的流转环节
    
    @IBOutlet weak var wenJianBTLbl: UILabel!//显示文件标题
    
    @IBOutlet weak var laiWenBHLbl: UILabel!//显示来文编号
    
    @IBOutlet weak var laiWenDWLbl: UILabel!//显示来文单位
    
    @IBOutlet weak var shouWRQLbl: UILabel! //显示来文时间
    
    @IBOutlet weak var niBanYiJianLbl: UILabel! //拟办意见
    
    @IBOutlet weak var submitBit: UIButton!
    @IBOutlet weak var ChaKan: UIButton!
    var parserXml:NSXMLParser! //处理返回的提交信息
    
    var laiWenDanWei:NSString! //显示来文单位
    var laiWenBianHao:NSString! //显示来文编号
    var wenJianBiaoTi:NSString! //显示文件标题
    var shiJian:NSString! //显示时间
    var zhengWen:NSString! //显示正文
    var fuJian:Array<NSString> = [] //显示附件

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
        tableView.bounces = false
        yijianTextView.text = opinionArray[0]
        //设置按钮的边框
        submitBit.layer.borderWidth = 1.0
        submitBit.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        submitBit.layer.cornerRadius = 2.0
        submitBit.layer.masksToBounds = true
        
        ChaKan.layer.borderWidth = 1.0
        ChaKan.layer.borderColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1).CGColor
        
        //移除空得单元格
//        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        println("workflowId:\(workflowId) senderName:\(senderName)")
        //设置意见输入框的颜色
        yijianTextView.layer.borderColor = UIColor.grayColor().CGColor
        yijianTextView.layer.borderWidth = 1
        liuZhuanHuanJie.font = UIFont.systemFontOfSize(12)
        //获取数据
//        DaiBanDetailFirst_Global.appendString("\(workflowId.intValue)")
//        DaiBanDetailFirst_Global.appendString(DaiBanDetailSecond_Global)
//        DaiBanDetailFirst_Global.appendString(YouXiang_Global)
//        DaiBanDetailFirst_Global.appendString(DaiBanDetailThird_Global)
//    
////        var bb = ReturnHttpConnection()
////        bb.connectionData(UrlString_Global, soapStr: DaiBanDetailFirst_Global)
//        var detailDataObj = DetailDataOfDaiBan()
//        detailDataObj.connectToUrl(UrlString_Global, soapStr: DaiBanDetailFirst_Global)
//
        var sendData:NSString = DaiBanDetailFirst_Global+"\(workflowId.intValue)"+DaiBanDetailSecond_Global+YouXiang_Global + DaiBanDetailThird_Global
        println("详细呆板数据sendData:\(sendData)")
        var detailDataObj = DetailDataOfDaiBan()
        detailDataObj.connectToUrl(UrlString_Global, soapStr: sendData)
        

        parserDataBase = detailDataObj.parserDataBase
        parserDataActionList = detailDataObj.parserDataActionList
        parserDataFieldInfoList = detailDataObj.parserDataFieldInfoList
        
        showDataIn()
        NSLog("============================OA_FaWZhShDetail附件个数\(fujianDatas.count)")
         hasZhengWen = hasZhengWenData()
        var name = yiJianDict["name"]
         NSLog("----------------------------意见：\(yiJianDict.count) \(name)")
        
        if fujianDatas.count > 0 {
            print("add")
            addTextViewToCell()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
        yijianTextView.resignFirstResponder()
    }
    
    //判断有没有正文
    func hasZhengWenData() -> Bool{
        if fujianDatas.count == 0 {
            return false
        }else {
            var zhengWenTitle:NSString = fujianDatas[0].name.substringToIndex(fujianDatas[0].name.length - 4)
            return zhengWenTitle.isEqualToString(wenJianBTLbl.text!)
        }
        
    }
    

    //界面显示
    func showDataIn(){
        
        if parserDataBase != nil{
            stepNowLbl.text = parserDataBase.stepname as String
        } else {
            stepNowLbl.text = "无"
        }
        
        senderNameLbl.text = senderName as String
        liuZhuanHuanJie.text = parserDataActionList[myPickView.selectedRowInComponent(0)].actionName as String
        for obj in parserDataFieldInfoList {
            if obj.name.isEqualToString("发文单位") && !obj.value.isEmpty
            {
                laiWenDWLbl.text = obj.value
            }
            else if obj.name.isEqualToString("发文字号") && !obj.value.isEmpty
            {
                laiWenBHLbl.text = obj.value
            }
            else if obj.name.isEqualToString("标题") && !obj.value.isEmpty
            {
                wenJianBTLbl.text = obj.value as String
                wenJianBiaoTi = obj.value as String
            }
            if obj.type.isEqualToString("时间型") {
                shouWRQLbl.text = obj.name as String
            }
            if obj.type.isEqualToString("附件型") {
//                if obj.name.isEqualToString(wenJianBiaoTi+".doc") {
//                    zhengWen = obj.name
//                    print("zhengwen")
//                }else {
                    fuJian.append(obj.name)
//                }
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

        }
        
//        if wenJianBiaoTi != nil {
//            wenJianBTLbl.text = wenJianBiaoTi as String
//        } else {
//            wenJianBTLbl.text = "无"
//        }
//        if laiWenDanWei == nil {
//            laiWenDWLbl.text = "无"
//        } else {
//            laiWenDWLbl.text = laiWenDanWei as String
//        }
//        if laiWenBianHao == nil {
//            laiWenBHLbl.text = "无"
//        } else {
//            laiWenBHLbl.text = laiWenBianHao as String
//        }
//        if shiJian == nil {
//            shouWRQLbl.text = "无"
//        } else{
//            shouWRQLbl.text = shiJian as String
//        }

    }
    //提交按钮点击
    @IBAction func submit(sender: AnyObject) {
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

            println(yijian)
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

    }
    
    func alertView(alertView: UIAlertView, willDismissWithButtonIndex buttonIndex: Int) {
        if alertView.tag == 1001 && buttonIndex == 0 {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    func parser(parser: NSXMLParser, foundCharacters string: String?) {
        huiFaData.appendString(string!)
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
        //常用意见pickerView
        if pickerView.tag == 1001 {
            return opinionArray.count
        } else if pickerView.tag == 1002 {
            //流转pickerView
            return parserDataActionList.count
        }else{
            return 0
        }
    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        println("selected\(row)")
        
        if pickerView.tag == 1001 {
            yijianTextView.text = opinionArray[row] as String
        }else if pickerView.tag == 1002 {
            selectPickerNumber = row //记录用户的流程选择
            liuZhuanHuanJie.text = parserDataActionList[row].actionName as String
        } else {}
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var myView = UILabel(frame: CGRectMake(0, 0, 80, 30))
        myView.textAlignment = NSTextAlignment.Center
        myView.font = UIFont.systemFontOfSize(12)
        myView.backgroundColor = UIColor.clearColor()
        if pickerView.tag == 1001 {
            myView.text = opinionArray[row] as String
            return myView
        } else if pickerView.tag == 1002 {
            myView.text = parserDataActionList[row].actionName as String
            return myView
        }
        return myView
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80
    }

    
    
    @IBAction func downLoadData(sender: AnyObject) {
        //下载正文按钮点击后，获取正文信息，查看正文
                var sendData = MainTextFirst_Global + "\(workflowId.intValue)" + MainTextSecond_Global
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
        if indexPath.row == 5 {
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
//        NSLog("================in createMoreTv count:\(count)fujianDatas.count:\(fujianDatas.count)  ")
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
        NSLog("------------------fjTVs.count:\(fjTVs.count)")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
