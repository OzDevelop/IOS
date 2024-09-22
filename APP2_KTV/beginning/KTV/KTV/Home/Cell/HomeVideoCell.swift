//
//  HomeVideoCell.swift
//  KTV
//
//  Created by 변상필 on 8/16/24.
//

import UIKit

/// prepareForReuse() 함수의 역할
/// 셀 재사용 되기 전 초기화해주는 역할.

///  DateFormatter는 생성비용이 큼 따라서 static으로 생성해서 사용하는게 좋음

/// awakeFromNib() 역할
///  xib로 만든 ui가 클래스에 정상적으로 연동을 마쳤을 경우 실행되는 함수

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
    
    private var thumbnailTask: Task<Void, Never>?
    private var channelThumbnailTask: Task<Void, Never>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // xib를 사용한 cell같은 뷰들의 UI작업은 awakeFromNib에서 작성하는게 좋다.
        // awakeFromNib 함수가 xib로 만든 UI가 클래스에 정상적으로 연동되었을 경우 동작하므로
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        self.containerView.layer.borderWidth = 1
        
//        layer 값이 기대와 같이 들어가지 않을 경우 clipsToBounds를 켬으로써 해결할 수 있다.
//        self.containerView.clipsToBounds = true
    }
    
    // 셀 재사용되기 전 동작하여 초기화시키는 함수
    // 이를 통해 셀의 내용이 변경될때 의도치 않은 셀의 등장을 막을 수 있음
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.thumbnailTask?.cancel()
        self.thumbnailTask = nil
        self.channelThumbnailTask?.cancel()
        self.channelThumbnailTask = nil
        
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.channelTitleLabel.text = nil
        self.channelImageView.image = nil
        self.channelsubtitleLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: Home.Video) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.subtitle
        self.channelTitleLabel.text = data.channel
        self.channelsubtitleLabel.text = data.channelDescription
        self.hotImageView.isHidden = !data.isHot
        self.thumbnailTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
        self.channelThumbnailTask = self.channelImageView.loadImage(url: data.channelThumbnailURL)
    }
}
