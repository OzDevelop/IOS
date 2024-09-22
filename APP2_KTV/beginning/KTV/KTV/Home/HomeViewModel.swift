//
//  HomeViewModel.swift
//  KTV
//
//  Created by 변상필 on 8/18/24.
//

import Foundation

//🚒🚒🚒 여기 코드 다시보기 🚒🚒🚒

/// 네트워크에서 데이터를 받아와 UI에 반영하는 역할
/// UI가 변경되기 때문에 메인스레드에서 실행됨이 보장되어야 함.
/// 따라서 @MainActor 사용
@MainActor class HomeViewModel {
    // 외부에서 값을 읽을수는 있지만 수정할 수 없도록 함.
    private(set) var home: Home?
    
    /// UI가 데이터를 반영하기 위한 콜백 클로저
    /// 데이터가 변경될 때 마다 호출되어 뷰 업데이트
    var dataChanged: (() -> Void)?
    
    func requestData() {
        // Task - 비동기 작업을 실행하는 기본 도구
        Task {
            do {
                self.home = try await DataLoader.load(url: URLDefines.home, for: Home.self)
                
                //🚒🚒🚒 ??? 이거 머죵 🚒🚒🚒
                self.dataChanged?()
            } catch {
                print("json parsing failed: \(error.localizedDescription)")
            }
        }
    }
}
