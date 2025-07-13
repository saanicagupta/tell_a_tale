//
//  CharacterButton.swift
//  TellATale
//
//  Created by Saanica Gupta on 13/07/25.
//

import SwiftUI

struct CharacterButton: View {
    let character: StoryCharacter
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(character.emoji)
                    .font(.system(size: 30))
                
                Text(character.displayName)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? .white : .purple)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 4)
            }
            .frame(width: 85, height: 90)
            .background(backgroundColor)
            .overlay(overlayView)
            .shadow(color: shadowColor, radius: 5, x: 0, y: 2)
        }
    }
    
    private var backgroundColor: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(isSelected ?
                  AnyShapeStyle(LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)) :
                  AnyShapeStyle(Color.white.opacity(0.95))
            )
    }
    
    private var overlayView: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(isSelected ? Color.clear : Color.purple.opacity(0.4), lineWidth: 2)
    }
    
    private var shadowColor: Color {
        isSelected ? .purple.opacity(0.4) : .clear
    }
}

#Preview {
    HStack {
        CharacterButton(character: .elsa, isSelected: true) {}
        CharacterButton(character: .spiderMan, isSelected: false) {}
        CharacterButton(character: .harryPotter, isSelected: false) {}
    }
    .padding()
} 