//
//  DataError.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/26/25.
//

import Foundation

enum DataError: Error {
    case fileNotFound
    case parsingFailed
    
    var errorMessage: String {
        switch self {
        case .fileNotFound:
            return "파일을 찾을 수 없습니다."
        case .parsingFailed:
            return "데이터를 변환하는 데에\n실패했습니다."
        }
    }
}
