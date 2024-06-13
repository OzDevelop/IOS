//
//  OnboardingViewModel.swift
//  voiceMemo
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var onboardingContents: [OnboardingContent]
    
    init(
        onboardingContents: [OnboardingContent] = [
            .init(
                imageFileName: "onboarding_1",
                title: "오늘의 할일",
                subTitle: "To do list로 언제 어디서든 해야할일을 한눈에"
            ),
            .init(
                imageFileName: "onboarding_2",
                title: "똑똑한 나만의 기록장",
                subTitle: "To do list로 언제 어디서든 해야할일을 한눈에"
            ),
            .init(
                imageFileName: "onboarding_3",
                title: "하나라도 놓치지 않도록",
                subTitle: "To do list로 언제 어디서든 해야할일을 한눈에"
            ),
            .init(
                imageFileName: "onboarding_4",
                title: "정확한 시간의 경과",
                subTitle: "To do list로 언제 어디서든 해야할일을 한눈에"
            )
        ]
    ) {
        self.onboardingContents = onboardingContents
    }
}
