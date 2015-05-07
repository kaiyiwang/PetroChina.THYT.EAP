//
//  ERP_TabBar.swift
//  PetroChina.thyt.ERP
//
//  Created by Mensp on 14-10-13.
//  Copyright (c) 2014年 tuha. All rights reserved.
//

import UIKit

class ERP_TabBar: UITabBarController {
    
    
    @IBOutlet weak var tb: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tb.selectedImageTintColor = UIColor(red: 201/255, green: 27/255, blue: 0, alpha: 1)
//        self.edgesForExtendedLayout = UIRectEdge.None
//        self.extendedLayoutIncludesOpaqueBars = false
//        self.modalPresentationCapturesStatusBarAppearance = false

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
