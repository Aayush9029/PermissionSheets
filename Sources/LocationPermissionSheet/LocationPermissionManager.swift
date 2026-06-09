import SwiftUI
import CoreLocation
import PermissionSheets

public class LocationPermissionManager: NSObject, PermissionManaging, CLLocationManagerDelegate {
    @Published public var shouldShowSheet = false
    public let config: PermissionConfig
    public let permissionType: PermissionType = .location
    
    private let locationManager = CLLocationManager()
    
    public init(config: PermissionConfig) {
        self.config = config
        super.init()
        locationManager.delegate = self
        checkPermission()
    }
    
    public func checkPermission() {
        let status = locationManager.authorizationStatus
        let shouldShow = config.forceShow ||
            (!Self.isAuthorized(status) &&
             config.displayFrequency.shouldDisplay(for: .location))
        
        shouldShowSheet = shouldShow
    }
    
    public func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        updateLastPromptDate()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkPermission()
    }

    private static func isAuthorized(_ status: CLAuthorizationStatus) -> Bool {
        #if os(macOS)
        status == .authorizedAlways
        #else
        status == .authorizedWhenInUse || status == .authorizedAlways
        #endif
    }
}
