//
//  MeshGradientButton.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 4.03.2026.
//

import SwiftUI

// MARK: - MeshGradient Animated Button
// 120 FPS ProMotion destekli, profesyonel renk animasyonu

@available(iOS 18.0, *)
struct MeshGradientButton: View {
    
    // MARK: - Mode
    enum Mode {
        /// Tek düz renk — mesh animasyonu yok
        case solid(color: Color)
        /// Belirli bir paletle mesh gradient animasyonu
        case gradient(palette: ColorPalette)
        /// Her butona basışta otomatik palet geçişi
        case cycling
    }
    
    // MARK: - Color Palette
    enum ColorPalette: CaseIterable {
        case auroraBorealis
        case sunsetFire
        case oceanDeep
        case cottonCandy
        case neonCyber
        case volcanicAsh
        case arcticFrost
        case goldenHour
        case midnightBloom
        case tropicalParadise
        
        var colors: [Color] {
            switch self {
            case .auroraBorealis:
                return [.cyan, .mint, .teal, .blue, .indigo, .purple, .cyan, .mint, .teal]
                
            case .sunsetFire:
                return [.orange, .red, .pink, .purple, .orange, .yellow, .red, .pink, .orange]
                
            case .oceanDeep:
                return [.blue, .cyan, .teal, .green, .blue, .indigo, .cyan, .blue, .teal]
                
            case .cottonCandy:
                return [
                    Color(red: 1.0,  green: 0.71, blue: 0.86), // şeker pembesi
                    Color(red: 0.78, green: 0.88, blue: 1.0),  // bebek mavisi
                    Color(red: 0.95, green: 0.82, blue: 1.0),  // lavanta
                    Color(red: 1.0,  green: 0.85, blue: 0.93),
                    Color(red: 0.85, green: 0.95, blue: 1.0),
                    Color(red: 1.0,  green: 0.75, blue: 0.88),
                    Color(red: 0.90, green: 0.80, blue: 1.0),
                    Color(red: 1.0,  green: 0.82, blue: 0.90),
                    Color(red: 0.82, green: 0.90, blue: 1.0),
                ]
                
            case .neonCyber:
                return [
                    Color(red: 0.0,  green: 1.0,  blue: 0.84), // neon yeşil
                    Color(red: 1.0,  green: 0.07, blue: 0.58), // neon pembe
                    Color(red: 0.44, green: 0.0,  blue: 1.0),  // neon mor
                    Color(red: 0.0,  green: 0.85, blue: 1.0),  // elektrik mavi
                    Color(red: 1.0,  green: 0.22, blue: 0.56),
                    Color(red: 0.0,  green: 1.0,  blue: 0.60),
                    Color(red: 0.58, green: 0.0,  blue: 1.0),
                    Color(red: 0.0,  green: 0.75, blue: 1.0),
                    Color(red: 1.0,  green: 0.0,  blue: 0.75),
                ]
                
            case .volcanicAsh:
                return [
                    Color(red: 0.55, green: 0.10, blue: 0.02), // koyu kızıl
                    Color(red: 0.80, green: 0.25, blue: 0.05), // lav
                    Color(red: 0.30, green: 0.30, blue: 0.32), // kül gri
                    Color(red: 0.70, green: 0.15, blue: 0.02),
                    Color(red: 0.20, green: 0.20, blue: 0.22),
                    Color(red: 0.90, green: 0.40, blue: 0.10), // kor ateşi
                    Color(red: 0.40, green: 0.08, blue: 0.02),
                    Color(red: 0.60, green: 0.20, blue: 0.04),
                    Color(red: 0.25, green: 0.25, blue: 0.28),
                ]
                
            case .arcticFrost:
                return [
                    Color(red: 0.85, green: 0.95, blue: 1.0),  // buz mavisi
                    Color(red: 0.95, green: 0.98, blue: 1.0),  // kar beyazı
                    Color(red: 0.70, green: 0.88, blue: 0.98), // açık mavi
                    Color(red: 0.90, green: 0.96, blue: 1.0),
                    Color(red: 0.78, green: 0.92, blue: 0.99),
                    Color(red: 0.88, green: 0.97, blue: 1.0),
                    Color(red: 0.72, green: 0.85, blue: 0.96),
                    Color(red: 0.93, green: 0.97, blue: 1.0),
                    Color(red: 0.80, green: 0.93, blue: 1.0),
                ]
                
            case .goldenHour:
                return [
                    Color(red: 1.0,  green: 0.80, blue: 0.20), // altın
                    Color(red: 1.0,  green: 0.55, blue: 0.10), // turuncu
                    Color(red: 0.95, green: 0.75, blue: 0.30), // sarı
                    Color(red: 1.0,  green: 0.65, blue: 0.15),
                    Color(red: 0.98, green: 0.82, blue: 0.35),
                    Color(red: 1.0,  green: 0.48, blue: 0.08),
                    Color(red: 0.92, green: 0.70, blue: 0.22),
                    Color(red: 1.0,  green: 0.75, blue: 0.25),
                    Color(red: 0.96, green: 0.58, blue: 0.12),
                ]
                
            case .midnightBloom:
                return [
                    Color(red: 0.10, green: 0.02, blue: 0.30), // gece moru
                    Color(red: 0.28, green: 0.05, blue: 0.50), // derin mor
                    Color(red: 0.05, green: 0.10, blue: 0.40), // gece mavisi
                    Color(red: 0.55, green: 0.10, blue: 0.60), // magenta
                    Color(red: 0.15, green: 0.05, blue: 0.45),
                    Color(red: 0.35, green: 0.08, blue: 0.55),
                    Color(red: 0.08, green: 0.02, blue: 0.35),
                    Color(red: 0.45, green: 0.08, blue: 0.58),
                    Color(red: 0.20, green: 0.04, blue: 0.42),
                ]
                
            case .tropicalParadise:
                return [
                    Color(red: 0.0,  green: 0.78, blue: 0.56), // turkuaz
                    Color(red: 0.20, green: 0.85, blue: 0.40), // tropikal yeşil
                    Color(red: 1.0,  green: 0.72, blue: 0.10), // mango sarı
                    Color(red: 0.0,  green: 0.82, blue: 0.65),
                    Color(red: 1.0,  green: 0.45, blue: 0.20), // papaya
                    Color(red: 0.10, green: 0.88, blue: 0.50),
                    Color(red: 1.0,  green: 0.60, blue: 0.15),
                    Color(red: 0.05, green: 0.80, blue: 0.58),
                    Color(red: 0.22, green: 0.82, blue: 0.35),
                ]
            }
        }
        
