//
//  MockNetwork.swift
//  HarryPotterBooksTests
//
//  Created by 이수현 on 4/3/25.
//

import Foundation
@testable import HarryPotterBooks

class MockNetwork: BookNetworkProtocol {
    func fetchBooks() async -> Result<[HarryPotterBooks.Book], HarryPotterBooks.DataError> {
        return .success([])
    }
}
