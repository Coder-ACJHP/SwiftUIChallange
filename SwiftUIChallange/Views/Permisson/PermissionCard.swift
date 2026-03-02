//
//  PermissionCard.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import SwiftUI

struct PermissionCard: View {
    
    let item: PermissionCardItem
    let onAction: () -> Void
    
    var body: some View {
        VStack() {
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: item.iconName)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.hexColor(hex: item.iconColor))
                    Text(item.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(.label))
                    
                    Spacer()
                }
                                
                Text(item.message)
                    .foregroundStyle(Color(.secondaryLabel))
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineSpacing(5)
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 16)
            .background(Color(.secondarySystemBackground))
            .clipShape(
                RoundedRectangle(cornerSize: .init(width: 16, height: 16))
            )
            .padding([.top, .leading, .trailing], 1)
            
            HStack {
                Button(action: onAction) {
                    switch item.state {
                        case .granted:
                            Image(systemName: "checkmark.circle.fill")
                            Text("Access Provided")
                        case .denied:
                            Image(systemName: "exclamationmark.circle.fill")
                            Text("Access Required")
                        case .unknown, .notDetermined:
                            EmptyView()
                            Text(item.buttonTitle)
                    }
                    
                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 13, height: 13)
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(item.state != .notDetermined ? .white : Color.hexColor(hex: "#0A6DFF"))
            }
            .padding(.vertical, 2)
            .padding(.bottom, 8)
        }
        .background(Color.hexColor(hex: item.state.color))
        .clipShape(
            RoundedRectangle(cornerSize: .init(width: 16, height: 16))
        )
    }
}

