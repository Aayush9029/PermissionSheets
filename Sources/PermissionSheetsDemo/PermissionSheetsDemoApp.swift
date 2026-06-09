import Darwin
import SwiftUI

@main
struct PermissionSheetsDemoApp: App {
    init() {
        guard CommandLine.arguments.contains("--smoke-test") else {
            return
        }

        PermissionSheetsDemoSmokeTest.run()
        exit(EXIT_SUCCESS)
    }

    var body: some Scene {
        WindowGroup {
            PermissionDemoView()
        }
    }
}
