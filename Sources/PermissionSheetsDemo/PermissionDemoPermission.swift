import PermissionSheets

enum PermissionDemoPermission: String, CaseIterable, Identifiable {
    case notification
    case location
    case camera
    case photos

    var id: Self { self }

    var type: PermissionType {
        switch self {
        case .notification:
            .notification
        case .location:
            .location
        case .camera:
            .camera
        case .photos:
            .photos
        }
    }

    var title: String {
        switch self {
        case .notification:
            "Notifications"
        case .location:
            "Location"
        case .camera:
            "Camera"
        case .photos:
            "Photos"
        }
    }

    var symbolName: String {
        switch self {
        case .notification:
            "bell.badge"
        case .location:
            "location"
        case .camera:
            "camera"
        case .photos:
            "photo.on.rectangle"
        }
    }
}
