//
//  ZongHBG_ShengChDT.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by Apple on 15/4/23.
//  Copyright (c) 2015年 PetroChina. All rights reserved.
//

import UIKit

class ZongHBG_ShengChDT: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var shengChDT: UIButton!
    @IBOutlet weak var xiangXChX: UIButton!
    var myview:UIView!
    var imageView = UIImageView()
    var url = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        //菊花显示
        
        myview = JvHua(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 100, height: 100))
        self.view.addSubview(myview)
    
        MoKuaiQuanXiang(shengchanFirst)
        
//
        webView.delegate = self
    }
    //验证模块访问权限
    func MoKuaiQuanXiang(string:String)
    {
        //判断是否包含权限
        if has(shengchanQuanxian) == true
        {
            //访问动态数据
            var url:NSURL = NSURL(string:string)!
            var request:NSURLRequest = NSURLRequest(URL:url)
            self.webView.loadRequest(request)
        }
        else
        {
            //访问错误页面
            var url:NSURL = NSURL(string:ErrorPage)!
            var request:NSURLRequest = NSURLRequest(URL:url)
            self.webView.loadRequest(request)
            
            
        }
    }
    //返回大厅
    @IBAction func backDaTing(sender: AnyObject)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    @IBAction func clickedShengChDT(sender: AnyObject)
    {
        xiangXChX.backgroundColor = UIColor.grayColor()
        shengChDT.backgroundColor = UIColor.whiteColor()
        
        MoKuaiQuanXiang(shengchanFirst)
    }
    @IBAction func clickedXiangXChX(sender: AnyObject)
    {
        xiangXChX.backgroundColor = UIColor.whiteColor()
        shengChDT.backgroundColor = UIColor.grayColor()
        //加载详细查询网页
        MoKuaiQuanXiang(shengchanSencond)
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
