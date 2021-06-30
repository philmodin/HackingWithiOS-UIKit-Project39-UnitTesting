//
//  PlayData.swift
//  Project39 UnitTesting
//
//  Created by endOfLine on 6/28/21.
//

import Foundation

class PlayData {
    var allWords = [String]()
    private(set) var filteredWords = [String]()
    var wordCounts: NSCountedSet!
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                allWords = allWords.filter { $0 != ""}
                
                wordCounts = NSCountedSet(array: allWords)
                let sorted = wordCounts.allObjects.sorted { wordCounts.count(for: $0) > wordCounts.count(for: $1) }
                allWords = sorted as! [String]
            }
        }
        applyUserFilter("swift")
    }
    
    func applyUserFilter(_ input: String) {
        guard input.count > 0 else {
            filteredWords = allWords
            return
        }
        if let userNumber = Int(input) {
            applyFilter { wordCounts.count(for: $0) >= userNumber }
        } else {
            applyFilter { $0.range(of: input, options: .caseInsensitive) != nil }
        }
    }
    
    func applyFilter(_ filter: (String) -> Bool) {
        filteredWords = allWords.filter(filter)
    }
}