        /// Glow/shadow için temsil rengi
        var representativeColor: Color { colors.first ?? .blue }
        
        /// Sıradaki palette geç (döngüsel)
        var next: ColorPalette {
            let all = ColorPalette.allCases
            let idx = all.firstIndex(of: self) ?? 0
            return all[(idx + 1) % all.count]
        }
    }
    
    // MARK: - Configuration
    var title: String
    var mode: Mode
    var action: () -> Void
    
    // MARK: - Init
    init(
        title: String = "Başlat",
        mode: Mode = .cycling,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.mode = mode
        self.action = action
    }
    
    // MARK: - State
    @State private var phase: Double = 0
    @State private var isPressed: Bool = false
    @State private var displayLink: CADisplayLinkProxy? = nil
    @State private var currentPalette: ColorPalette = .auroraBorealis
    
    // MARK: - Computed: aktif renkler
    private var activePaletteColors: [Color] {
        switch mode {
        case .solid(let color):    return Array(repeating: color, count: 9)
        case .gradient(let p):     return p.colors
        case .cycling:             return currentPalette.colors
        }
    }
    
    // MARK: - Mesh Colors (phase ile canlanan renkler)
    private var meshColors: [Color] {
        if case .solid(let color) = mode {
            return Array(repeating: color, count: 9)
        }
        let colors = activePaletteColors
        return colors.enumerated().map { index, color in
            let offset = Double(index) * (Double.pi * 2.0 / Double(colors.count))
            let t = sin(phase + offset) * 0.5 + 0.5
            return color.opacity(0.6 + t * 0.4)
        }
    }
    
