//
//  HomeWatchItemCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/03.
//

import UIKit

class HomeRecentWatchItemCell: UICollectionViewCell {
    
    static let identifier: String = "HomeRecentWatchItemCell"

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private var imageTask: Task<Void, Never>?

    // DateFormatter는 생성비용이 큼 따라서 static으로 생성해서 사용하는게 좋음
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYMMDD."
        
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbnailImageView.layer.cornerRadius = 42
        self.thumbnailImageView.layer.borderWidth = 2
        self.thumbnailImageView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageTask?.cancel()
        self.imageTask = nil
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subtitleLabel.text = nil
        self.dateLabel.text = nil
    }
    
    func setData(_ data: Home.Recent) {
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.channel
        self.dateLabel.text = Self.dateFormatter.string(
            from: .init(timeIntervalSince1970: data.timeStamp)
        )
        self.imageTask = self.thumbnailImageView.loadImage(url: data.imageUrl)
    }

}
