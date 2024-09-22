//
//  UIImageView+Task.swift
//  KTV
//
//  Created by Lecture on 2023/09/10.
//

import UIKit

/// UIImageView를 extension하여 이미지를 비동기적으로 불러옴
/// 원격 이미지 URL을 로드
extension UIImageView {
    // 반환타입 Task(비동기 작업을 나타내는 타입)를 생성하여 반환, 실패 가능성이 없기 때문에 Never을 통해 failure를 리턴하지 않음
    // 🚒🚒🚒 Task 타입에 대해서 찾아보자 🚒🚒🚒
    func loadImage(url: URL) -> Task<Void, Never> {
        // Task 생성
        return .init {
            guard
                let responseData = try? await URLSession.shared.data(for: .init(url: url)).0,
                let image = UIImage(data: responseData)
            else {
                return
            }
            
            self.image = image
        }
    }
}
