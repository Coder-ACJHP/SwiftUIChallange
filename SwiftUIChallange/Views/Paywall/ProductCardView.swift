//
//  ProductCardView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 27.02.2026.
//

import SwiftUI

struct ProductCardView: View {
    
    let package: Package
    let isSelected: Bool
    let action: (_ package: Package) -> Void
    
    var body: some View {
        Button {
            withAnimation { action(package) }
        } label: {
            VStack(spacing: -9.resp) {
                // Badge
                createBadgeView(package: package)
                    .zIndex(1)
                // Card
                VStack {
                    Spacer()
                    Text(package.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 4.resp)
                    
                    createInnerCardView(package: package)
                }
                .frame(height: 174.resp)
                .background(Color.hexColor(hex: "#0A6DFF"))
                .clipShape(RoundedRectangle(cornerRadius: 18.resp))
            }
        }
    }
    
    @ViewBuilder
    private func createBadgeView(package: Package) -> some View {
        HStack {
            Image(systemName: package.badge?.iconName ?? "")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.hexColor(hex: "#FEC84B"))
                .frame(width: 16.resp, height: 16.resp)
            Text(package.badge?.title ?? "")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.white)
        }
        .padding(.vertical, 4.resp)
        .padding(.horizontal, 8.resp)
        .background(Color.hexColor(hex: package.badge?.backgroundColor ?? ""))
        .clipShape(Capsule())
        .opacity(package.badge != nil ? 1.0 : 0.0)
    }
    
    @ViewBuilder
    private func createInnerCardView(package: Package) -> some View {
        VStack {
            VStack(spacing: 5.resp) {
                Text(package.price, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color(.label))
                
                Text("\(package.duration.rawValue) days")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(.secondaryLabel))
            }
            
            Spacer()
            
            VStack(spacing: 5.resp) {
                Text(package.pricePerDay, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color(.label))
                
                Text("per day")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(.secondaryLabel))
            }
            
            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.hexColor(hex: "#0A6DFF"))
                        .frame(height: 24.resp)
                        
                    Circle()
                        .fill(Color.white)
                        .frame(height: 10.resp)
                } else {
                    Circle()
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color(.separator))
                        .frame(height: 24.resp)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .frame(height: 132.resp)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18.resp))
        .overlay(
            RoundedRectangle(cornerRadius: 18.resp)
                .stroke(Color(.separator), lineWidth: 2.resp)
        )
    }
}

//#Preview {
//    let package = Package(title: "Monthly", duration: .monthly, price: 99.99, badge: .bestseller)
//    ProductCardView(package: package, isSelected: true) { _ in }
//}
