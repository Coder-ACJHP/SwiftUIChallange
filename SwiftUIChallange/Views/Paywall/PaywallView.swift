//
//  PaywallView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 27.02.2026.
//

import SwiftUI
import UIKit

@MainActor
struct PaywallView: View {
    
    private let packages: [Package] = [
        Package(
            title: "Weekly",
            duration: .weekly,
            price: 9.9,
            badge: nil
        ),
        Package(
            title: "Monthly",
            duration: .monthly,
            price: 19.99,
            badge: .bestseller
        ),
        Package(
            title: "Annual",
            duration: .annual,
            price: 99.99,
            badge: .bestPrice
        )
    ]
    
    @Environment(\.dismiss) var dismiss
    @State private var isLoading: Bool = false
    @State private var activeAlert: AlertItem?
    @State private var selectedPackage: Package?
    private let isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        ZStack {
            // Background Image
            GeometryReader { proxy in
                Image(.imagePaywallBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .clipped()
                
                // Other contents
                VStack {
                    dismissButton
                    Spacer()
                    titleLabel
                    productCardsList
                        .padding(.top, 20.resp)
                    purchaseButton
                        .padding(.bottom, 40.resp)
                }
                .padding(20.resp)
                .frame(
                    maxWidth: isPad ? 400.resp : proxy.size.width
                ) // For ipad
            }
            .ignoresSafeArea()
        }
        .overlay {
            if isLoading {
                ProgressView("Lütfen bekleyin...")
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
                    .allowsHitTesting(false)
            }
        }
        .onAppear {
            if selectedPackage == nil {
                selectedPackage = packages.first { $0.badge == .bestseller } ?? packages.first
            }
        }
        .alert(item: $activeAlert) { item in
            Alert(
                title: Text(item.title),
                message: Text(item.message),
                dismissButton: .default(Text(item.buttonTitle))
            )
        }
    }
    
    private var dismissButton: some View {
        HStack {
            Spacer()
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(Color(.label))
                    .padding(5)
                    .frame(width: 30, height: 30)
                
            }
            .padding(.trailing, isPad ? 0 : 10)
            .padding(.top, isPad ? 0 : 30.resp)
        }
    }

    private var titleLabel: some View {
        Text("Track live location & history of loved ones")
            .multilineTextAlignment(.center)
            .font(.system(size: 24, weight: .semibold))
            .lineSpacing(5)
    }
    
    private var productCardsList: some View {
        HStack(spacing: 16.resp) {
            ForEach(packages) { package in
                ProductCardView(
                    package: package,
                    isSelected: selectedPackage == package
                ) { tappedPackage in
                    selectedPackage = tappedPackage
                }
            }
        }
    }
    
    private var purchaseButton: some View {
        Button {
            Task {
                try? await handlePurchase()
            }
        }
        label: {
            Text("Purchase")
                .foregroundStyle(Color.white)
                .font(.system(size: 16.resp, weight: .medium))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56.resp)
        .background(Color.hexColor(hex: "#0A6DFF"))
        .cornerRadius(16.resp)
        .padding(.top, 20)
        .shadow(
            color: Color.hexColor(hex: "#0A6DFF").opacity(0.3),
            radius: 8, x: 0, y: 16
        )
    }
    
    private func handlePurchase() async throws {
        isLoading = true
        defer { isLoading = false }
        
        try? await Task.sleep(for: .seconds(2))
        
        // Set error item to show alert
        activeAlert = AlertItem(
            title: "An Error Occurred",
            message: "Unexpected error happened please try again later.",
            buttonTitle: "Dismiss"
        )
    }
}

#Preview {
    PaywallView()
}
