//
//  ListTableViewCell.swift
//  syousetutoukou kairyou
//
//  Created by リボルバー　オセロット on 2017/02/11.
//  Copyright © 2017年 ocelot. All rights reserved.
//

import UIKit
import Firebase //Firebaseをインポート

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var postDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
