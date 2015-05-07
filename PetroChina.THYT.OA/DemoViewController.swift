//
//  DemoViewController.swift
//  PKHUD Demo
//
//  Created by Philip Kluz on 6/18/14.
//  Copyright (c) 2014 NSExceptional. All rights reserved.
//

import UIKit
import PKHUD

@objc
class DemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        HUDController.sharedController.dimsBackground = false
        HUDController.sharedController.userInteractionOnUnderlyingViewsEnabled = false
    }
    
    @IBAction func showStatusHUD(sender: AnyObject) {
        HUDController.sharedController.contentView = HUDContentView.StatusView(title: "Ringer", subtitle: "Silent", image: HUDAssets.ringerMutedImage)
        HUDController.sharedController.show()
        HUDController.sharedController.hide(afterDelay: 2.0)
    }
    
    @IBAction func showProgressHUD(sender: AnyObject) {
        HUDController.sharedController.contentView = HUDContentView.ProgressView()
        HUDController.sharedController.show()
        HUDController.sharedController.hide(afterDelay: 2.0)
    }
    
    @IBAction func showTitleHUD(sender: AnyObject) {
        HUDController.sharedController.contentView = HUDContentView.TitleView(title: "Success", image: HUDAssets.checkmarkImage)
        HUDController.sharedController.show()
        HUDController.sharedController.hide(afterDelay: 2.0)
    }
    
    @IBAction func showSubtitleHUD(sender: AnyObject) {
        HUDController.sharedController.contentView = HUDContentView.SubtitleView(subtitle: "Error", image: HUDAssets.crossImage)
        HUDController.sharedController.show()
        HUDController.sharedController.hide(afterDelay: 2.0)
    }
    
    @IBAction func showTextHUD(sender: AnyObject) {
        HUDController.sharedController.contentView = HUDContentView.TextView(text: "Requesting Licence…")
        HUDController.sharedController.show()
        HUDController.sharedController.hide(afterDelay: 2.0)
    }
    
    @IBAction func showAlertWithHUD(sender: AnyObject) {
        let alert = UIAlertController(title: "An Alert", message: "With an Extraordinary Message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.showTitleHUD(sender)
        }
    }
//        导入文件：
//    import PKHUD
//    以下就是几个展现HUD的方法：
//    HUDContentView.TextView(...)
//    HUDContentView.ImageView(...)
//    HUDContentView.ProgressView(...)
//    HUDContentView.TitleView(...)
//    HUDContentView.SubtitleView(...)
//    HUDContentView.StatusView(...)
//    
//    也能够通过控制器的内容界面来展现HUD:
//    var contentView = HUDContentView.ProgressView()
//    HUDController.sharedController.contentView = contentView
//    HUDController.sharedController.show()
//    
//    当然也可以让它消失：
//    HUDController.sharedController.hide(animated: true)
//    或者延迟一下消失： 
//    HUDController.sharedController.hide(afterDelay: 2.0) 
//
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
