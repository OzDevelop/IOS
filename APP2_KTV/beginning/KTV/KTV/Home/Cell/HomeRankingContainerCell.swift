//
//  HomeRankingContainerCell.swift
//  KTV
//
//  Created by Lecture on 2023/09/09.
//

import UIKit

// 셀에서 항목을 선택했을 때 호출될 델리게이트 메서드 정의
// 🚒🚒🚒 델리게이트 패턴 다시 보기 🚒🚒🚒
protocol HomeRankingContainerCellDeleate: AnyObject {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int)
}

// UITableViewCell을 상속받는 커스텀 셀
class HomeRankingContainerCell: UITableViewCell {

    static let identifier: String = "HomeRankingContainerCell"
    static let height: CGFloat = 349
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: HomeRankingContainerCellDeleate?
    private var rankings: [Home.Ranking]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // collectionView에 HomeRankingItemCell 등록
        self.collectionView.register(
            UINib(nibName: HomeRankingItemCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: HomeRankingItemCell.identifier
        )
        // UICollectionView dataSource, delegate 설정
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: [Home.Ranking]) {
        self.rankings = data
        
        // 데이터 갱신을 위한 reloadData()
        self.collectionView.reloadData()
    }
}

extension HomeRankingContainerCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // numberOfItemsInSection - 랭킹 배열의 항목 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.rankings?.count ?? 0
    }
    
    // cellForItemAt - 해당 인덱스의 셀 반환, 셀 데이터 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // dequeueReusableCell - 셀 재사용
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeRankingItemCell.identifier,
            for: indexPath
        )
        
        // as? - 셀 타입 캐스팅
        /// dequeueReuseableCell은 UICollectionViewCell을 반환하는데 이를 HomeRankingItenCell 로 다운캐스팅 시도.
        if let cell = cell as? HomeRankingItemCell,
           let data = self.rankings?[indexPath.item] {
            cell.setData(data, rank: indexPath.item + 1)
        }
        
        return cell
    }
    
    // didSelectItemAt - 특정 항목 선택되었을 시 델리게이트 메서드 호출하여 선택된 항목의 인덱스 전달.
    // 🚒🚒🚒 델리게이트 패턴 다시 보기 🚒🚒🚒
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.homeRankingContainerCell(self, didSelectItemAt: indexPath.item)
    }
}
