//
//  PopupView.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 2.03.2026.
//

import SwiftUI

struct PopupView: View {
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    @StateObject var viewModel = PopupViewModel()
    @State private var selectionAnimated: Bool = false
    public var selectionStateChanged: ((_ selectedCountry: Country?) -> Void)?
    
    var body: some View {
        ZStack {
            if viewModel.showBackground {
                Rectangle()
                    .fill(Color.hexColor(hex: "#0A6DFF").opacity(0.5))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea(edges: .all)
                    .transition(.opacity)
                    .onTapGesture { dismissAnimated() }
            }
            
            if viewModel.showPopup {
                popupView
                    .transition(.asymmetric(
                        insertion: .push(from: .bottom).combined(with: .opacity),
                        removal: .push(from: .top).combined(with: .opacity)))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.keyboard) // Ignore keyboard safe area changes
        .background(Color.clear)
        .onAppear {
            withAnimation(.linear(duration: 0.25)) {
                viewModel.showBackground = true
            }
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8).delay(0.15)) {
                viewModel.showPopup = true
            }
            withAnimation(.easeInOut.delay(1.0)) {
                viewModel.selectedCountry = viewModel.filteredCountries[11]
            }
        }
    }
    
    private func dismissAnimated() {
        withAnimation(.easeIn(duration: 0.2)) {
            viewModel.showPopup = false
        }
        withAnimation(.easeIn(duration: 0.2).delay(0.1)) {
            viewModel.showBackground = false
        }
        Task {
            try? await Task.sleep(for: .seconds(0.35))
            dismiss()
        }
    }
    
    private var popupView: some View {
        VStack {
            Text("Change Your Country")
                .font(.system(size: 22.resp, weight: .bold))
                .foregroundStyle(Color(.label))
                .padding(10.resp)
                .padding(.top, 20.resp)
            Divider()
            TextField("🔍 Search", text: $viewModel.searchText)
                .textFieldStyle(.automatic)
                .keyboardType(.default)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .disabled(viewModel.filteredCountries.isEmpty)
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(.capsule)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .padding(.horizontal)
                .focused($isFocused)
            Divider()
            
            countryListView
            
            saveUpdateButton
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(20.resp)
        .padding(.horizontal, 20.resp)
        .padding(.vertical, viewModel.screenSize.height * 0.15)
        .toolbar {
            // Klavyenin üstündeki grup
            ToolbarItemGroup(placement: .keyboard) {
                Spacer() // Butonu en sağa iter
                Button("Done") { isFocused = false }
                    .fontWeight(.bold)
            }
        }
    }
    
    private var countryListView: some View {
        ScrollViewReader { proxy in
            List(viewModel.filteredCountries, id: \.id) { country in
                countryListRow(for: country)
                    .id(country.id)
                    .onTapGesture {
                        viewModel.selectedCountry = country
                    }
            }
            .listStyle(.plain)
            .padding(.horizontal)
            .onChange(of: viewModel.selectedCountry) { newValue in
                if !selectionAnimated { // Animate once
                    guard let id = newValue?.id else { return }
                    withAnimation {
                        proxy.scrollTo(id, anchor: .center)
                        selectionAnimated = true
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func countryListRow(for country: Country) -> some View {
        HStack(spacing: 5.resp) {
            Text(country.flagCode)
                .font(.title2)
                .foregroundStyle(Color(.label))
            Text(country.name)
                .font(.body)
                .foregroundStyle(Color(.label))
            Spacer()
            Image(systemName: "checkmark")
                .renderingMode(.template)
                .resizable()
                .frame(width: 15.resp, height: 15.resp)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.hexColor(hex: "#0A6DFF"))
                .padding(.horizontal)
                .opacity(viewModel.selectedCountry?.id == country.id ? 1.0 : 0)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
    }
    
    private var saveUpdateButton: some View {
        Button {
            dismiss()
            selectionStateChanged?(viewModel.selectedCountry)
        } label: {
            Text("Save")
                .foregroundStyle(Color.white)
                .font(.system(size: 16.resp, weight: .medium))
                .frame(maxWidth: .infinity)
                .frame(height: 56.resp)
                .background(Color.hexColor(hex: "#0A6DFF"))
                .clipShape(.capsule)
        }
        .contentShape(Rectangle())
        .padding(.horizontal)
        .padding(.bottom, 20.resp)
        .shadow(
            color: Color.hexColor(hex: "#0A6DFF").opacity(0.2),
            radius: 6, x: 0, y: 12
        )
    }
}

#Preview {
    PopupView()
}
