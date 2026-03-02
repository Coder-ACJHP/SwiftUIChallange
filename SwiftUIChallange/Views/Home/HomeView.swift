//
//  HomeView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 27.02.2026.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    enum FullScreenDestination: Identifiable, CaseIterable {
        case paywall
        
        var id: Self { self }
    }
    
    enum SheetDestination: Identifiable, CaseIterable {
        case settings
        case addNewPlace
        
        var id: Self { self }
    }
    
    @State private var activeSheet: SheetDestination?
    @State private var activeFullScreen: FullScreenDestination?
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10.resp) {
                createButton(
                    title: "Paywall",
                    presentStyle: "(fullScreenCover)",
                    color: .yellow
                ) { activeFullScreen = .paywall }
                
                createButton(
                    title: "Full Screen Popup",
                    presentStyle: "(fullScreenCover)",
                    color: .brown
                ) {
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) { isPresented = true }
                }
                
                createButton(
                    title: "Settings",
                    presentStyle: "(sheet)",
                    color: .purple
                ) { activeSheet = .settings }
                
                createButton(
                    title: "Add New Place",
                    presentStyle: "(sheet)",
                    color: .red
                ) { activeSheet = .addNewPlace }
                
                Spacer()
            }
            .padding(.top, 10.resp)
            .padding(.horizontal, 16.resp)
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("Home")
            // PopupView
            .fullScreenCover(isPresented: $isPresented) {
                PopupView(selectionStateChanged: { country in
                    guard let country else { return }
                    print("Selected country: \(country.name)")
                })
                // Remove background and make it clear visible
                .presentationBackground(.clear)
            }
            // Paywall from bottom to top (UIKit like)
            .fullScreenCover(item: $activeFullScreen) { screen in
                switch screen {
                    case .paywall:
                        PaywallView()
                }
            }
        }
        .sheet(item: $activeSheet) { sheetDest in
            switch sheetDest {
                case .settings:
                    SettingsView()
                        .presentationDetents([.large])
                case .addNewPlace:
                    AddPlaceView(place: Place())
                        .presentationDetents([.large])
            }
        }
    }
    
    @ViewBuilder
    private func createButton(
        title: String,
        presentStyle: String,
        color: Color = .accentColor,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            Text(
                createAttributedString(
                    firstPart: title,
                    secondPart: presentStyle
                )
            )
            .frame(maxWidth: .infinity)
            .frame(height: 56.resp)
            .background(color.gradient)
            .cornerRadius(16.resp)
        }
    }
    
    private func createAttributedString(firstPart: String, secondPart: String) -> AttributedString {
        var partOne = AttributedString(firstPart)
        partOne.font = .system(size: 18.resp, weight: .bold)
        partOne.foregroundColor = Color.white
        
        var partTwo = AttributedString(secondPart)
        partTwo.font = .system(size: 14.resp, weight: .regular)
        partTwo.foregroundColor = Color.white.opacity(0.8)
        return partOne + " " + partTwo
    }
}

#Preview {
    HomeView()
}
