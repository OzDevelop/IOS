//
//  HomeViewController.swift
//  KTV
//
//  Created by 변상필 on 8/16/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let homeViewModel: HomeViewModel = .init()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent } // statusBarStyle을 lightContent로 처리
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait } // 회전에 대한 처리
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.bindViewMode()
        self.homeViewModel.requestData()
    }
    
    private func setupTableView() {
        //HeaderCell
        self.tableView.register(
            UINib(nibName: "HomeHeaderCell", bundle: .main),
            forCellReuseIdentifier: HomeHeaderCell.identifier
        )
        //VideoCell
        self.tableView.register(  //tableView에 cell register
            UINib(nibName: "HomeVideoCell", bundle: nil),
            forCellReuseIdentifier: HomeVideoCell.identifier
        )
        //RecommendContainerCell
        self.tableView.register(
            UINib(nibName: "HomeRecommendContainerCell", bundle: .main),
            forCellReuseIdentifier: HomeRecommendContainerCell.identifier
        )
        // FooterCell
        self.tableView.register(
            UINib(nibName: "HomeFooterCell", bundle: .main),
            forCellReuseIdentifier: HomeFooterCell.identifier
        )
        
        self.tableView.register(
            UINib(nibName: HomeRankingContainerCell.identifier,
                  bundle: nil),
            forCellReuseIdentifier: HomeRankingContainerCell.identifier
        )
        
        self.tableView.register(
            UINib(nibName: HomeRecentWatchContainerCell.identifier, bundle: .main),
            forCellReuseIdentifier: HomeRecentWatchContainerCell.identifier
        )
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty") // 🚒🚒🚒 이거 먼디 🚒🚒🚒
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.isHidden = true
    }
    
    // 🚒🚒🚒 여기 흐름을 잘 모르겠음 🚒🚒🚒
    private func bindViewMode() {
        self.homeViewModel.dataChanged = { [weak self] in
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }
    }
}

// 가독성을 위해 delegate를 extention으로 따로 뺌
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //section의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        HomeSection.allCases.count // CaseIterable을 채택했기 때문에 allCases가능
    }
    
    //각 세션에 표시할 행의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else {
            return 0
        }
        switch section {
        case .header:
            return 1
        case .video:
            return self.homeViewModel.home?.videos.count ?? 0
        case .ranking:
            return 1
        case .recentWatch:
            return 1
        case .recommend:
            return 1
        case .footer:
            return 1
        
        }
    }
    
    // 설명듣고 노션에 추가
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return 0
        }
        switch section {
        case .header:
            return HomeHeaderCell.height
        case .video:
            return HomeVideoCell.height
        case .ranking:
            return HomeRankingContainerCell.height
        case .recentWatch:
            return HomeRecentWatchContainerCell.height
        case .recommend:
            return HomeRecommendContainerCell.height
        case .footer:
            return HomeFooterCell.height
        }
    }
    
    
    // 특정 Row에 Cell의 정보를 담아 Cell 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else {
            return tableView.dequeueReusableCell(withIdentifier: "empty", for: indexPath)
        }
        
        switch section {
        case .header:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeHeaderCell.identifier,
                for: indexPath
            )
        case .video:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeVideoCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeVideoCell,
                let data = self.homeViewModel.home?.videos[indexPath.row] {
                cell.setData(data)
            }
            
            return cell
        case .ranking:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRankingContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRankingContainerCell,
                let data = self.homeViewModel.home?.rankings {
                cell.setData(data)
            }
            
            (cell as? HomeRankingContainerCell)?.delegate = self
            
            return cell
        case .recentWatch:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecentWatchContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRecentWatchContainerCell,
                let data = self.homeViewModel.home?.recents {
                cell.delegate = self
                cell.setData(data)
            }
            
            return cell
        case .recommend:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecommendContainerCell.identifier,
                for: indexPath
            )
            
            if
                let cell = cell as? HomeRecommendContainerCell,
                let data = self.homeViewModel.home?.recommends {
                cell.delegate = self
                cell.setData(data)
            }
            
            return cell
        case .footer:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeFooterCell.identifier,
                for: indexPath
            )
        }
    }
}

// 🚒🚒🚒 이렇게 delegate 패턴 사용하는것도 설명 듣기 + 앨런 강의도 있삼 🚒🚒🚒
extension HomeViewController: HomeRecommendContainerCellDelegate {
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int) {
        print("home recommend cell did select item at \(index)")
    }
}

extension HomeViewController: HomeRankingContainerCellDeleate {
    func homeRankingContainerCell(_ cell: HomeRankingContainerCell, didSelectItemAt index: Int) {
        print("home ranking did select at \(index)")
    }
}

extension HomeViewController: HomeRecentWatchContainerCellDelegate {
    func homeRecentWatchContainerCell(_ cell: HomeRecentWatchContainerCell, didSelectItemAt index: Int) {
        print("home recent watch did select at \(index)")
    }
}
