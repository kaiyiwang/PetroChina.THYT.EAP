//
//  ZongHBG_KanTDT.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by Apple on 15/4/23.
//  Copyright (c) 2015年 PetroChina. All rights reserved.
//

import UIKit

class ZongHBG_KanTDT: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var KanTDT: UIButton!
    @IBOutlet weak var XiangXChX: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    var myview:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //菊花显示
        
        myview = JvHua(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 100, height: 100))
        self.view.addSubview(myview)
        
        MoKuaiQuanXiang(kantandongtaiFirst)
       
        
        
        webView.delegate = self
        // Do any additional setup after loading the view.
    }

    //验证模块访问权限
    func MoKuaiQuanXiang(string:String)
    {
        //判断是否包含权限
        if has(kantandongtaiQuanxian) == true
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
    @IBAction func backDaTing(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    @IBAction func clickedKanTDT(sender: AnyObject) {
        XiangXChX.backgroundColor = UIColor.grayColor()
        KanTDT.backgroundColor = UIColor.whiteColor()
        MoKuaiQuanXiang(kantandongtaiFirst)
    }
    @IBAction func clickedXiangXChX(sender: AnyObject) {
        XiangXChX.backgroundColor = UIColor.whiteColor()
        KanTDT.backgroundColor = UIColor.grayColor()
        //加载详细查询网页
        MoKuaiQuanXiang(kantandongtaiSecond)
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
