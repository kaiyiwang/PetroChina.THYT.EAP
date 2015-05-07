//
//  JvHua.swift
//  PetroChina.THYT.OA
//  菊花封装
//  Created by zhaitingting on 14/11/19.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

var isHidden = true
class JvHua: UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        var myview = UIView(frame: CGRect(x: -58, y: -30, width: 120, height:90 ))
        myview.backgroundColor = UIColor.blackColor()
        myview.alpha = 0.4
        myview.layer.cornerRadius = 8;
        self.addSubview(myview)
//        self.backgroundColor = UIColor.purpleColor()
        var activityIndicatorView:UIActivityIndicatorView
        //风格有WhiteLarge菊花大小为37*37，White为20*20，Gray为灰色
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        //activityIndicatorView.frame = CGRectMake(160, 230, 0, 0)
        //设置位置
        activityIndicatorView.center =  CGPointMake(0,0)
        var mylabel = UILabel(frame: CGRect(x: -48, y: 20, width: 100, height: 30))
        mylabel.font = UIFont(name:"Arial Hebrew", size: 15)
        mylabel.text = "正在加载数据"
//        mylabel.backgroundColor = UIColor.greenColor()
        mylabel.textAlignment = NSTextAlignment.Center
        mylabel.textColor = UIColor.whiteColor()
        self.addSubview(mylabel)
        activityIndicatorView.color = UIColor.whiteColor()
        //是否在停止转动时隐藏
        activityIndicatorView.hidesWhenStopped = true
        //        alertView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        self.addSubview(activityIndicatorView)
        self.hidden = isHidden
    }
   
    class func setHidden(hidden:Bool)
    {
        isHidden = hidden
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
