//
//  HomeVideoCell.swift
//  KTV
//
//  Created by 변상필 on 8/16/24.
//

import UIKit

class HomeVideoCell: UITableViewCell {
     
    // cell register를 위해 선언
    static let identifier: String = "HomeVideoCell"
    static let height: CGFloat = 321
    
    @IBOutlet weak var containerView: UIView! // border처리를 위한 전체 container View

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var hotImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelsubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // xib를 사용한 cell같은 뷰들의 UI작업은 awakeFromNib에서 작성하는게 좋다.
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.containerView.layer.borderWidth = 1
        
//        layer 값이 기대와 같이 들어가지 않을 경우 clipsToBounds를 켬으로써 해결할 수 있다.
//        self.containerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
