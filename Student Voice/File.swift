//
//  File.swift
//  Student Voice
//
//  Created by 4d on 2/3/23.
//

import Foundation

struct Suggestion: Equatable {
    var name: String
    var detail: String
    var upvotes: Int
    var category:Int
    var sectionTitle: String {
        String(name.uppercased().first ?? "?")
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
    
}

struct listOfSuggestions {
    var title: String
    var suggestions: [Suggestion]
}


