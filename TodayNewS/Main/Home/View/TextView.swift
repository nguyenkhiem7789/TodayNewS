//
//  TextView.swift
//  TodayNewS
//
//  Created by XJF on 2021/3/16.
//

import UIKit
import WebKit

class TextView: UIViewController {
//    @IBOutlet weak var textTitle: UILabel!
//    @IBOutlet weak var textText: UILabel!
    
    var urlSring:String = ""
    
    lazy var webView : WKWebView = {
       var webView = WKWebView(frame: CGRect(x: 0, y: 0, width: HN_SCREEN_WIDTH, height: HN_SCREEN_HEIGHT))
        self.view.addSubview(webView)
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: self.urlSring)!)
        self.webView.load(request)
        self.view.addSubview(webView)
    }
}
