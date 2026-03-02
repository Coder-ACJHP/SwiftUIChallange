//
//  PermissionCardItem.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import Foundation

struct PermissionCardItem: Identifiable {
    let id: UUID = UUID()
    let type: AppPermissionType
    let iconName: String
    let iconColor: String
    let title: String
    let message: String
    let buttonTitle: String
    var state: PermissionCardState
}
