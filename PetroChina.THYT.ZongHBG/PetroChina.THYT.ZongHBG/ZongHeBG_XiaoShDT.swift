//
//  ZongHeBG_XiaoShDT.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by Mensp on 14/10/30.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class ZongHeBG_XiaoShDT: UITableViewController,UIWebViewDelegate {
    //菊花
    var myview:UIView!
    var refresh = UIRefreshControl()//刷新
    @IBOutlet weak var wvXiaoShDT: UIWebView!
    //返回大厅按钮触发事件
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
  override func viewDidLoad() {
       super.viewDidLoad()
    self.wvXiaoShDT.delegate = self
    //刷新
    refresh.attributedTitle = NSAttributedString(string: "正在刷新")
    refresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
    self.refreshControl = refresh
    //菊花显示
    myview = JvHua(frame: CGRect(x: self.view.center.x-50, y: self.view.center.y-150, width: 100, height: 100))
    self.view.addSubview(myview)
        // Do any additional setup after loading the view.
//       var url:NSURL = NSURL(string:"http://127.0.0.1:10024/DayReport/cyc_rb/xsdt/xsdtsy.jsp")!
    var url:NSURL = NSURL(string:xiaoshoudongtaiSecond)!

        var request:NSURLRequest = NSURLRequest(URL:url)
        self.wvXiaoShDT.loadRequest(request)
    reload()
    }
    func reload(){
        
        println("reload")
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
//        var url:NSURL = NSURL(string:"http://127.0.0.1:10024/DayReport/cyc_rb/xsdt/xsdtsy.jsp")!
        var url:NSURL = NSURL(string:xiaoshoudongtaiSecond)!

        var request:NSURLRequest = NSURLRequest(URL:url)
        self.wvXiaoShDT.loadRequest(request)

        
        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
        //                 refresh.attributedTitle = NSAttributedString(string: "结束刷新")
    }

   override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        NSLog("start")
        myview.hidden = false
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        NSLog("finish")
        myview.hidden = true
    }

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
