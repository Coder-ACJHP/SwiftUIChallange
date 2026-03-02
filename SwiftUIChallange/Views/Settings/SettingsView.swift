//
//  SettingsView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var pushNotificationIsOn: Bool = false
    
    var body: some View {
        VStack {
            // Navbar components
            navbarView
            // Account section
            addUserAccountView
            // Sections
            SettingSectionsView(
                pushNotificationIsOn: $pushNotificationIsOn,
                onAction: { action in
                    switch action {
                        case .manageCircle:
                            print("Show manage circle view")
                        case .managePlaces:
                            print("Show manage places view")
                    }
                }
            )
            // Last button
            addLogoutButton
        }
        .background(Color(.systemBackground))
        .padding(20.resp)
        
        Spacer()
    }
    
    private var navbarView: some View {
        VStack(spacing: 20.resp) {
            RoundedRectangle(cornerRadius: 10.resp, style: .continuous)
                .frame(width: 40.resp, height: 5.resp)
                .foregroundStyle(Color(.separator))
            
            HStack(alignment: .center) {
                Button { dismiss() } label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 32.resp, height: 32.resp)
                        .foregroundStyle(Color(.secondarySystemBackground))
                        .overlay {
                            Image(systemName: "xmark")
                                .renderingMode(.template)
                                .resizable()
                                .foregroundStyle(Color(.secondaryLabel))
                                .padding(8.resp)
                        }
                }
                
                Text("Settings")
                    .foregroundStyle(Color(.label))
                    .font(.system(size: 24, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 32.resp)
                
                Spacer()
            }
        }
    }
    
    private var addUserAccountView: some View {
        Button { print("Show user detail view") } label: {
            HStack {
                Image(uiImage: UIImage(resource: .IMG_0590))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.resp, height: 44.resp)
                    .clipShape(RoundedRectangle(cornerRadius: 16.resp))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16.resp)
                            .stroke(.white, lineWidth: 2)
                    )
                    .shadow(
                        color: .black.opacity(0.1),
                        radius: 5, x: 0, y: 0
                    )
                
                VStack(spacing: 2) {
                    Text("John Doe")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(.label))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Account")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(.secondaryLabel))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 8.resp)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.hexColor(hex: "#0A6DFF"))
                    .padding(5)
                    .frame(width: 24.resp, height: 24.resp, alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .clipShape(RoundedRectangle(cornerRadius: 18.resp))
            .overlay(
                RoundedRectangle(cornerRadius: 18.resp)
                    .stroke(Color(.separator), lineWidth: 1)
            )
        }
    }
    
    private var addLogoutButton: some View {
        Button { print("Logout button tapped") }
        label: {
            Text("Log out")
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
}

#Preview {
    SettingsView()
}
