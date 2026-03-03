//
//  Card.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 3.03.2026.
//

import Foundation

struct Card: Codable {
    var id: UUID = UUID()
    var imageName: String = "image_0"
    var title: String = "Mount Aconcagua"
    var subtitle: String = "Aconcagua is the heighest peak in America."
    var isLiked = false
    var isSaved = false
    var rotateDegree: CGFloat
    var translation: CGPoint
    var scale: CGFloat = 1.0
}
