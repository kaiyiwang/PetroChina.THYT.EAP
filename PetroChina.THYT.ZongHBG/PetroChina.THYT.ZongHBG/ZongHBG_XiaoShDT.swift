//
//  ZongHBG_XiaoShDT.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by Apple on 15/4/23.
//  Copyright (c) 2015年 PetroChina. All rights reserved.
//

import UIKit

class ZongHBG_XiaoShDT: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var XiaoShDT: UIButton!
    @IBOutlet weak var XiangXChX: UIButton!
    @IBOutlet weak var webView: UIWebView!
    var myview:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        //菊花显示
        myview = JvHua(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 100, height: 100))
        self.view.addSubview(myview)
        MoKuaiQuanXiang(xiaoshoudongtaiFirst)
        
    }

   
    @IBAction func backDaTing(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickedXiaoShDT(sender: AnyObject)
    {
        XiangXChX.backgroundColor = UIColor.grayColor()
        XiaoShDT.backgroundColor = UIColor.whiteColor()
        
        MoKuaiQuanXiang(xiaoshoudongtaiFirst)
    }
    @IBAction func XiangXChX(sender: AnyObject) {
        XiangXChX.backgroundColor = UIColor.whiteColor()
        XiaoShDT.backgroundColor = UIColor.grayColor()
        MoKuaiQuanXiang(xiaoshoudongtaiSecond)
    }
    
    //验证模块访问权限
    func MoKuaiQuanXiang(string:String)
    {
        //判断是否包含权限
        if has(xiaoshoudongQuanxian) == true
        {
            //访问动态数据
            var url:NSURL = NSURL(string:string)!
            var request:NSURLRequest = NSURLRequest(URL:url)
            self.webView.loadRequest(request)
            
            
        }
        else
        {
            //加载权限访问页面
            var url:NSURL = NSURL(string:ErrorPage)!
            var request:NSURLRequest = NSURLRequest(URL:url)
            self.webView.loadRequest(request)
            
            //
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        NSLog("start")
//        PageLoading()
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
