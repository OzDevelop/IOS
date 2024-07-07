//
//  voiceMemoApp.swift
//  voiceMemo
//

import SwiftUI

@main
struct voiceMemoApp: App {
    // UIKitAppDelegate를 생성하는데 사용하는 프로퍼티 래퍼
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
