//
//  Package.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 27.02.2026.
//

import Foundation

enum Duration: Int {
    case weekly, monthly, annual
    
    var rawValue: Int {
        switch self {
            case .weekly:
                return 7
            case .monthly:
                return 30
            case .annual:
                return 365
        }
    }
}

enum Badge: String, CaseIterable {
    case bestseller, bestPrice
    
    var title: String {
        switch self {
            case .bestseller:
                return "Bestseller"
            case .bestPrice:
                return "Best price"
        }
    }
    
    var iconName: String {
        switch self {
            case .bestseller:
                return "star.fill"
            case .bestPrice:
                return "flame.fill"
        }
    }
    
    var backgroundColor: String {
        switch self {
            case .bestseller:
                return "#FF7914"
            case .bestPrice:
                return "#F04438"
        }
    }
}

struct Package: Identifiable, Equatable {
    let id: UUID = UUID()
    let title: String
    let duration: Duration
    let price: Double
    let badge: Badge?
    var pricePerDay: Double {
        price / Double(duration.rawValue)
    }

    static func == (lhs: Package, rhs: Package) -> Bool {
        lhs.id == rhs.id
    }
}
