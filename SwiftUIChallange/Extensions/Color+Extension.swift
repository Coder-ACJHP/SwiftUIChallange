//
//  Color+Extension.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import Foundation
import SwiftUI

extension Color {
    static func hexColor(hex: String) -> Color {
        // Normalize input: trim whitespace and remove leading '#'
        var cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleaned.hasPrefix("#") { cleaned.removeFirst() }
        cleaned = cleaned.uppercased()

        // Helper to expand shorthand like RGB -> RRGGBB and RGBA -> RRGGBBAA
        func expandShorthand(_ s: String) -> String {
            if s.count == 3 || s.count == 4 {
                return s.map { String(repeating: $0, count: 2) }.joined()
            }
            return s
        }

        // After expansion we expect 6 (RRGGBB) or 8 (RRGGBBAA) characters
        var hexString = expandShorthand(cleaned)

        func colorFromRRGGBBAA(_ s: String) -> Color? {
            let scanner = Scanner(string: s)
            var hexNumber: UInt64 = 0
            guard scanner.scanHexInt64(&hexNumber) else { return nil }

            switch s.count {
            case 6: // RRGGBB
                let r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
                let g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
                let b = Double(hexNumber & 0x0000FF) / 255.0
                return Color(red: r, green: g, blue: b)
            case 8: // RRGGBBAA
                let r = Double((hexNumber & 0xFF000000) >> 24) / 255.0
                let g = Double((hexNumber & 0x00FF0000) >> 16) / 255.0
                let b = Double((hexNumber & 0x0000FF00) >> 8) / 255.0
                let a = Double(hexNumber & 0x000000FF) / 255.0
                return Color(red: r, green: g, blue: b, opacity: a)
            default:
                return nil
            }
        }

        // Try as RRGGBB or RRGGBBAA first
        if let color = colorFromRRGGBBAA(hexString) {
            return color
        }

        // If 8 characters and failed, try as AARRGGBB (some formats use ARGB)
        if hexString.count == 8 {
            let aarrggbb = hexString
            let aa = aarrggbb.prefix(2)
            let rrggbb = aarrggbb.dropFirst(2)
            let converted = rrggbb + aa
            if let color = colorFromRRGGBBAA(String(converted)) {
                return color
            }
        }

        // Invalid input; return a default to avoid crashes
        return .clear
    }
}
