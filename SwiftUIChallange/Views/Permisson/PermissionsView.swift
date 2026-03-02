//
//  ContentView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import SwiftUI

struct PermissionsView: View {
    
    @State private var showSettings: Bool = false
    @StateObject private var permissionManager = PermissionManager.shared
    
    private var items: [PermissionCardItem] {
        permissionManager.items()
    }
    
    private var isContinueEnabled: Bool {
        permissionManager.allPermissionsDetermined
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title
                addTitleLabel
                // Permission cards
                addPermissionCards
                // Spacer
                Spacer()
                // Continue button
                addContinueButton
            }
            .padding(20)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
    
    private var addTitleLabel: some View {
        Text("To Keep you safe we need access to")
            .foregroundStyle(Color(.label))
            .font(.system(size: 24, weight: .semibold))
            .multilineTextAlignment(.leading)
            .frame(alignment: .leading)
            .lineSpacing(5)
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .padding(.top, 20.resp)
            .padding(.trailing, 100.resp)
    }
    
    private var addPermissionCards: some View {
        VStack(spacing: 20) {
            ForEach(items) { item in
                PermissionCard(item: item) {
                    permissionManager.request(item.type)
                }
            }
        }
    }
    
    private var addContinueButton: some View {
        Button { showSettings = true }
        label: {
            Text("Continue")
                .foregroundStyle(Color.white)
                .font(.system(size: 16.resp, weight: .medium))
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56.resp)
        .background(
            isContinueEnabled
            ? Color.hexColor(hex: "#0A6DFF")
            : Color(.systemGray4)
        )
        .cornerRadius(16.resp)
        .shadow(
            color: isContinueEnabled
            ? Color.hexColor(hex: "#0A6DFF").opacity(0.3)
            : Color(.systemGray4).opacity(0.3),
            radius: 8, x: 0, y: 16
        )
        .disabled(!isContinueEnabled)
    }
}

#Preview {
    PermissionsView()
}
