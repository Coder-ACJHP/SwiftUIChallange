//
//  AddPlaceView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 27.02.2026.
//

import SwiftUI
import MapKit

struct AddPlaceView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var place: Place
    @State private var region: MKCoordinateRegion
    
    init(place: Place) {
        _place = State(initialValue: place)
        _region = State(initialValue: MKCoordinateRegion(
            center: place.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        ))
    }
    
    var body: some View {
        VStack(spacing: 20.resp) {
            // Navbar components
            navbarView
            // Mini map
            mapView
            // Name input
            circleNameTextField
            // Adress input
            circleAdressTextField
            // Icon pickerView
            iconPickerView
            // Radius slider
            radiusSliderView
            // Notification views
            notificationsView
            // Last button
            saveUpdateButton
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
                
                Text("Add New Place")
                    .foregroundStyle(Color(.label))
                    .font(.system(size: 24, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.trailing, 32.resp)
                
                Spacer()
            }
        }
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $region)
            .frame(height: 140.resp)
            .cornerRadius(16.resp)
    }
    
    private var circleNameTextField: some View {
        VStack(spacing: 0) {
            let isEmpty = place.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            if !isEmpty {
                Text("Circle Name")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color(.secondaryLabel))
                    .padding(.leading, 10.resp)
            }
            
            TextField(text: $place.name) {
                if isEmpty {
                    Text("Circle Name")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(.tertiaryLabel))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24.resp)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color(.label))
            .padding(.horizontal, 10.resp)
            
        }
        .frame(height: 56.resp)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16.resp)
    }
    
    private var circleAdressTextField: some View {
        VStack(spacing: 0) {
            let isEmpty = place.adress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            if !isEmpty {
                Text("Address")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color(.secondaryLabel))
                    .padding(.leading, 10.resp)
            }
            
            TextField(text: $place.adress) {
                if isEmpty {
                    Text("Address")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(.tertiaryLabel))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 24.resp)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color(.label))
            .padding(.horizontal, 10.resp)
            
        }
        .frame(height: 56.resp)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16.resp)
    }
    
    private var iconPickerView: some View {
        Button {} label: {
            HStack {
                Text("Icon")
                    .font(Font.system(size: 16.resp, weight: .medium))
                    .foregroundStyle(Color(.label))
                    .padding(.leading, 16.resp)
                Spacer()
                Image(systemName: place.iconName)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(Color(.secondaryLabel))
                    .padding(3.resp)
                    .frame(width: 24.resp, height: 24.resp)
                    .padding(.trailing, 16.resp)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56.resp)
        .clipShape(RoundedRectangle(cornerRadius: 16.resp))
        .overlay(
            RoundedRectangle(cornerRadius: 16.resp)
                .stroke(Color(.separator), lineWidth: 1)
        )
        
    }
    
    private var radiusSliderView: some View {
        VStack {
            Text("Radius")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color(.secondaryLabel))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Slider(value: $place.radius, in: 0...100, step: 1)
                .accentColor(Color.hexColor(hex: "#0A6DFF"))
        }
    }
    
    private var notificationsView: some View {
        VStack(spacing: 15.resp) {
            // Manage circle button
            Toggle("Notify on arrival", isOn: $place.arrivalNotification)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(.label))
            
            // Separator dashed line
            Divider()
                .frame(height: 1)
                .foregroundStyle(Color(.separator))
            // Manage places button
            Toggle("Notify on leaving", isOn: $place.leavingNotification)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(.label))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .overlay(
            RoundedRectangle(cornerRadius: 16.resp)
                .stroke(Color.hexColor(hex: "#EEEEEF"), lineWidth: 1)
        )
    }
    
    private var saveUpdateButton: some View {
        Button { print("Logout button tapped") }
        label: {
            Text("Save")
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
    AddPlaceView(place: Place())
}
