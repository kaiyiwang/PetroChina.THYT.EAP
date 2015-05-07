//
//  OA_FaWZhSh.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_FaWZhSh: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var myRefresh = UIRefreshControl() //刷新控件
    @IBOutlet weak var EJDanWeiLingDao: UIButton! // 二级单位领导按钮
    @IBOutlet weak var JiGuanChuShi: UIButton!//机关单位按钮
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var KuangQuShiYeBu: UIButton!//矿区事业部按钮
    @IBOutlet weak var btnView: UIView!
    //先获取到数据，判断数据是属于哪个下面，定义三个存储信息的数组，分别存储二级单位,
    //点击哪个，显示哪个数据就可以了
    //将界面显示的东西，专门存储在showData数组中
//    let ErJiDanWeiFaWen_Global:NSString = "二级单位发文"
//    let JiGuanChuShiFW_Global:NSString = "机关处室发文"
//    let ShiYeBuFW_Global:NSString = "事业部发文"
    var finalDataOfShiYeBuFW:Array<DaiBanData> = [] //存储发文信息 事业部发文
    var finalDataOfJiGuanChuShiFW:Array<DaiBanData> = [] //存储发文信息 机关处室发文
    var finalDataOfErJiDanWeiFaWen:Array<DaiBanData> = [] //存储发文信息 二级单位发文
    var finalDataOfDaiBan:Array<DaiBanData> = [] //存储代办信息
    var showData:Array<DaiBanData> = [] //界面显示的信息
    
    //菊花
    var myview:JvHua!
//    var countOfFaWen = 0
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
//    var dataArrLeft = ["关于印发《中国石油天然气股份有限公司吐哈油田分公司基建工程管理办法》等两项制度的通知","关于印发《中国石油天然气股份有限公司吐哈油田分公司基建工程管理办法》等两项制度的通知","关于印发《中国石油天然气股份有限公司吐哈油田分公司基建工程管理办法》等两项制度的通知","关于印发《中国石油天然气股份有限公司吐哈油田分公司基建工程管理办法》等两项制度的通知","关于印发《中国石油天然气股份有限公司吐哈油田分公司基建工程管理办法》等两项制度的通知","关于印发《中国石油天然气股份有限公司吐哈油田分公司基建工程管理办法》等两项制度的通知","会签","审核","核稿","拟稿人","成文日期"]
//    var dataArrRight = ["2014-20-10","2014-20-10","2014-20-10","2014-20-10","2014-20-10","核稿","拟稿人","成文日期","拟稿单位","拟稿人","成文日期"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.frame = CGRectMake(0, 50, self.view.bounds.width, self.view.bounds.height - 50)
        EJDanWeiLingDao.bounds = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width/3, 35)
        JiGuanChuShi.bounds = CGRectMake(EJDanWeiLingDao.bounds.width, 0, UIScreen.mainScreen().bounds.width/3, 35)
        KuangQuShiYeBu.bounds = CGRectMake(JiGuanChuShi.bounds.width, 0, UIScreen.mainScreen().bounds.width/3, 35)
        
        //菊花显示
        
//        UITextView
        myview = JvHua(frame: CGRect(x: self.view.center.x-50, y: self.view.center.y-90, width: 100, height: 100))
        self.view.addSubview(myview)
//        myview.hidden = true
//
//        var panGes = UIPanGestureRecognizer(target: self, action: "handleSwipe:")
//        self.view.addGestureRecognizer(panGes)
        //移除空得单元格
//        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        //刷新实现
        myRefresh.attributedTitle = NSAttributedString(string: "正在刷新")
        myRefresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(myRefresh)
        //获取数据
        finalDataOfDaiBan = getParserData_DaiBan()
        //存储各个数组的信息
        storageArray(finalDataOfDaiBan)
        //默认是显示二级单位发文信息
        //        countOfFaWen = finalDataOfErJiDanWeiFaWen.count
        showData = finalDataOfErJiDanWeiFaWen
        
        if showData.count == 0 {
            var timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: false)
        }else{
            myview.hidden = true
		}
      
        //        //设置图标显示的数字 （必须要在读取到数据之后）
        //        UIApplication.sharedApplication().applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + finalDatas.count
        
    }
	func stop(){
		myview.activityIndicatorView.stopAnimating()
	}

    var count = 0
