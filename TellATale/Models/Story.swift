//
//  Story.swift
//  TellATale
//
//  Created by Saanica Gupta on 13/07/25.
//

import Foundation

struct Story: Identifiable {
    let id = UUID()
    let content: String
    let genre: StoryGenre
    let character: StoryCharacter
    let createdAt: Date
    
    init(content: String, genre: StoryGenre, character: StoryCharacter) {
        self.content = content
        self.genre = genre
        self.character = character
        self.createdAt = Date()
    }
}

enum StoryGenre: String, CaseIterable {
    case fantasy = "Fantasy"
    case romance = "Romance"
    case adventure = "Adventure"
    case mystery = "Mystery"
    case comedy = "Comedy"
    case sciFi = "Sci-Fi"
    
    var displayName: String {
        rawValue
    }
}

enum StoryCharacter: String, CaseIterable {
    case elsa = "Elsa"
    case spiderMan = "Spider-Man"
    case jasmine = "Jasmine"
    case harryPotter = "Harry Potter"
    case cinderella = "Cinderella"
    case aladdin = "Aladdin"
    
    var displayName: String {
        rawValue
    }
    
    var emoji: String {
        switch self {
        case .elsa: return "❄️"
        case .spiderMan: return "🕷️"
        case .jasmine: return "🧞‍♀️"
        case .harryPotter: return "⚡"
        case .cinderella: return "👑"
        case .aladdin: return "🧞‍♂️"
        }
    }
} 