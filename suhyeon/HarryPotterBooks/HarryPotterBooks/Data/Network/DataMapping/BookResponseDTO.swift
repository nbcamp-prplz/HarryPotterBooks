//
//  BookResponseDTO.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

struct BookResponseDTO: Decodable {
    let data: [BookResponse]
}
