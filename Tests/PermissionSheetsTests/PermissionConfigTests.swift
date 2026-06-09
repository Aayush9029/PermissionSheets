import XCTest
@testable import PermissionSheets

final class PermissionConfigTests: XCTestCase {
    func testDefaultConfigUsesImmediateFrequencyAndStandardCopy() {
        let config = PermissionConfig()

        XCTAssertEqual(config, PermissionConfig(displayFrequency: .immediate))
        XCTAssertEqual(config.getTitle(for: .notification), "Never Miss an Update")
        XCTAssertEqual(config.getDescription(for: .notification), "Stay in the loop with notification updates")
        XCTAssertEqual(config.getTitle(for: .location), "Enable Location Services")
        XCTAssertEqual(config.getDescription(for: .location), "Allow location access to enhance your experience")
    }

    func testCustomCopyOverridesPermissionDefaults() {
        let config = PermissionConfig(
            title: "Custom Title",
            description: "Custom Description"
        )

        XCTAssertEqual(config.getTitle(for: .notification), "Custom Title")
        XCTAssertEqual(config.getTitle(for: .location), "Custom Title")
        XCTAssertEqual(config.getDescription(for: .notification), "Custom Description")
        XCTAssertEqual(config.getDescription(for: .location), "Custom Description")
    }

    func testImmediateDisplayFrequencyAlwaysDisplays() {
        XCTAssertTrue(DisplayFrequency.immediate.shouldDisplay(for: .notification))
        XCTAssertTrue(DisplayFrequency.immediate.shouldDisplay(for: .location))
    }
}
