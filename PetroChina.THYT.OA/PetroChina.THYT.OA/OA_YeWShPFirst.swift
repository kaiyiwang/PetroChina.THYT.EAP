//
//  OA_YeWShPFirst.swift
//  PetroChina.THYT.OA
//
//  Created by zhaitingting on 14/11/13.
//  Copyright (c) 2014年 PetroChina. All rights reserved.
//

import UIKit

class OA_YeWShPFirst: UITableViewController {
    
   
     var myRefresh = UIRefreshControl() //刷新控件
    override func viewDidLoad() {
        super.viewDidLoad()

        //刷新实现
        myRefresh.attributedTitle = NSAttributedString(string: "正在刷新")
        myRefresh.addTarget(self, action: "reload", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = myRefresh
        //不显示数据为空的空行
        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    //返回大厅按钮触发事件
    @IBAction func btn_Clicked(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "EnterpriseHall://")!)
    }
    

    //刷新触发的事件
    func reload(){
        
        println("reload FaWZhSh")
        self.tableView.reloadData()
        sleep(1)
        self.refreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //格式化ListView隔行现实效果。
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor(red: 1.0, green: 0.99, blue: 0.97, alpha: 1.0) : UIColor(red: 0.96, green: 0.97, blue: 0.92, alpha: 1.0)
        
        //cell.backgroundColor = indexPath.row % 2 == 0 ?
        cell.imageView?.layer.cornerRadius = 22.0
        cell.imageView?.layer.masksToBounds = true
        //呈现动态效果图
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
        
    }
        

    var kanTan = false
    var zuanJing = false
    //地质勘探按钮点击
    @IBAction func diZhiKanTanClicked(sender: AnyObject) {
       kanTan = true
        zuanJing = false
    }
    //钻井地质点击
    @IBAction func ZuanJIngDiZhiClicked(sender: AnyObject) {
        zuanJing = true
       kanTan = false
    }
   
       // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "kanTan"||segue.identifier == "zuanJing" {
          
            let myVC = segue.destinationViewController as! OA_OtherYeWShPTableViewController
            myVC.kanTan = kanTan
            myVC.zuanJing = zuanJing
           
        }
        if segue.identifier == "KaiFaJing" {
            let kaiFaJingVC = segue.destinationViewController as! OA_OtherYeWShPTableViewController
            kaiFaJingVC.kaiFaJing = true
        }
        if segue.identifier == "CaiWu" {
            let kaiFaJingVC = segue.destinationViewController as! OA_OtherYeWShPTableViewController
            kaiFaJingVC.CaiWu = true
        }
        if segue.identifier == "BiaoWai" {
            let biaoWaiVC = segue.destinationViewController as! OA_OtherYeWShPTableViewController
            biaoWaiVC.biaoWai = true
        }
        if segue.identifier == "ZuanJingQi" {
            let biaoWaiVC = segue.destinationViewController as! OA_OtherYeWShPTableViewController
            biaoWaiVC.ZuanJingQi = true
        }
        if segue.identifier == "TanJing" {
            let biaoWaiVC = segue.destinationViewController as! OA_OtherYeWShPTableViewController
            biaoWaiVC.TanJing = true
        }
        if segue.identifier == "LingDao"  {
            let qingXiaoJiaVC = segue.destinationViewController as! OA_YeWShP
            qingXiaoJiaVC.lingDao = true
            qingXiaoJiaVC.yuanGong = false
                   }
        if segue.identifier == "YuanGong" {
            let qingXiaoJiaVC = segue.destinationViewController as! OA_YeWShP
            qingXiaoJiaVC.lingDao = false
            qingXiaoJiaVC.yuanGong = true
          
        }
        
        

    }
    

}
