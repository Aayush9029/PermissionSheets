import PermissionSheets

struct PermissionDemoModel: Equatable {
    var permission: PermissionDemoPermission = .notification
    var frequency: PermissionDemoFrequency = .immediate
    var forceShow = false
    var usesCustomCopy = false

    var config: PermissionConfig {
        PermissionConfig(
            displayFrequency: frequency.displayFrequency,
            forceShow: forceShow,
            title: usesCustomCopy ? "Custom Permission Prompt" : nil,
            description: usesCustomCopy ? "Custom copy resolves through the shared PermissionConfig model." : nil
        )
    }

    var resolvedTitle: String {
        config.getTitle(for: permission.type)
    }

    var resolvedDescription: String {
        config.getDescription(for: permission.type)
    }

    var shouldDisplayNow: Bool {
        forceShow || frequency.displayFrequency.shouldDisplay(for: permission.type)
    }
}
