//
//  File.swift
//  Student Voice
//
//  Created by 4d on 2/3/23.
//

import Foundation

struct Suggestion:CustomStringConvertible {
    var name: String
    var detail: String
    var upvotes: Int
    var description: String {
        return "\(detail)"
    }
    
}

struct listOfSuggestions {
    var title: String
    var suggestions: [Suggestion]
}


