//
//  boyBook.swift
//  TodayNewS
//
//  Created by XJF on 2021/3/16.
//

import UIKit
import Alamofire

class boyBook: UIViewController {
    
    var maleClass : [String] = []
    var femaleClass : [String] = []
    var pictureClass : [String] = []
    var pressClass : [String] = []
    
    private let cellIdentifier = "bookCellID"
    @IBOutlet weak var HotBook: UICollectionView!
    
    @IBAction func BookClassBtn(_ sender: Any) {
        AF.request("http://api.zhuishushenqi.com/cats/lv2/statistics", method: .get).responseJSON { [self] (response) in
            let bookClass = response.value as! [String:Any]
            let male = bookClass["male"] as! NSArray
            let female = bookClass["female"] as! NSArray
            let picture = bookClass["picture"] as! NSArray
            let press = bookClass["press"] as! NSArray
            
            for i in 0...(male.count - 1){
                let maleN = male[i] as! [String:Any]
                let maleName = maleN["name"] as! String
                maleClass.append(maleName)
            }
            for i in 0...(female.count - 1){
                let femaleN = female[i] as! [String:Any]
                let femaleName = femaleN["name"] as! String
                femaleClass.append(femaleName)
            }
            for i in 0...(picture.count - 1){
                let pictureN = picture[i] as! [String:Any]
                let pictureName = pictureN["name"] as! String
                pictureClass.append(pictureName)
            }
            for i in 0...(press.count - 1){
                let pressN = press[i] as! [String:Any]
                let pressName = pressN["name"] as! String
                pressClass.append(pressName)
            }
            
            print(maleClass,femaleClass,pictureClass,pressClass)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HotBook.dataSource = self
        self.HotBook.delegate = self
        self.HotBook.register(UINib(nibName: "bookCell", bundle: nil), forCellWithReuseIdentifier:cellIdentifier)
    }
}

extension boyBook:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! bookCell
        cell.bookName.text = "天尊"
        cell.bookImg.image = UIImage(named: "test")
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
}
