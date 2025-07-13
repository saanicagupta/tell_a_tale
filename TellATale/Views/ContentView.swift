//
//  ContentView.swift
//  TellATale
//
//  Created by Saanica Gupta on 13/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = StoryGeneratorViewModel()
    
    var body: some View {
        ZStack {
            // Magical fairytale gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.purple.opacity(0.4),
                    Color.indigo.opacity(0.3),
                    Color.purple.opacity(0.2),
                    Color.pink.opacity(0.2)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Title Section
                    titleSection
                    
                    // Genre Selection Section
                    genreSelectionSection
                    
                    // Character Selection Section
                    characterSelectionSection
                    
                    // Generate Button
                    generateButton
                    
                    // Story Display
                    if viewModel.isStoryGenerated, let story = viewModel.currentStory {
                        StoryDisplayView(story: story) {
                            viewModel.clearStory()
                        }
                    }
                    
                    Spacer(minLength: 50)
                }
                .padding()
            }
        }
    }
    
    // MARK: - View Components
    
    private var titleSection: some View {
        VStack(spacing: 10) {
            Text("Tell A Tale")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .shadow(color: .purple.opacity(0.3), radius: 2, x: 0, y: 1)
            
            Text("✨ Story Generator ✨")
                .font(.title2)
                .foregroundColor(.indigo)
                .fontWeight(.medium)
        }
        .padding(.top, 20)
    }
    
    private var genreSelectionSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Choose Your Genre")
                .font(.headline)
                .foregroundColor(.purple)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.availableGenres, id: \.self) { genre in
                        GenreButton(
                            genre: genre,
                            isSelected: viewModel.selectedGenre == genre,
                            action: { viewModel.selectGenre(genre) }
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var characterSelectionSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Choose Your Character")
                .font(.headline)
                .foregroundColor(.purple)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.availableCharacters, id: \.self) { character in
                        CharacterButton(
                            character: character,
                            isSelected: viewModel.selectedCharacter == character,
                            action: { viewModel.selectCharacter(character) }
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var generateButton: some View {
        Button(action: {
            Task {
                await viewModel.generateStory()
            }
        }) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "wand.and.stars")
                        .font(.title2)
                }
                Text(viewModel.isLoading ? "Generating..." : "Generate Story")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.indigo]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(20)
            .shadow(color: .purple.opacity(0.4), radius: 10, x: 0, y: 5)
        }
        .disabled(viewModel.isLoading)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
} 