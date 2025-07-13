//
//  StoryDisplayView.swift
//  TellATale
//
//  Created by Saanica Gupta on 13/07/25.
//

import SwiftUI

struct StoryDisplayView: View {
    let story: Story
    let onClear: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Your Story")
                    .font(.headline)
                    .foregroundColor(.purple)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // Clear Story Button (Cross Icon)
                Button(action: onClear) {
                    Image(systemName: "xmark")
                        .font(.system(size: 10))
                        .foregroundColor(.red)
                        .padding(4)
                        .background(
                            Circle()
                                .fill(Color.white.opacity(0.9))
                                .shadow(color: .red.opacity(0.3), radius: 1, x: 0, y: 1)
                        )
                }
            }
            
            Text(story.content)
                .font(.body)
                .foregroundColor(.primary)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.95))
                        .shadow(color: .purple.opacity(0.2), radius: 8, x: 0, y: 3)
                )
        }
        .padding(.horizontal)
        .transition(.opacity.combined(with: .scale))
    }
}

#Preview {
    let sampleStory = Story(
        content: "Once upon a time, Elsa discovered an ancient ice crystal that granted her the power to create entire cities of frost.",
        genre: .fantasy,
        character: .elsa
    )
    
    StoryDisplayView(story: sampleStory) {}
        .background(Color.gray.opacity(0.1))
} 