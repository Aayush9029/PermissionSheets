import Foundation

public enum DisplayFrequency: Equatable, Sendable {
    case once
    case immediate
    case daily
    case weekly
    case monthly
    
    private var timeInterval: TimeInterval? {
        switch self {
        case .once:
            return 5 * 365 * 24 * 60 * 60 // every 5 years; if already not given, this is pretty much like asking once
        case .immediate:
            return nil
        case .daily:
            return 24 * 60 * 60
        case .weekly:
            return 7 * 24 * 60 * 60
        case .monthly:
            return 30 * 24 * 60 * 60
        }
    }

    public func shouldDisplay(for type: PermissionType) -> Bool {
        switch self {
        case .immediate:
            return true
        case .daily, .weekly, .monthly, .once:
            guard let lastPrompt = UserDefaults.standard.object(forKey: type.lastPromptKey) as? Date,
                  let interval = timeInterval else {
                return true
            }
            return Date().timeIntervalSince(lastPrompt) >= interval
        }
    }
}
