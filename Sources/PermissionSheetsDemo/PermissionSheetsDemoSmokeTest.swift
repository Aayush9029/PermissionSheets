import Foundation
import PermissionSheets

enum PermissionSheetsDemoSmokeTest {
    static func run() {
        let model = PermissionDemoModel()

        precondition(model.permission.type == .notification)
        precondition(model.config == PermissionConfig(displayFrequency: .immediate))
        precondition(model.resolvedTitle == "Never Miss an Update")
        precondition(model.resolvedDescription == "Stay in the loop with notification updates")

        print("PermissionSheetsDemo smoke test passed")
    }
}
