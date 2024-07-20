//
//  HomeViewModel.swift
//  voiceMemo
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: Tab
    @Published var todosCount: Int
    @Published var memosCount: Int
    @Published var voiceRecorderCount: Int
    
    init(
        selectedTap: Tab = .voiceRecorder,
        todosCount: Int = 0,
        memosCount: Int = 0,
        voiceRecorderCount: Int = 0
    ) {
        self.selectedTab = selectedTap
        self.todosCount = todosCount
        self.memosCount = memosCount
        self.voiceRecorderCount = voiceRecorderCount
    }
}

extension HomeViewModel {
    // 3가지는 -> TodosCount~VoiceRecrderCount 갯수 변경
    func setTodosCount(_ count: Int) {
        todosCount = count
    }
    
    func setMemosCount(_ count: Int) {
        memosCount = count
    }
    
    func setVoiceRecordersCount(_ count: Int) {
        voiceRecorderCount = count
    }
    
    // tab 변경 메서드
    func changeSelectedTap(_ tap: Tab) {
        selectedTab = tap
    }
}
