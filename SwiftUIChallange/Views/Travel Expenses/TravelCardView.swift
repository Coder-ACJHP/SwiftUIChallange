//
//  TravelCardView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 3.03.2026.
//

import SwiftUI

struct TravelCardView: View {
    enum SwipeDirection {
        case left
        case right
    }
    
    @Binding var card: Card
    let cardsAnimated: Bool
    let rotateDegree: CGFloat
    let translation: CGPoint
    let scale: CGFloat
    let isTopCard: Bool
    let onSwipe: (SwipeDirection) -> Void
    
    @State private var dragX: CGFloat = 0
    
    var body: some View {
        ZStack {
            if let uiImage = UIImage(named: card.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 280, height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 20.resp))
            }
            
            
            VStack {
                HStack {
                    Button { card.isSaved.toggle() } label: {
                        Image(systemName: card.isSaved ? "bookmark.fill" : "bookmark")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.white)
                    }
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.white, style: .init(lineWidth: 1.0))
                    }
                    .animation(.easeInOut, value: card.isSaved)
                    
                    Spacer()
                    
                    Button { card.isLiked.toggle() } label: {
                        Image(systemName: card.isLiked ? "heart.fill" : "heart")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(Color.red)
                    }
                    .padding()
                    .background(.white.opacity(0.5))
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(.white, style: .init(lineWidth: 1.0))
                    }
                    .animation(.easeInOut, value: card.isLiked)
                }
                
                Spacer()
                
                // Bottom card
                HStack(spacing: 5.resp) {
                    VStack(spacing: 5.resp) {
                        Text(card.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 14.resp, weight: .medium))
                            .foregroundStyle(.white)
                        Text(card.subtitle)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 12.resp, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    
                    Button {} label: {
                        Image(systemName: "wifi")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.white)
                            .frame(width: 28.resp)
                            .background(RoundedRectangle(cornerRadius: 8.resp)
                                .fill(Color.secondary)
                                .frame(width: 55, height: 55))
                            .padding(.trailing, 10.resp)
                        
                            
                            
                    }
                }
                .padding(.horizontal, 10.resp)
                .frame(height: 80.resp)
                .background(.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 16.resp))
                .overlay {
                    RoundedRectangle(cornerRadius: 16.resp)
                        .stroke(.white, style: .init(lineWidth: 1.0))
                }
            }
            .padding(15.resp)
        }
        .frame(maxWidth: 280, maxHeight: 320)
        .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 0)
        .rotationEffect(
            cardsAnimated ? .degrees(currentRotation) : .zero,
            anchor: isTopCard ? .bottom : .center
        )
        .scaleEffect(cardsAnimated ? scale : 1.0)
        .transformEffect(
            CGAffineTransform(
                translationX: currentTranslation.x,
                y: currentTranslation.y
            )
        )
        .gesture(cardSwipeGesture)
    }
    
    private var currentTranslation: CGPoint {
        CGPoint(
            x: translation.x + dragX,
            y: translation.y
        )
    }
    
    private var currentRotation: CGFloat {
        let dragRotation = isTopCard ? (dragX / 12) : 0
        return rotateDegree + dragRotation
    }
    
    private var cardSwipeGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                guard isTopCard else { return }
                dragX = clampedSwipeX(value.translation.width)
            }
            .onEnded { value in
                guard isTopCard else { return }
                let threshold: CGFloat = 110
                let swipedEnough = abs(value.translation.width) > threshold
                
                guard swipedEnough else {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                        dragX = 0
                    }
                    return
                }
                
                let direction: SwipeDirection = value.translation.width > 0 ? .right : .left
                let exitX: CGFloat = direction == .right ? 600 : -600
                
                withAnimation(.easeIn(duration: 0.2)) {
                    dragX = exitX
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    dragX = 0
                    onSwipe(direction)
                }
            }
    }
    
    private func clampedSwipeX(_ value: CGFloat) -> CGFloat {
        let maxDrag: CGFloat = 150
        return min(max(value, -maxDrag), maxDrag)
    }
}
