import Foundation

public enum PermissionType: String, Sendable {
    case notification
    case location
    case camera
    case photos
    
    var lastPromptKey: String {
        "lastPromptDate.\(self.rawValue)"
    }
}
