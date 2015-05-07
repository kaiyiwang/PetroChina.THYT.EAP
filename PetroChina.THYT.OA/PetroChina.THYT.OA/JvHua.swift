//
//  JvHua.swift
//  PetroChina.THYT.OA
//  菊花封装
//  Created by zhaitingting on 14/11/19.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit
var isHidden = true
class JvHua: UIView {

	var activityIndicatorView:UIActivityIndicatorView!
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.purpleColor()
        
        //风格有WhiteLarge菊花大小为37*37，White为20*20，Gray为灰色
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        //activityIndicatorView.frame = CGRectMake(160, 230, 0, 0)
        //设置位置
        activityIndicatorView.center =  CGPointMake(50,40)
        var mylabel = UILabel(frame: CGRect(x: 5, y: 50, width: 150, height: 50))
        mylabel.font = UIFont(name:"Arial Hebrew", size: 13)
        mylabel.text = "没有待办的业务"
        mylabel.textColor = UIColor.grayColor()
        self.addSubview(mylabel)
        activityIndicatorView.color = UIColor.grayColor()
        //是否在停止转动时隐藏
        activityIndicatorView.hidesWhenStopped = true
        //        alertView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        self.addSubview(activityIndicatorView)
        self.hidden = isHidden
    }
   
    class func setHidden(hidden:Bool){
        isHidden = hidden
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
