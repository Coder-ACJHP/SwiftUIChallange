//
//  AlertItem.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 27.02.2026.
//

import Foundation

struct AlertItem: Identifiable {
    let id: UUID = UUID()
    let title: String
    let message: String
    let buttonTitle: String
}
