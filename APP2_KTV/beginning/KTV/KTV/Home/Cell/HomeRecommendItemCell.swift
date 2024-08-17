//
//  HomeRecommendItemCell.swift
//  KTV
//
//  Created by 변상필 on 8/18/24.
//

import UIKit

class HomeRecommendItemCell: UITableViewCell {
    
    static let height: CGFloat = 71
    static let identifier: String = "HomeRecommendItemCell"

    @IBOutlet weak var thumbnailContainerView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var playTimeBGView: UIView!
    @IBOutlet weak var playTimeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbnailContainerView.layer.cornerRadius = 5
        self.rankLabel.layer.cornerRadius = 5
        self.rankLabel.clipsToBounds = true
        self.playTimeBGView.layer.cornerRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
