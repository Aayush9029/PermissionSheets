import SwiftUI

#if canImport(UIKit)
import UIKit
#else
public struct UIRectCorner: OptionSet, Sendable {
    public let rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    public static let topLeft = UIRectCorner(rawValue: 1 << 0)
    public static let topRight = UIRectCorner(rawValue: 1 << 1)
    public static let bottomLeft = UIRectCorner(rawValue: 1 << 2)
    public static let bottomRight = UIRectCorner(rawValue: 1 << 3)
    public static let allCorners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
}
#endif

public extension View {
    /// Custom Spacers
    @ViewBuilder
    func hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func xSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }

    func clipRadius(_ radius: CGFloat) -> some View {
        clipShape(.rect(cornerRadius: radius))
            .containerShape(.rect(cornerRadius: radius))
    }
}


public struct CornerRadiusShape: Shape {
    public var radius: CGFloat
    public var corners: UIRectCorner

    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let radius = min(radius, rect.width / 2, rect.height / 2)
        let topLeft = corners.contains(.topLeft) ? radius : 0
        let topRight = corners.contains(.topRight) ? radius : 0
        let bottomRight = corners.contains(.bottomRight) ? radius : 0
        let bottomLeft = corners.contains(.bottomLeft) ? radius : 0

        var path = Path()
        path.move(to: CGPoint(x: rect.minX + topLeft, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        addArc(
            to: &path,
            center: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
            radius: topRight,
            startAngle: -90,
            endAngle: 0
        )

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        addArc(
            to: &path,
            center: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
            radius: bottomRight,
            startAngle: 0,
            endAngle: 90
        )

        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        addArc(
            to: &path,
            center: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
            radius: bottomLeft,
            startAngle: 90,
            endAngle: 180
        )

        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        addArc(
            to: &path,
            center: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
            radius: topLeft,
            startAngle: 180,
            endAngle: 270
        )

        path.closeSubpath()
        return path
    }

    private func addArc(
        to path: inout Path,
        center: CGPoint,
        radius: CGFloat,
        startAngle: Double,
        endAngle: Double
    ) {
        guard radius > 0 else {
            return
        }

        path.addArc(
            center: center,
            radius: radius,
            startAngle: .degrees(startAngle),
            endAngle: .degrees(endAngle),
            clockwise: false
        )
    }
}
