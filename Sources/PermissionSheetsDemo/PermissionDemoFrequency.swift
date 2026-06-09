import PermissionSheets

enum PermissionDemoFrequency: String, CaseIterable, Identifiable {
    case immediate
    case once
    case daily
    case weekly
    case monthly

    var id: Self { self }

    var displayFrequency: DisplayFrequency {
        switch self {
        case .immediate:
            .immediate
        case .once:
            .once
        case .daily:
            .daily
        case .weekly:
            .weekly
        case .monthly:
            .monthly
        }
    }

    var title: String {
        switch self {
        case .immediate:
            "Immediate"
        case .once:
            "Once"
        case .daily:
            "Daily"
        case .weekly:
            "Weekly"
        case .monthly:
            "Monthly"
        }
    }
}
