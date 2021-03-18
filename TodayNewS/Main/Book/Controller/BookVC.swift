//
//  BookVC.swift
//  TodayNewS
//
//  Created by XJF on 2021/3/13.
//


import UIKit
import WMPageController

class BookVC: WMPageController {
    
    let bookArray = ["书架","男生","女生"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuViewStyle = .line
        self.itemMargin = 10
        self.dataSource = self
        self.delegate = self
    }
}

extension BookVC{
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor preferredFrameFormenuView: WMMenuView) -> CGRect{
        return  CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT, width: HN_SCREEN_WIDTH, height: HN_MENU_HEIGHT)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect{
        
        return  CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT + HN_MENU_HEIGHT, width: HN_SCREEN_WIDTH, height:HN_SCREEN_HEIGHT-HN_NAVIGATION_BAR_HEIGHT-HN_MENU_HEIGHT - HN_TABBER_BAR_HEIGHT )
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return self.bookArray[index]
    }
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        let vc = UIViewController()
        switch index {
        case 0:
            vc.view.frame = CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT + HN_STATUS_BAR_HEIGHT, width: HN_SCREEN_WIDTH, height: HN_SCREEN_HEIGHT)
            return vc
        case 1:
            let vc = boyBook()
            vc.view.frame = CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT + HN_STATUS_BAR_HEIGHT, width: HN_SCREEN_WIDTH, height: HN_SCREEN_HEIGHT)
            return vc
        case 2:
            let vc = boyBook()
            vc.view.frame = CGRect(x: 0, y: HN_NAVIGATION_BAR_HEIGHT + HN_STATUS_BAR_HEIGHT, width: HN_SCREEN_WIDTH, height: HN_SCREEN_HEIGHT)
            return vc
        default:
            break
        }
        
//        vc.MenuTitle = dataArray[index]
        return vc
        
    }
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        
        return self.bookArray.count
    }
}