//    //手势处理
//    func handleSwipe(gesture:UIPanGestureRecognizer){
//        
//        var pan = gesture as UIPanGestureRecognizer
//        var point = pan.translationInView(self.view)
//        if point.x > 0 {
//            println("right")
//            --count
//            switch count%3 {
//            case 0:
//                EJDanWeiLingDaoClicked(self)
//            case -2:
//                JiGuanChuShiClicked(self)
//            case -1:
//                KuangQuShiYeBuClicked(self)
//            case 1:
//                JiGuanChuShiClicked(self)
//            default:
//                EJDanWeiLingDaoClicked(self)
//            
//            }
//        }else {
//            ++count
//            println("left")
//            switch count%3 {
//            case 0:
//                EJDanWeiLingDaoClicked(self)
//            case 1:
//                JiGuanChuShiClicked(self)
//            case 2:
//                KuangQuShiYeBuClicked(self)
//            default:
//                EJDanWeiLingDaoClicked(self)
//            }
//           
//        }
//    }

    //存储各个数组的信息
    func storageArray(strArray:Array<DaiBanData>){
        finalDataOfErJiDanWeiFaWen = []
        finalDataOfJiGuanChuShiFW = []
        finalDataOfShiYeBuFW = []
        for obj in strArray {
            if obj.dbsyhead.isEqualToString(ErJiDanWeiShW_Global){
                finalDataOfErJiDanWeiFaWen.append(obj)
            }else if obj.dbsyhead.isEqualToString(ChuShiShW_Global) {
                finalDataOfJiGuanChuShiFW.append(obj)
            }else if obj.dbsyhead.isEqualToString(ShiYeBuShW_Global) {
                finalDataOfShiYeBuFW.append(obj)
            }
        }
    }
    //返回大厅按钮触发事件
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }

    //刷新触发的事件
    func reload(){
        
        println("reload FaWZhShW")
        //获取所有代办信息
        getDaiBanData()
        //获取数据
        finalDataOfDaiBan = getParserData_DaiBan()
        //存储各个数组的信息
        storageArray(finalDataOfDaiBan)
        //显示信息,判断button哪个被点击就显示哪个数据(通过背景颜色判断)
//        println(EJDanWeiLingDao.backgroundColor == UIColor.whiteColor())
        if EJDanWeiLingDao.backgroundColor == UIColor.whiteColor() {
          
            showData = finalDataOfErJiDanWeiFaWen
           
        }else if JiGuanChuShi.backgroundColor == UIColor.whiteColor() {
            
            showData = finalDataOfJiGuanChuShiFW
            
        }else if KuangQuShiYeBu.backgroundColor == UIColor.whiteColor() {
            
            showData = finalDataOfShiYeBuFW
          
        }
        if showData.count == 0 {
            myview.hidden = false
        }else{
            myview.hidden = true
        }
      
        self.tableView.reloadData()
        sleep(1)
        myRefresh.endRefreshing()
    }
    // 二级单位领导按钮点击
    @IBAction func EJDanWeiLingDaoClicked(sender: AnyObject) {
        EJDanWeiLingDao.backgroundColor = UIColor.whiteColor()
        JiGuanChuShi.backgroundColor = UIColor.lightGrayColor()
        KuangQuShiYeBu.backgroundColor = UIColor.lightGrayColor()
//        countOfFaWen = finalDataOfErJiDanWeiFaWen.count
        showData = finalDataOfErJiDanWeiFaWen
        if showData.count == 0 {
            myview.hidden = false
        }else{
            myview.hidden = true
        }
        if showData.count == 0 {
            var timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: false)
        }else{
            myview.hidden = true
        }
        NSLog("------------------showdata:\(showData.count)")
        tableView.reloadData()
    }
    
    //机关单位按钮点击
    @IBAction func JiGuanChuShiClicked(sender: AnyObject) {
        JiGuanChuShi.backgroundColor = UIColor.whiteColor()
        EJDanWeiLingDao.backgroundColor = UIColor.lightGrayColor()
        KuangQuShiYeBu.backgroundColor = UIColor.lightGrayColor()
//        countOfFaWen = finalDataOfJiGuanChuShiFW.count
        showData = finalDataOfJiGuanChuShiFW
        if showData.count == 0 {
            myview.hidden = false
        }else{
            myview.hidden = true
        }
        if showData.count == 0 {
            var timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: false)
        }else{
            myview.hidden = true
        }
        self.tableView.reloadData()
    }
    //矿区事业部按钮点击
    @IBAction func KuangQuShiYeBuClicked(sender: AnyObject) {
        KuangQuShiYeBu.backgroundColor = UIColor.whiteColor()
        EJDanWeiLingDao.backgroundColor = UIColor.lightGrayColor()
        JiGuanChuShi.backgroundColor = UIColor.lightGrayColor()
//        countOfFaWen = finalDataOfShiYeBuFW.count
        showData = finalDataOfShiYeBuFW
        if showData.count == 0 {
            myview.hidden = false
        }else{
            myview.hidden = true
        }
        if showData.count == 0 {
            var timer=NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "stop", userInfo: nil, repeats: false)
        }else{
            myview.hidden = true
        }
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return showData.count
    }

    var recognizer = UISwipeGestureRecognizer()
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        cell.userInteractionEnabled = true
        //建立滑动手势
        
        //设置滑动方向，下面以此类推
                recognizer.direction = UISwipeGestureRecognizerDirection.Left
        recognizer = UISwipeGestureRecognizer(target: self, action:"handleSwipe:")
