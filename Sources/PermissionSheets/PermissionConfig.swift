import Foundation

public struct PermissionConfig: Equatable, Sendable {
    public let displayFrequency: DisplayFrequency
    public let forceShow: Bool
    public let title: String?
    public let description: String?
    
    public init(
        displayFrequency: DisplayFrequency = .immediate,
        forceShow: Bool = false,
        title: String? = nil,
        description: String? = nil
    ) {
        self.displayFrequency = displayFrequency
        self.forceShow = forceShow
        self.title = title
        self.description = description
    }
}

public extension PermissionConfig {
    func getTitle(for type: PermissionType) -> String {
        if let customTitle = title {
            return customTitle
        }
        
        switch type {
        case .notification:
            return "Never Miss an Update"
        case .location:
            return "Enable Location Services"
        case .camera:
            return "Camera Access Required"
        case .photos:
            return "Access Your Photos"
        }
    }
    
    func getDescription(for type: PermissionType) -> String {
        if let customDescription = description {
            return customDescription
        }
        
        switch type {
        case .notification:
            return "Stay in the loop with notification updates"
        case .location:
            return "Allow location access to enhance your experience"
        case .camera:
            return "We need camera access to take photos and scan documents"
        case .photos:
            return "Access your photo library to save and share images"
        }
    }
}
