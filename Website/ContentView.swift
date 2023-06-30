//
//  ContentView.swift
//  Website
//
//  Created by Sigil Wen on 2023-06-29.
//

import SwiftUI
import RealityKit
import RealityKitContent
import Foundation

struct ContentView: View {
    
    @ObservedObject private var store = TicTacToeStore()
    
    var body: some View {
        NavigationSplitView {
            List {
                Text("Current Piece: \(store.isX ? "X" : "O")")
                
                if (store.hasWon) {
                    Text("💦 LESGO YOU WON \(store.isX ? "O" : "X")")
                }
            }
            .navigationTitle("Hello World")
        } detail: {
            VStack {
                BoardView(store: store)
            }
            .navigationTitle("PEPE vs. DOGE")
            .padding()
        }
    }
}

struct BoardView: View {
    
    @ObservedObject var store: TicTacToeStore

    var body: some View {
        VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<3) { column in
                            
                            ShapeView(value: store.board[row*3 + column])
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    handleCellTapped(row: row, column: column)
                                }

                        }
                    }
                }
            }
    }
    
    func handleCellTapped(row: Int, column: Int) {
        store.board[row * 3 + column] = store.isX ? 1: 2
        
        store.isX = !store.isX
                
        print("value: \(store.isX)")
        
        checkWinner()

    }
    
    func checkWinner() {
            // Define the winning combinations (rows, columns, diagonals)
            let winningCombinations: [[Int]] = [
                [0, 1, 2], // Top row
                [3, 4, 5], // Middle row
                [6, 7, 8], // Bottom row
                [0, 3, 6], // Left column
                [1, 4, 7], // Middle column
                [2, 5, 8], // Right column
                [0, 4, 8], // Diagonal (top-left to bottom-right)
                [2, 4, 6]  // Diagonal (top-right to bottom-left)
            ]

            // Check each winning combination for a match
            for combination in winningCombinations {
                let cell1 = store.board[combination[0]]
                let cell2 = store.board[combination[1]]
                let cell3 = store.board[combination[2]]

                if cell1 != 0 && cell1 == cell2 && cell2 == cell3 {
                    // We have a winner
                    print("Player \(cell1) wins!")
                    
                    store.hasWon = true
                    // You can add additional logic here based on the winning condition
                    return
                }
            }

            // No winner yet
            print("No winner yet")
        }
}

struct ShapeView: View {
    let value: Int
    
    var body: some View {
        Group {
            if value == 1 {
                Model3D(named: "Pepe_The_Frog")
                    .scaleEffect(x: 0.1, y: 0.1, z: 0.1)
                    .padding(.bottom, 50)
                    .offset(z: -600)
            } else if value == 2 {
                Model3D(named: "Roblox_Doge_Hat")
                    .scaleEffect(x: 0.04, y: 0.04, z: 0.04)
                    .padding(.bottom, 50)
                    .offset(z: -600)
            } else {
                Text("LOL")
            }
        }
    }
}

#Preview {
    ContentView()
}
