//
//  UserDefaultsManager.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/28/25.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    func saveReadMoreStates(_ readMoreStates: [Bool]) {
        UserDefaults.standard.set(readMoreStates, forKey: "readMoreStates")
    }
    
    func getReadMoreStates() -> [Bool] {
        guard let readMoreStates = UserDefaults.standard.object(forKey: "readMoreStates") as? [Bool] else {
            return []
        }
        
        return readMoreStates
    }
    
    static func removeReadMoreStates() {
        UserDefaults.standard.removeObject(forKey: "readMoreStates")
    }
}
