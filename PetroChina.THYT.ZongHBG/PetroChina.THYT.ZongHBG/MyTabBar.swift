//
//  MyTabBar.swift
//  PetroChina.THYT.ZongHBG
//
//  Created by Mensp on 14/10/27.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class MyTabBar: UITabBarController {

    @IBOutlet weak var TabbarC: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TabbarC.selectedImageTintColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
