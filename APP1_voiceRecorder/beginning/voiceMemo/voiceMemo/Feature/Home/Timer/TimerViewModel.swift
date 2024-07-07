//
//  TimerViewModel.swift
//  voiceMemo
//

import Foundation
import UIKit

class TimerViewModel: ObservableObject {
    @Published var isDisplaySetTimeView: Bool // 피그마 상 두 뷰는 동일한 뷰 위에서 동작할꺼라서(뷰따로 만드는거 아님)
    @Published var time: Time
    @Published var timer: Timer?
    @Published var timeRemaining: Int
    @Published var isPaused: Bool
    
    var notificationService: NotificationService
    
    init(
        isDisplaySetTimeView: Bool = false,
        time: Time = .init(hours: 0, minutes: 0, seconds: 0),
        timer: Timer? = nil,
        timeRemaining: Int = 0,
        isPaused: Bool = false,
        notificationService: NotificationService = .init()
    ) {
        self.isDisplaySetTimeView = isDisplaySetTimeView
        self.time = time
        self.timer = timer
        self.timeRemaining = timeRemaining
        self.isPaused = isPaused
        self.notificationService = notificationService
    }
}

// 비즈니스 로직
extension TimerViewModel {
    //설정하기 버튼 탭
    func settingBtnTapped() {
        isDisplaySetTimeView = false
        timeRemaining = time.convertedSeconds
        // TODO: - 타이머 시작 메서드 호출!
        startTimer()
        
    }
    
    //취소 버튼 탭
    func cancelBtnTapped() {
        // TODO: - 타이머 종료 메서드 호출
        stopTimer()
        isDisplaySetTimeView = true
    }
    
    //일시정지 후 재개 버튼
    func pauseOrRestartBtnTapped() {
        if isPaused {
            // TODO: - 타이머 시작 메서드 호출
            startTimer()
        } else {
            stopTimer()
        }
        isPaused.toggle()
    }
}

// 비즈니스 로직 내부에서 동작할 함수
private extension TimerViewModel {
    func startTimer() {
        guard timer == nil else { return }
        
        //background 상태에서도 noti가 올 수 있도록 하기 위한 설정
        var backgroundTaskID: UIBackgroundTaskIdentifier?
        // 앱이 background로 전환되었을 때에도 일부 작업을 계속 수행할 수 있게 해주는 메서드
        backgroundTaskID = UIApplication.shared.beginBackgroundTask {
            if let task = backgroundTaskID {
                UIApplication.shared.endBackgroundTask(task)
                backgroundTaskID = .invalid
            }
        }
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                // TODO: - 타이머 종료 메서드 호출
                self.stopTimer()
                self.notificationService.sendNotification()
                
                //background 상태에서도 noti가 올 수 있도록 하기 위한 설정
                if let task = backgroundTaskID {
                    UIApplication.shared.endBackgroundTask(task)
                    backgroundTaskID = .invalid
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
