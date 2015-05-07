//
//  RadioBtn.swift
//  PetroChina.THYT.ERP
//
//  Created by Liwenbin on 11/3/14.
//  Copyright (c) 2014 PetroChina. All rights reserved.
//

import UIKit

class RadioBtn: UIButton {

    var radio_x = 0
    var radio_y = 0
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("frame")
    }

    /*init(xx:NSInteger,yy:NSInteger) {
        super.init()
        radio_x = xx
        radio_y == yy
        println("init")
//        self.frame = CGRect(x: radio_x, y: radio_y, width: 22, height: 22)
    } */
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