    // MARK: - Mesh Points (animasyonlu veya statik)
    private var meshPoints: [SIMD2<Float>] {
        if case .solid = mode {
            // Solid: sabit grid, CPU tasarrufu
            return [
                [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                [0.0, 1.0], [0.5, 1.0], [1.0, 1.0],
            ]
        }
        let t = Float(phase)
        return [
            // Row 0
            [0.0, 0.0],
            [0.5 + 0.05 * sin(t * 0.7), 0.0],
            [1.0, 0.0],
            // Row 1
            [0.0, 0.5 + 0.05 * cos(t * 0.9)],
            [0.5 + 0.08 * sin(t * 1.1), 0.5 + 0.08 * cos(t * 0.8)],
            [1.0, 0.5 + 0.05 * sin(t * 1.2)],
            // Row 2
            [0.0, 1.0],
            [0.5 + 0.05 * cos(t * 0.6), 1.0],
            [1.0, 1.0],
        ]
    }
    
    // MARK: - Glow rengi
    private var glowColor: Color {
        switch mode {
        case .solid(let c):    return c.opacity(0.5)
        case .gradient(let p): return p.representativeColor.opacity(0.5)
        case .cycling:         return currentPalette.representativeColor.opacity(0.5)
        }
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: handleTap) {
            ZStack {
                // MARK: MeshGradient Layer
                MeshGradient(
                    width: 3,
                    height: 3,
                    points: meshPoints,
                    colors: meshColors,
                    smoothsColors: true,
                    colorSpace: .perceptual
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                
                // MARK: Glass Overlay
                RoundedRectangle(cornerRadius: 16.resp, style: .continuous)
                    .fill(.ultraThinMaterial.opacity(0.15))
                
                // MARK: Inner Highlight
                RoundedRectangle(cornerRadius: 16.resp, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [.white.opacity(0.6), .white.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                
                // MARK: Label
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 16)
            }
        }
        .frame(height: 56.resp)
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .shadow(color: glowColor, radius: isPressed ? 8 : 20, x: 0, y: isPressed ? 4 : 10)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .onAppear {
            if case .cycling = mode { currentPalette = .auroraBorealis }
            guard case .solid = mode else { startDisplayLink(); return }
        }
        .onDisappear {
            stopDisplayLink()
        }
    }
    
    // MARK: - Tap Handler
    private func handleTap() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isPressed = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = false
            }
            if case .cycling = mode {
                withAnimation(.easeInOut(duration: 0.4)) {
                    currentPalette = currentPalette.next
                }
            }
            action()
        }
    }
    
    // MARK: - 120 FPS Display Link
    private func startDisplayLink() {
        let proxy = CADisplayLinkProxy { phase += 0.025 }
        self.displayLink = proxy
        proxy.start()
    }
    
    private func stopDisplayLink() {
        displayLink?.stop()
        displayLink = nil
    }
}

// MARK: - CADisplayLink Proxy (Swift Concurrency uyumlu)
@MainActor
final class CADisplayLinkProxy {
    private var displayLink: CADisplayLink?
    private let onFrame: () -> Void
    
    init(onFrame: @escaping () -> Void) {
        self.onFrame = onFrame
    }
    
    func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(tick))
        displayLink?.preferredFrameRateRange = CAFrameRateRange(
            minimum: 60,
            maximum: 120,
            preferred: 120
        )
        displayLink?.add(to: .main, forMode: .common)
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc
    private func tick() { onFrame() }
    
    deinit { displayLink?.invalidate() }
}
