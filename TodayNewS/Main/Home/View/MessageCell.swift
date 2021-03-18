//
//  MessageCell.swift
//  TodayNewS
//
//  Created by XJF on 2021/3/13.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    @IBOutlet weak var Title: UILabel!
    
    @IBOutlet weak var src: UILabel!
    
    @IBOutlet weak var Time: UILabel!
    
    @IBOutlet weak var oic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setFrame(frame: frame)
    }
    
    func setFrame(frame:CGRect) {
        self.frame.origin.x += 10
        self.frame.origin.y += 10
        self.frame.size.width -= 20
        self.frame.size.height -= 20
    }
}
