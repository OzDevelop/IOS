//
//  HomeRecommendContainerCell.swift
//  KTV
//
//  Created by 변상필 on 8/18/24.
//

import UIKit

protocol HomeRecommendContainerCellDelegate: AnyObject { 
    // 🚒🚒🚒 anyobject 아 이거 봤었는데 찾아보기 🚒🚒🚒
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int)
    
}

class HomeRecommendContainerCell: UITableViewCell {
    
    static let identifier: String = "HomeRecommendContainerCell"
    static var height: CGFloat {
        let top: CGFloat = 84 - 6 // 첫번째 cell에서 bottom까지의 거리 - cell의 상단 여백
        let bottom: CGFloat = 68 - 6 // 마지막 cell첫번째 bottom까지의 거리 - cell의 하단 여백
        let footerInset: CGFloat = 51 // container -> footer 까지의 여백
        
        return HomeRecommendItemCell.height * 5 + top + bottom + footerInset
    }
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var foldButton: UIButton!
    
    weak var delegate: HomeRecommendContainerCellDelegate?
    // 설명 듣거나 찾아보기
    
    private var recommends: [Home.Recommend]?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.borderWidth = 1
        self.containerView.layer.borderColor = UIColor(named: "stroke-light")?.cgColor
        
        self.tableView.rowHeight = HomeRecommendItemCell.height
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            UINib(nibName: "HomeRecommendItemCell", bundle: .main),
            forCellReuseIdentifier: HomeRecommendItemCell.identifier
        )
    }
    
    @IBAction func foldButtonDidTap(_ sender: Any) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: [Home.Recommend]) {
        self.recommends = data
        self.tableView.reloadData()
    }
}

extension HomeRecommendContainerCell: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5 // 접힘, 펼침 처리를 위함
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecommendItemCell.identifier, for: indexPath)
        
        if let cell = cell as? HomeRecommendItemCell,
           let data = self.recommends?[indexPath.row] {
            cell.setData(data, rank: indexPath.row + 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.homeRecommendContainerCell(self, didSelectItemAt: indexPath.row)
    }
}
