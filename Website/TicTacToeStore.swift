//
//  TicTacToeStore.swift
//  Website
//
//  Created by Sigil Wen on 2023-06-29.
//

import Foundation

class TicTacToeStore: ObservableObject {
    @Published var count = 0

    @Published var board: [Int] = []
    
    @Published var isX: Bool = true
    
    @Published var hasWon: Bool = false
    
    init() {
        board = Array(repeating: 0, count: 9)
        isX = true
    }
}
