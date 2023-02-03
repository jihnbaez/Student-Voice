//
//  File.swift
//  Student Voice
//
//  Created by 4d on 2/3/23.
//

import Foundation

struct Suggestion {
    var name: String
    var description: String
    var upvotes: Int
    
    
}

struct listOfSuggestions {
    var title: String
    var suggestions: [Suggestion]
}


