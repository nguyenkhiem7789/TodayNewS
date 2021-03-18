//
//  MessageView.swift
//  TodayNewS
//
//  Created by XJF on 2021/3/13.
//

import UIKit
import Masonry
import Alamofire
import SDWebImage

class MessageView: UIViewController {
    
    var MenuTitle = ""
    var MesTitle : [String] = []
    var MesTime : [String] = []
    var MesSrc : [String] = []
    var MesPic : [String] = []
    var MesUrl : [String] = []
    
    
    
    
    lazy var tabView : UITableView = {
    
        ()->UITableView
        in
        
        var tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 75
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.mas_makeConstraints { (make) in
            make?.right.mas_equalTo()(0)
            make?.left.mas_equalTo()(0)
            make?.top.mas_equalTo()(0)
            make?.bottom.mas_equalTo()(0)
        }
        
        let contentNib = UINib(nibName: "\(MessageCell.self)", bundle: nil)
        tableView.register(contentNib, forCellReuseIdentifier: "\(MessageCell.self)")
        
        return tableView
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://way.jd.com/jisuapi/get?"
        
        self.view.addSubview(tabView)
        
        let parameters:[String : Any] = [
            "channel": MenuTitle,
            "num": 20,
            "start": 0,
            "appkey":"自己去京东万象申请key，免费的，一天可以有1000的量"
        ]
        
        AF.request(url,method: .post,parameters: parameters).responseJSON { [self] (response) in
            
            let dic = response.value as! [String : Any]
            let result = dic["result"] as! [String : Any]
            if result["msg"] as! String == "ok"{
                print("请求成功")
                let res = result["result"] as! [String : Any]
                let title = res["list"] as! NSArray
                
                for i in 0...(title.count - 1){
                    let ary = title[i] as! [String:Any]
                    
                    self.MesTitle.append(ary["title"] as! String)
                    self.MesTime.append(ary["time"] as! String)
                    self.MesSrc.append(ary["src"] as! String)
                    self.MesPic.append(ary["pic"] as! String)
                    self.MesUrl.append(ary["weburl"] as! String)
                }
                self.tabView.reloadData()
            }
        }
        
    }
}

extension MessageView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.MesTitle.count != 0 {
            return self.MesTitle.count
        }else{
            return 10
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let resultCell:MessageCell = tabView.dequeueReusableCell(withIdentifier: "\(MessageCell.self)") as! MessageCell
        resultCell.separatorInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        if self.MesTime.count != 0 && self.MesTitle.count != 0 && self.MesSrc.count != 0{
            resultCell.Time.text = self.MesTime[indexPath.row]
            resultCell.Title.text = self.MesTitle[indexPath.row]
            resultCell.src.text = self.MesSrc[indexPath.row]
            resultCell.oic.sd_setImage(with: URL(string: self.MesPic[indexPath.row]), completed: nil)
        }else{
            resultCell.Time.text = "2021-03-16"
            resultCell.Title.text = "我是你爸爸"
            resultCell.src.text = "我是你爸爸"
            resultCell.oic.image = UIImage(named: "test")
        }
        
        return resultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let textView = TextView()
        textView.urlSring = self.MesUrl[indexPath.row]
        
        self.present(textView, animated: true, completion: nil)
    }
}
