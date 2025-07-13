//
//  GenreButton.swift
//  TellATale
//
//  Created by Saanica Gupta on 13/07/25.
//

import SwiftUI

struct GenreButton: View {
    let genre: StoryGenre
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(genre.displayName)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isSelected ? .white : .purple)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(backgroundColor)
                .overlay(overlayView)
                .shadow(color: shadowColor, radius: 5, x: 0, y: 2)
        }
    }
    
    private var backgroundColor: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(
                    colors: isSelected ? [.purple, .indigo] : [Color.white.opacity(0.95), Color.white.opacity(0.95)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
    
    private var overlayView: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(isSelected ? Color.clear : Color.purple.opacity(0.4), lineWidth: 2)
    }
    
    private var shadowColor: Color {
        isSelected ? .purple.opacity(0.4) : .clear
    }
}

#Preview {
    HStack {
        GenreButton(genre: .fantasy, isSelected: true) {}
        GenreButton(genre: .romance, isSelected: false) {}
    }
    .padding()
} 