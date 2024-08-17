//
//  HomeViewController.swift
//  KTV
//
//  Created by 변상필 on 8/16/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent } // statusBarStyle을 lightContent로 처리
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait } // 회전에 대한 처리
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
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
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "empty") // ?? 이거 먼디
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
            return 2
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
            return tableView.dequeueReusableCell(
                withIdentifier: HomeVideoCell.identifier,
                for: indexPath
            )
        case .recommend:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HomeRecommendContainerCell.identifier,
                for: indexPath
            )
            
            (cell as? HomeRecommendContainerCell)?.delegate = self
            
            return cell
        case .footer:
            return tableView.dequeueReusableCell(
                withIdentifier: HomeFooterCell.identifier,
                for: indexPath
            )
        }
    }
}

// 이렇게 delegate 패턴 사용하는것도 설명 듣기 + 앨런 강의도 있삼
extension HomeViewController: HomeRecommendContainerCellDelegate {
    func homeRecommendContainerCell(_ cell: HomeRecommendContainerCell, didSelectItemAt index: Int) {
        print("home recommend cell did select item at \(index)")
    }
}
