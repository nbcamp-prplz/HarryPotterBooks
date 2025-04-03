//
//  BookUseCaseTest.swift
//  HarryPotterBooksTests
//
//  Created by 이수현 on 4/3/25.
//

import XCTest
@testable import HarryPotterBooks

final class BookUseCaseTest: XCTestCase {
    private var repository: BookRepositoryProtocol!
    private var useCase: BookUseCaseProtocol!
    private let userDefaults = UserDefaults.standard
    private let key = UserDefaultsKey.summaryExpandStatus.rawValue
    
    override func setUp() {
        super.setUp()
        repository = BookRepository(network: MockNetwork())
        useCase = BookUseCase(bookRepository: repository)
        userDefaults.removeObject(forKey: key) // UserDefaults 초기화
    }
    
    override func tearDown() {
        repository = nil
        useCase = nil
        super.tearDown()
    }
    
    // UserDefaults에 summaryExpandStatus가 존재하는지 여부 테스트
    func testIsExistedSummaryExpandStatus() {
        // 데이터가 존재하지 않을 때
        var result = useCase.isSavedBooks()
        XCTAssertFalse(result)
        
        // 데이터가 존재할 때
        let books = Book.dummy()
        saveData(books: books) // 데이터 저장
        
        result = useCase.isSavedBooks()
        XCTAssertTrue(result)
    }

    // UserDefaults에 더보기 유무 저장 테스트
    func testSaveSummaryExpandStatus() {
        let books = Book.dummy()
        useCase.saveSummaryExpandStatus(books: books) // 데이터 저장
        
        let result = userDefaults.dictionary(forKey: key) as? [String: Bool] // 저장된 값 확인
        XCTAssertEqual(result?.count, 3)
        
        result?.values.forEach({ value in
            XCTAssertEqual(value, false) // 모든 value가 false로 초기화 되는 지 확인
        })
    }
    
    // UserDefaults에 저장되어 있는 값 불러오기 테스트
    func testLoadSummaryExapndStatus() {
        let books = Book.dummy()
        saveData(books: books) //  UserDefaults에 데이터 저장
        
        let result = useCase.loadSummaryExpandStatus(books: books)
        XCTAssertEqual(result?[0].0.title, books[0].title)
        XCTAssertEqual(result?[1].0.title, books[1].title)
        XCTAssertEqual(result?[2].0.title, books[2].title)
        
        XCTAssertEqual(result?[0].1, true)
        XCTAssertEqual(result?[1].1, false)
        XCTAssertEqual(result?[2].1, true)
    }
    
    // 더보기 유무 일부 저장 테스트
    func testPartSaveSummaryExpandStatus() {
        let books = Book.dummy()
        saveData(books: books) //  UserDefaults에 데이터 저장
        
        // 첫 번째 데이터 false로 변경
        useCase.saveSummaryExpandStatus(title: books[0].title, isExpandedSummary: false)
        
        let result = userDefaults.dictionary(forKey: key) as? [String: Bool] // 저장된 값 확인
        XCTAssertEqual(result?[books[0].title], false)
        
    }
    
    // UserDefaults에 데이터 저장
    private func saveData(books: [Book]) {
        let dic = [
            books[0].title: true,
            books[1].title: false,
            books[2].title: true,
        ]
        userDefaults.set(dic, forKey: key) // 데이터 저장
    }
}
