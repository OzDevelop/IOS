//
//  AppDelegate.swift
//  voiceMemo
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    /// AppDelegate 를 통해서 앱에서 일어하는 상호작용이나 시스템 로우레벨에서 할 수 있는 것들을 컨트롤 할 수 있음
    
    var notificationDelegate = NotificationDelegate()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // 런칭이 되었을 때, 무엇을 실행할 것인지
        UNUserNotificationCenter.current().delegate = notificationDelegate
        return true
    }
    
}
