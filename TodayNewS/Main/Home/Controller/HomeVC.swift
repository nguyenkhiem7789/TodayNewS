//
//  HomeVC.swift
//  TodayNewS
//
//  Created by XJF on 2021/3/13.
//


import UIKit
import Alamofire
import WMPageController

let HN_SCREEN_HEIGHT :CGFloat = UIScreen.main.bounds.height
let HN_SCREEN_WIDTH :CGFloat = UIScreen.main.bounds.width
let HN_NAVIGATION_BAR_HEIGHT :CGFloat = UIScreen.main.bounds.height == 812 ? 88 :64
let HN_STATUS_BAR_HEIGHT  :CGFloat =  UIScreen.main.bounds.height ==  812 ? 44 : 20
let HN_TABBER_BAR_HEIGHT :CGFloat  =  UIScreen.main.bounds.height ==  812 ? 83 : 49
let HN_BOTTOM_MARGIN  :CGFloat =  UIScreen.main.bounds.height == 812 ? 34 : 0
let HN_MENU_HEIGHT :CGFloat = 36.0

class HomeVC: WMPageController {
    
    var dataArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.menuViewStyle = .line
        self.itemMargin = 10
        self.dataSource = self
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AF.request("https://way.jd.com/jisuapi/channel?appkey=自己去京东万象申请key，免费的，一天可以有1000的量",method: .post).responseJSON { [self] (response) in
            let dic = response.value as! [String : Any]
            let result = dic["result"] as! [String : Any]
            if result["msg"] as! String == "ok"{
                print("请求成功")
                let title = result["result"]
                self.dataArray = title as! [String]
                self.reloadData()
            }
        }
    }
    
}

extension HomeVC{
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor preferredFrameFormenuView: WMMenuView) -> CGRect{
        return  CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT, width: HN_SCREEN_WIDTH, height: HN_MENU_HEIGHT)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect{
        
        return  CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT + HN_MENU_HEIGHT, width: HN_SCREEN_WIDTH, height:HN_SCREEN_HEIGHT-HN_NAVIGATION_BAR_HEIGHT-HN_MENU_HEIGHT - HN_TABBER_BAR_HEIGHT )
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return self.dataArray[index]
    }
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        let vc = MessageView()
//        vc.view.frame = CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT + HN_STATUS_BAR_HEIGHT, width: HN_SCREEN_WIDTH, height: HN_SCREEN_HEIGHT)
        vc.MenuTitle = dataArray[index]

        return vc
    }
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        
        return self.dataArray.count
    }
}
