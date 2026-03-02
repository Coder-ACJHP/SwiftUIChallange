//
//  PermissionManager.swift
//  SwiftUIChallange
//
//  Created by Coder ACJHP on 26.02.2026.
//

import Foundation
import CoreLocation
import UserNotifications
import CoreMotion
import Combine

final class PermissionManager: NSObject, ObservableObject {
    
    static let shared = PermissionManager()
    
    @Published private(set) var locationState: PermissionCardState = .unknown
    @Published private(set) var notificationState: PermissionCardState = .unknown
    @Published private(set) var motionState: PermissionCardState = .unknown
    
    private let locationManager = CLLocationManager()
    private let motionActivityManager = CMMotionActivityManager()
    private let motionQueue = OperationQueue()
    
    var allPermissionsDetermined: Bool {
        [locationState, notificationState, motionState].allSatisfy { state in
            switch state {
            case .granted, .denied:
                return true
            case .notDetermined, .unknown:
                return false
            }
        }
    }
    
    override private init() {
        super.init()
        locationManager.delegate = self
        refreshLocationStatus()
        refreshNotificationStatus()
        refreshMotionStatus()
    }
    
    func state(for type: AppPermissionType) -> PermissionCardState {
        switch type {
        case .location:
            return locationState
        case .notifications:
            return notificationState
        case .motion:
            return motionState
        }
    }
    
    func request(_ type: AppPermissionType) {
        switch type {
        case .location:
            requestLocation()
        case .notifications:
            requestNotifications()
        case .motion:
            requestMotion()
        }
    }
    
    func items() -> [PermissionCardItem] {
        [
            PermissionCardItem(
                type: .location,
                iconName: "checkmark.shield.fill",
                iconColor: "#405FF2",
                title: "Location",
                message: "Enable 'Always Allow' so your circle can see you even when the app is in the background",
                buttonTitle: "Enable Access",
                state: state(for: .location)
            ),
            PermissionCardItem(
                type: .notifications,
                iconName: "bell.fill",
                iconColor: "#9E28AC",
                title: "Notifications",
                message: "Get alerts when family members arrive or leave",
                buttonTitle: "Enable Access",
                state: state(for: .notifications)
            ),
            PermissionCardItem(
                type: .motion,
                iconName: "figure.run",
                iconColor: "#FF9820",
                title: "Activity/Motion",
                message: "Required to update your location only when you move, saving battery life.",
                buttonTitle: "Enable Access",
                state: state(for: .motion)
            )
        ]
    }
}

// MARK: - Location

extension PermissionManager: CLLocationManagerDelegate {
    
    private func refreshLocationStatus() {
        let status = locationManager.authorizationStatus
        locationState = mapLocationStatus(status)
    }
    
    private func mapLocationStatus(_ status: CLAuthorizationStatus) -> PermissionCardState {
        switch status {
        case .notDetermined:
            return .notDetermined
        case .authorizedAlways, .authorizedWhenInUse:
            return .granted
        case .denied, .restricted:
            return .denied
        @unknown default:
            return .denied
        }
    }
    
    private func requestLocation() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationState = .granted
        case .denied, .restricted:
            locationState = .denied
        @unknown default:
            locationState = .denied
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        locationState = mapLocationStatus(status)
    }
}

// MARK: - Notifications

private extension PermissionManager {
    
    func refreshNotificationStatus() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { [weak self] settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    self?.notificationState = .granted
                case .denied:
                    self?.notificationState = .denied
                case .notDetermined:
                    self?.notificationState = .notDetermined
                @unknown default:
                    self?.notificationState = .denied
                }
            }
        }
    }
    
    func requestNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            DispatchQueue.main.async {
                self?.notificationState = granted ? .granted : .denied
            }
        }
    }
}

// MARK: - Motion

private extension PermissionManager {
    
    func refreshMotionStatus() {
        
        switch CMMotionActivityManager.authorizationStatus() {
        case .notDetermined:
            motionState = .notDetermined
        case .authorized:
            motionState = .granted
        case .denied, .restricted:
            motionState = .denied
        @unknown default:
            motionState = .denied
        }
    }
    
    func requestMotion() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            motionState = .denied
            return
        }
        
        motionActivityManager.startActivityUpdates(to: motionQueue) { [weak self] _ in
            DispatchQueue.main.async {
                self?.refreshMotionStatus()
                self?.motionActivityManager.stopActivityUpdates()
            }
        }
    }
}

