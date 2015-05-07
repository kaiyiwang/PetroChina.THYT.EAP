//
//  ERP_GongYSGLTV.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-14.
//  Copyright (c) 2014年 tuha. All rights reserved.
//


import UIKit

class ERP_GongYSGLTV: UITableViewController ,UIScrollViewDelegate{
    
    //要发送给显示详细内容界面的ID
    var approId:NSString = ""
    var perTaskId:NSString = ""
    var providerDetailId:NSString = ""
    var admitId:NSString = ""
    var isHse:NSString = ""
    var statusType:NSString = ""
    var businessId:NSString = ""
    var appUserId:NSString = ""
    var finalDatas:Array<List_601> = [] //要显示的列表的数据
//    var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE601" //声明wsdl的url
//    //    var url:NSString = "http://10.218.8.213:8620/thwlpt/ws/MOVE601"
//    //要发送的soap的内容
//    var soapStr:NSMutableString = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:ResultAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;1000000036&lt;/userId&gt; &lt;unitId&gt;001001006&lt;/unitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:ResultAppListQuery></soapenv:Body></soapenv:Envelope>"
    
//    "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:sap=\"http://sap.move.com/\"><soapenv:Header/><soapenv:Body><sap:ResultAppListQuery><!--Optional:--><arg0>&lt;?xml version='1.0' encoding='utf-8'?&gt;&lt;xuanShang&gt;&lt;row&gt;&lt;userId&gt;1000000037&lt;/userId&gt; &lt;unitId&gt;001001006&lt;/unitId&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:ResultAppListQuery></soapenv:Body></soapenv:Envelope>"
    
    var b = ERP_GongYShGL_List_601() //获取RecData对象
    //
    @IBAction func unwindSegueToRedViewController(segue:UIStoryboardSegue){
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //数据
    let TAG_CELL_LABELLeft = 1
    let TAG_CELL_LABELRight = 2
    
    let dataArrLeft = ["单位名称：","是否中石油一级供应商：","供应商类型：","一级准入证编号：","准入类型：","申请业务类型","准入年份：","营业执照扫描件：","申请准入时间：","备注："]
    let dataArrRight = ["2014-06-05","2014-07-05","2014-08-05","2014-09-05","2014-05-05","2014-05-05","2014-05-05","2014-05-05","2014-05-05","2014-05-05"]
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    
    var refresh = UIRefreshControl()//刷新
    override func viewDidLoad() {
        super.viewDidLoad()
        //刷新
        refresh.attributedTitle = NSAttributedString(string: "正在刷新")
        refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refresh
        
        //test youxiang
        //        var dictUrlData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("urlString", ofType: "plist")!)!)//获取url
        //        var dictSoapData = NSDictionary(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("soapString", ofType: "plist")!)!)//获取soap
        //        var url:NSString = dictUrlData!["GongYShGL601"] as NSString
        //        var soapStr1:NSMutableString = dictSoapData!["GongYShGL601"] as NSMutableString
        //        var soapStr2 = soapStr1.stringByAppendingString("zhoujianjun@petrochina.com.cn")
        //        var soapStr = soapStr2.stringByAppendingString("&lt;/gfEmail&gt;&lt;/row&gt; &lt;/xuanShang&gt;</arg0></sap:ResultAppListQuery></soapenv:Body></soapenv:Envelope>")
        //test youxiang
        
        var sendData = (GongYingFirst_Global as String) + "\(getUserId_Global())" + (GongYingSecond_Global as String) + "\(getUnitId_Global())" + (GongYingThird_Global as String)
        
        println("供应商SendData:\(sendData)")
        b.connectToUrl(GongYingUrl_Global, soapStr: sendData) //连接url获取数据
        finalDatas = b.parserDatas //获取到数据
        //设置图标显示的数字 （必须要在读取到数据之后）
        if gongyingshangXianshi == 0 {
                    UIApplication.sharedApplication().applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + finalDatas.count
            gongyingshangXianshi = 1
        }


        //        println(finalDatas.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func reload(){
        
        println("reload")
        var b = ERP_GongYShGL_List_601() //获取RecData对象
        var sendData = (GongYingFirst_Global as String) + "\(getUserId_Global())" + (GongYingSecond_Global as String) + "\(getUnitId_Global())" + (GongYingThird_Global as String)
        b.connectToUrl(GongYingUrl_Global, soapStr: sendData) //连接url获取数据
        finalDatas = b.parserDatas //获取到数据
        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
        //                 refresh.attributedTitle = NSAttributedString(string: "结束刷新")
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
        var b  = finalDatas.count
        return b+1
        
    }
    
    // MARK: - UITableViewDelegate
    //格式化ListView隔行现实效果。
    override func tableView(
        tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
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
    //根据点击的cell Index将相应的信息保存在本地
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if indexPath.row == 0 {
           
        }
        if indexPath.row != 0 {
            
            var dataObj = finalDatas[indexPath.row-1]
            approId = dataObj.approveId
            perTaskId = dataObj.personTaskId
            providerDetailId = dataObj.providerDetailId
            admitId = dataObj.admitId
            isHse = dataObj.isHse
            statusType = dataObj.statusType
            businessId = dataObj.businessId
            appUserId = getUserId_Global()  ///////动态。。。。！！！！！！！！
            
            //                    println("selected->approveId:\(approId) personTaskId:\(perTaskId)")
            
            //访问沙盒
            var sp = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)//获取目录
            if sp.count > 0 {
                var url = NSURL(fileURLWithPath: "\(sp[0])/data601.txt")
                //                            println(url)
                var data = NSMutableString()
                data.appendString("\(approId),") //继续添加字符
                data.appendString("\(perTaskId),")
                data.appendString("\(providerDetailId),")
                data.appendString("\(admitId),")
                data.appendString("\(isHse),")
                data.appendString("\(statusType),")
                data.appendString("\(businessId),")
                data.appendString("\(appUserId)")
                //此处为测试邮箱，注意！！！！！！！！！！！！！！！！
                //test youxiang
                //                data.appendString("zhoujianjun@petrochina.com.cn")
                //test youxiang
                //                println("data:\(data)")
                if let b = url?.path {
                    data.writeToFile(b, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
                }
                
            }
            
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellw", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        var label1 = cell.viewWithTag(TAG_CELL_LABELLeft) as! UILabel
        var label2 = cell.viewWithTag(TAG_CELL_LABELRight) as! UILabel
        //        cell.selected = true
        if indexPath.row == 0{
            label1.text = "供应商名称"
            label2.text = "供应商序号"
        }else{
            var dataObj = finalDatas[indexPath.row-1]
            
            label1.text = dataObj.providerName
            
            label2.text = dataObj.tempProviderId
        }
        
        
        return cell
    }
    
    
    
    //使tableviewcell的第一行不能被点击
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.row == 0 {
            return nil
        }
        return indexPath
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