//        recognizer.cancelsTouchesInView = false
        cell.addGestureRecognizer(recognizer)
        // Configure the cell...
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
//                textview.editable = true
//        textview.selectable = false
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
      
        var obj = showData
        
        //表示已查看
        if obj[indexPath.row].state.isEqualToString("01"){
                        println("已查看:\(indexPath.row)")
            textview.textColor = UIColor.grayColor()
            label2.textColor = UIColor.grayColor()
            
        }else {
            textview.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
            
        }

        
        textview.text = obj[indexPath.row].title as String
        label2.text = returnTimerNum(obj[indexPath.row].gtime) as String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //点击cell，表示已查看，然后将文字显示灰色
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        var textview = cell.viewWithTag(TAG_CELL_LABELLeft)as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        textview.textColor = UIColor.grayColor()
        label2.textColor = UIColor.grayColor()
        //将看过的状态发送给后台,将后台状态改变
        var sendHouTai:NSString = changeDbsyStateFirst_Global + "\(showData[indexPath.row].id)" + changeDbsyStateSecond_Global
        var sendStateDbsy = ReturnHttpConnection()
        var dataLast = sendStateDbsy.connectionData(UrlString_Global, soapStr: sendHouTai)
        var str = NSString(data: dataLast, encoding: NSUTF8StringEncoding)
//                                println("receiveStateinOAFWZSW:\(str)")
        
        //界面跳转
        var dest = self.storyboard?.instantiateViewControllerWithIdentifier("FaWZhShDetail") as! OA_FaWZhShDetail
        let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
        dest.workflowId = showData[index].docid
        dest.senderName = showData[index].sendername
        self.navigationController?.pushViewController(dest, animated: true)
    }

    
    //格式化ListView隔行现实效果。
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
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
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "FaWenZhShW" {
//            let index:NSInteger = self.tableView.indexPathForSelectedRow()!.row
//            let myVC = segue.destinationViewController as OA_FaWZhShDetail
//            myVC.workflowId = showData[index].docid
//            myVC.senderName = showData[index].sendername
//        }
//
//        FaWZhShDetail
//    }


}
