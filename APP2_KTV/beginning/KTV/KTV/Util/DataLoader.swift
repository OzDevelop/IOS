//
//  DataLoader.swift
//  KTV
//
//  Created by Lecture on 2023/09/10.
//

import Foundation

struct DataLoader {
    // URLSession 생성(네트워킹 객체)
    private static let session: URLSession = .shared
    
    static func load<T: Decodable>(url: String, for type: T.Type) async throws -> T {
        // URL이 있다면 url 구조체를 만듦.
        guard let url = URL(string: url) else {
            // 없다면 에러를 던지고
            throw URLError(.unsupportedURL)
        }
        // 해당 url에서 데이터 다운로드
        // data(for:) 함수는 (data, response)를 반환하므로 여기서 data만 가져옴.
        let data = try await Self.session.data(for: .init(url: url)).0
        let jsonDecoder = JSONDecoder()
        // 다운로드한 데이터 디코딩.
        return try jsonDecoder.decode(T.self, from: data)
    }
}
