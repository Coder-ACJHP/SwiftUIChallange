//
//  SettingSectionsView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import SwiftUI

struct SettingSectionsView: View {
    
    enum SectionAction {
        case manageCircle, managePlaces
    }
    
    @Binding var pushNotificationIsOn: Bool
    public var onAction: (_ action: SectionAction) -> Void
    
    var body: some View {
        VStack {
            addSections
        }
    }
    
    private var addSections: some View {
        VStack {
            addCircleManagementSection
            
            addNotificationSection
            
        }
        .padding(.top, 20)
    }
    
    private var addCircleManagementSection: some View {
        VStack {
            Text("Circle Management")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color(.secondaryLabel))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                // Manage circle button
                Button { onAction(.manageCircle) } label: {
                    HStack {
                        Image(systemName: "person.2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color(.label))
                            .padding(3)
                            .frame(width: 24.resp, height: 24.resp, alignment: .center)
                        
                        Text("Circle Members")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color(.label))
                        
                        Spacer()
                    }
                    .padding(.bottom, 5)
                }
                
                // Separator dashed line
                Line()
                    .stroke(style: .init(dash: [10]))
                    .foregroundStyle(Color(.separator))
                    .frame(height: 1)
                
                // Manage places button
                Button { onAction(.managePlaces) } label: {
                    HStack {
                        Image(systemName: "map")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color(.label))
                            .padding(5)
                            .frame(width: 24.resp, height: 24.resp, alignment: .center)
                        
                        Text("Manage Places")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color(.label))
                        
                        Spacer()
                    }
                    .padding(.top, 5)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 16.resp)
                    .stroke(Color.hexColor(hex: "#EEEEEF"), lineWidth: 1)
            )
            .padding(.top, 8)
        }
    }
    
    private var addNotificationSection: some View {
        VStack {
            Text("Notifications")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color(.secondaryLabel))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 20)
            
            HStack {
                Image(systemName: "bell")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color(.label))
                    .padding(5)
                    .frame(width: 24.resp, height: 24.resp, alignment: .center)
                
                Toggle("Push Notifications", isOn: $pushNotificationIsOn)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color(.label))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .overlay(
                RoundedRectangle(cornerRadius: 16.resp)
                    .stroke(Color(.separator), lineWidth: 1)
            )
            .padding(.top, 12)
        }
    }
}
