//
//  StoryGeneratorViewModel.swift
//  TellATale
//
//  Created by Saanica Gupta on 13/07/25.
//

import Foundation
import SwiftUI
import Combine

class StoryGeneratorViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var selectedGenre: StoryGenre = .fantasy
    @Published var selectedCharacter: StoryCharacter = .elsa
    @Published var currentStory: Story?
    @Published var isStoryGenerated: Bool = false
    @Published var isLoading: Bool = false
    
    // MARK: - Dependencies
    private let storyService: StoryServiceProtocol
    
    // MARK: - Computed Properties
    var availableGenres: [StoryGenre] {
        StoryGenre.allCases
    }
    
    var availableCharacters: [StoryCharacter] {
        StoryCharacter.allCases
    }
    
    // MARK: - Initialization
    init(storyService: StoryServiceProtocol = StoryService()) {
        self.storyService = storyService
    }
    
    // MARK: - Public Methods
    @MainActor
    func generateStory() async {
        isLoading = true
        
        do {
            let story = try await storyService.generateStoryFromPrompt(for: selectedGenre, character: selectedCharacter)
            currentStory = story
            isStoryGenerated = true
        } catch {
            // Return fallback story in case of error
            let fallbackStory = Story(
                content: "Oops no story found",
                genre: selectedGenre,
                character: selectedCharacter
            )
            currentStory = fallbackStory
            isStoryGenerated = true
        }
        
        isLoading = false
    }
    
    func clearStory() {
        currentStory = nil
        isStoryGenerated = false
    }
    
    func selectGenre(_ genre: StoryGenre) {
        selectedGenre = genre
    }
    
    func selectCharacter(_ character: StoryCharacter) {
        selectedCharacter = character
    }
} 