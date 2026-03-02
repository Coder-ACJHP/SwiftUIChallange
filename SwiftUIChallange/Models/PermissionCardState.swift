//
//  PermissionCardState.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import Foundation

enum PermissionCardState: CaseIterable {
    case granted, denied, notDetermined, unknown
    
    var color: String {
        switch self {
            case .granted:
                return "#12B76A"
            case .denied:
                return "#F04438"
            case .unknown, .notDetermined:
                return "#E0ECFF"
        }
    }
}
