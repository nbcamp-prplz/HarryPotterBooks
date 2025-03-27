//
//  DataError.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

enum DataError: Error {
    case fileNotFound   // 데이터를 찾을 수 없을 때
    case parsingFailed   // 데이터 파싱에 실패했을 때
}


extension DataError {
    var description: String {
        switch self {
        case .fileNotFound:
            "파일을 찾을 수 없습니다"
        case .parsingFailed:
            "데이터 파싱에 실패했습니다"
        }
    }
}
