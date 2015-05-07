//
//  HudShow.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/16.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit
import PKHUD
class HudShow: NSObject {
   
    //显示状态栏
    func showProgressHUD(){
        HUDController.sharedController.contentView = HUDContentView.ProgressView()
        HUDController.sharedController.show()
    }
    //显示时间
    func hudShowTime(time:Double) {
    
        HUDController.sharedController.hide(afterDelay: time)
    }
    //隐藏
    func hudHide(){
        HUDController.sharedController.hide(animated: true)
    }
    //显示对号，带标题的
    func showTitleHUD(titleStr:NSString) {
        HUDController.sharedController.contentView = HUDContentView.TitleView(title: titleStr as String, image: HUDAssets.checkmarkImage)
        HUDController.sharedController.show()
        HUDController.sharedController.hide(afterDelay: 2)
    }
    //显示一行信息
    func showTextHUD(textStr:NSString){
        HUDController.sharedController.contentView = HUDContentView.TextView(text: textStr as String)
        HUDController.sharedController.show()
    }
    
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
}
