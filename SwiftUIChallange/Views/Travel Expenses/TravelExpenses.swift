//
//  TravelExpenses.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 3.03.2026.
//

import SwiftUI

struct TravelExpenses: View {
        
    @State private var cardList: [Card] = [
        Card(
            imageName: "image_1",
            title: "Mount Aconcague",
            subtitle: "Aconcague is the highest peak in South America.",
            isLiked: true,
            isSaved: true,
            rotateDegree: 0,
            translation: .zero
        ),
        Card(
            imageName: "image_2",
            title: "Mount Aconcague",
            subtitle: "Aconcague is the highest peak in South America.",
            isLiked: false,
            isSaved: false,
            rotateDegree: 10,
            translation: CGPoint(x: 90, y: -20),
            scale: 0.8
        ),
        Card(
            imageName: "image_0",
            title: "Mount Aconcague",
            subtitle: "Aconcague is the highest peak in South America.",
            isLiked: false,
            isSaved: false,
            rotateDegree: -10,
            translation: CGPoint(x: -90, y: -20),
            scale: 0.8
        )
    ]
    @State private var cardsAnimated = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 30.resp) {
                    // Title
                    Text("MAKE YOUR EXPENSES, USED FOR TRAVEL")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 30.resp, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.horizontal, 40.resp)
                    // Cards
                    cardsView
                    // Labels
                    brandLabelsView
                    
                    // Title 2
                    Text("SOME\nEXPERIENCES FROM CLIMBERS")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 30.resp, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .padding(.horizontal, 40.resp)
                    
                    // Bottom card view
                    bottomCardView
                }
            }
            .scrollIndicators(.hidden)
        }
        .task {
            try? await Task.sleep(for: .seconds(0.25))
            withAnimation(.smooth) {
                self.cardsAnimated.toggle()
            }
        }
    }
    
    private var cardsView: some View {
        ZStack {
            ForEach(cardList.indices, id: \.self) { index in
                let style = cardStyle(for: index)
                
                TravelCardView(
                    card: $cardList[index],
                    cardsAnimated: cardsAnimated,
                    rotateDegree: style.rotateDegree,
                    translation: style.translation,
                    scale: style.scale,
                    isTopCard: index == 0
                ) { _ in
                    moveToNextCard()
                }
                .zIndex(style.zIndex)
            }
        }
    }
    
    private func moveToNextCard() {
        guard !cardList.isEmpty else { return }
        withAnimation(.smooth) {
            let currentCard = cardList.removeFirst()
            cardList.append(currentCard)
        }
    }
    
    private func cardStyle(for index: Int) -> (rotateDegree: CGFloat, translation: CGPoint, scale: CGFloat, zIndex: Double) {
        switch index {
        case 0:
            return (0, .zero, 1.0, 3)
        case 1:
            return (10, CGPoint(x: 90, y: -20), 0.8, 2)
        default:
            return (-10, CGPoint(x: -90, y: -20), 0.8, 1)
        }
    }
    
    private var brandLabelsView: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                VStack(spacing: 10.resp) {
                    HStack(spacing: 20.resp) {
                        Text("💱 Lattice")
                            .font(Font.title.bold())
                            .foregroundStyle(Color(.secondaryLabel))
                            .id(0)
                        
                        Text("™️ moday.com")
                            .font(Font.title.bold())
                            .foregroundStyle(Color(.secondaryLabel))
                            .id(1)
                        
                        Text("🔛 Contentifier")
                            .font(Font.title.bold())
                            .foregroundStyle(Color(.secondaryLabel))
                            .id(2)
                    }
                    
                    HStack(spacing: 20.resp) {
                        Text("🔜 Productboard")
                            .font(Font.title.bold())
                            .foregroundStyle(Color(.secondaryLabel))
                            .id(3)
                        
                        Text("©️ customer.io")
                            .font(Font.title.bold())
                            .foregroundStyle(Color(.secondaryLabel))
                            .id(4)
                    }
                }
                .task {
                    withAnimation(.smooth) {
                        proxy.scrollTo(2, anchor: .center)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.vertical)
    }
    
    private var bottomCardView: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .renderingMode(.template)
                    .padding(12.resp)
                    .frame(width: 50.resp, height: 50.resp)
                    .foregroundColor(.white)
                    .background(Color(.gray))
                    .clipShape(Circle())
                                
                VStack(alignment: .leading, spacing: 5.resp) {
                    Text("Layabgihan")
                        .font(.system(size: 20.resp, weight: .semibold))
                        .foregroundStyle(Color(.label))
                    Text("Travellers")
                        .padding(.horizontal, 10.resp)
                        .padding(.vertical, 3.resp)
                        .font(.system(size: 13.resp, weight: .regular))
                        .foregroundStyle(Color(.red))
                        .background(Color.yellow)
                        .clipShape(.capsule)
                }
                .padding(.leading, 10.resp)
                
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .renderingMode(.template)
                        .foregroundStyle(.yellow)
                    Text("4.5")
                }
            }
            Text("This is probably the most used way to create corner radius. Nothing special about it. But be cautious, in SwiftUI")
                .foregroundStyle(Color(.secondaryLabel))
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineSpacing(3.resp)
                .padding(.top, 10.resp)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .cornerRadius(20.resp, corners: [.topLeft, .topRight])
        .padding(.horizontal)
    }
}

#Preview {
    TravelExpenses()
}
