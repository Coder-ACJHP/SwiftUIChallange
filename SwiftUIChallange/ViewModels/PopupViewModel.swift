//
//  PopupViewModel.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 2.03.2026.
//

import Foundation
import Combine
import UIKit

@MainActor
class PopupViewModel: ObservableObject {
    
    @Published var selectedCountry: Country?
    @Published var searchText: String = ""
    @Published var showBackground = false
    @Published var showPopup = false
    
    let screenSize = UIScreen.main.bounds.size
    
    private let countryList: [Country] = [
        Country(id: UUID(), name: "Turkey", flagCode: "🇹🇷"),
        Country(id: UUID(), name: "Iraq", flagCode: "🇮🇶"),
        Country(id: UUID(), name: "Saudi Arabia", flagCode: "🇸🇦"),
        Country(id: UUID(), name: "United Arab Emirates", flagCode: "🇦🇪"),
        Country(id: UUID(), name: "Qatar", flagCode: "🇶🇦"),
        Country(id: UUID(), name: "Japan", flagCode: "🇯🇵"),
        Country(id: UUID(), name: "South Korea", flagCode: "🇰🇷"),
        Country(id: UUID(), name: "China", flagCode: "🇨🇳"),
        Country(id: UUID(), name: "Brazil", flagCode: "🇧🇷"),
        Country(id: UUID(), name: "Australia", flagCode: "🇦🇺"),
        
        Country(id: UUID(), name: "United States", flagCode: "🇺🇸"),
        Country(id: UUID(), name: "Canada", flagCode: "🇨🇦"),
        Country(id: UUID(), name: "United Kingdom", flagCode: "🇬🇧"),
        Country(id: UUID(), name: "Germany", flagCode: "🇩🇪"),
        Country(id: UUID(), name: "France", flagCode: "🇫🇷"),
        Country(id: UUID(), name: "Italy", flagCode: "🇮🇹"),
        Country(id: UUID(), name: "Spain", flagCode: "🇪🇸"),
        Country(id: UUID(), name: "Portugal", flagCode: "🇵🇹"),
        Country(id: UUID(), name: "Netherlands", flagCode: "🇳🇱"),
        Country(id: UUID(), name: "Belgium", flagCode: "🇧🇪"),

        Country(id: UUID(), name: "Switzerland", flagCode: "🇨🇭"),
        Country(id: UUID(), name: "Austria", flagCode: "🇦🇹"),
        Country(id: UUID(), name: "Sweden", flagCode: "🇸🇪"),
        Country(id: UUID(), name: "Norway", flagCode: "🇳🇴"),
        Country(id: UUID(), name: "Denmark", flagCode: "🇩🇰"),
        Country(id: UUID(), name: "Finland", flagCode: "🇫🇮"),
        Country(id: UUID(), name: "Ireland", flagCode: "🇮🇪"),
        Country(id: UUID(), name: "Poland", flagCode: "🇵🇱"),
        Country(id: UUID(), name: "Czech Republic", flagCode: "🇨🇿"),
        Country(id: UUID(), name: "Greece", flagCode: "🇬🇷")
    ]
    // Local search result
    var filteredCountries: [Country] {
        searchText == "" ? countryList : countryList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}
