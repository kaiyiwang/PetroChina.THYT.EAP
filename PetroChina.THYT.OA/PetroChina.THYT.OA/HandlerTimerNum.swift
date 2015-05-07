//
//  HandlerTimerNum.swift
//  PetroChina.THYT.OA
//  处理返回过来的时间格式
//  Created by zhaitingting on 14/11/17.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import Foundation

func returnTimerNum(str:NSString) -> NSString {
    if str.length == 0 {
        return "无"
    }
    var all:NSString = str.substringToIndex(8)
    var nian:NSString = all.substringToIndex(4)
    var ri:NSString = all.substringFromIndex(6)
    var range:NSRange = NSMakeRange(4, 2)
    var yue:NSString = all.substringWithRange(range)
    
    return (nian as String)+"-"+(yue as String)+"-"+(ri as String)
}
func returnDetailTimerNum(str:NSString) -> NSString {
    if str.length == 0 {
        return "无"
    }
    var all:NSString = str.substringToIndex(8)
    var nian:NSString = all.substringToIndex(4)
    var ri:NSString = all.substringFromIndex(6)
    var range:NSRange = NSMakeRange(4, 2)
    var yue:NSString = all.substringWithRange(range)
    
    var timer = (nian as String)+"-"+(yue as String)+"-"+(ri as String)
    
    var detail:NSString = str.substringFromIndex(8)
    var hour:NSString = detail.substringToIndex(2)
    var range1:NSRange = NSMakeRange(2, 2)
    var minute:NSString = detail.substringWithRange(range1)
    var miao:NSString = detail.substringFromIndex(4)
    
    var detailTime = (hour as String)+":"+(minute as String)+":"+(miao as String)
    
    return timer+" "+detailTime
}