//
//  StoryService.swift
//  TellATale
//
//  Created by Saanica Gupta on 13/07/25.
//

import Foundation
import FoundationModels

// MARK: - Custom Errors
enum StoryGenerationError: Error, LocalizedError {
    case emptyResponse
    case generationFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "The story generation returned an empty response"
        case .generationFailed(let error):
            return "Story generation failed: \(error.localizedDescription)"
        }
    }
}

protocol StoryServiceProtocol {
    func generateStoryFromPrompt(for genre: StoryGenre, character: StoryCharacter) async throws -> Story
}

final class StoryService: StoryServiceProtocol {
    private var session: LanguageModelSession
    
    init() {
        self.session = LanguageModelSession()
    }
    
    func generateStoryFromPrompt(for genre: StoryGenre, character: StoryCharacter) async throws -> Story {
        let prompt = """
        make a fictional story with main character \(character.displayName) and theme of the story is \(genre.displayName). 
        
        Requirements:
        - The story should be short and have 50 words or less
        """
        
        do {
            let response = try await session.respond(to: prompt)
            
            // Validate the response
            guard !response.content.isEmpty else {
                throw StoryGenerationError.emptyResponse
            }
            
            // Clean up the response if needed
            let cleanedContent = response.content.trimmingCharacters(in: .whitespacesAndNewlines)
            
            return Story(content: cleanedContent, genre: genre, character: character)
        } catch {
            throw StoryGenerationError.generationFailed(error)
        }
    }
} 
