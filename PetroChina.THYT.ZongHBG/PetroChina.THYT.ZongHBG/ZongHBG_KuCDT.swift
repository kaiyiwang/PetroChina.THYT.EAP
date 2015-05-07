//
//  ZongHBG_KuCDT.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by Apple on 15/4/23.
//  Copyright (c) 2015年 PetroChina. All rights reserved.
//

import UIKit

class ZongHBG_KuCDT: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var KuCDT: UIButton!
    @IBOutlet weak var XiangXChX: UIButton!
    @IBOutlet weak var webView: UIWebView!
    var myview:UIView!
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //加载库存动态首页
        MoKuaiQuanXiang(kucundongtaiFirst)

        
    }
    
    //验证模块访问权限
    func MoKuaiQuanXiang(string:String)
    {
        webView.delegate = self
        //菊花显示
        myview = JvHua(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 100, height: 100))
        self.view.addSubview(myview)
        
        //判断是否包含权限
        if has(kucundongtaiQuanxian) == true
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
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //返回大厅
    @IBAction func backDaTing(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    @IBAction func clickedKuCDT(sender: AnyObject) {
        XiangXChX.backgroundColor = UIColor.grayColor()
        KuCDT.backgroundColor = UIColor.whiteColor()
        //加载生产动态首页
        MoKuaiQuanXiang(kucundongtaiFirst)
    }
    @IBAction func clickedXiangXChX(sender: AnyObject) {
        XiangXChX.backgroundColor = UIColor.whiteColor()
        KuCDT.backgroundColor = UIColor.grayColor()
        //加载详细查询页面
        MoKuaiQuanXiang(kucundongtaiSecond)
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
