import SwiftUI

public struct PermissionSheet<Content: View>: View {
    let title: String
    let description: String
    let content: Content
    let primaryButtonTitle: String
    let primaryAction: () -> Void
    let onDismiss: () -> Void
    
    public init(
        title: String,
        description: String,
        @ViewBuilder content: () -> Content,
        primaryButtonTitle: String,
        primaryAction: @escaping () -> Void,
        onDismiss: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.content = content()
        self.primaryButtonTitle = primaryButtonTitle
        self.primaryAction = primaryAction
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        VStack {
            content
            Spacer()
            VStack(spacing: 12) {
                Text(title)
                    .font(.largeTitle.bold())
                Text(description)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Spacer()
                buttonStack
            }
            .padding()
        }
        .multilineTextAlignment(.center)
    }
    
    private var buttonStack: some View {
        VStack(spacing: 16) {
            Button(action: primaryAction) {
                Text(primaryButtonTitle)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            Button("Not Now", action: onDismiss)
                .font(.title3)
                .bold()
                .foregroundStyle(.blue)
        }
    }
}



#Preview {
    PermissionSheet(
        title: "Enable Notifications",
        description: "Stay updated with the latest news and important updates",
        content: {
            Text("")
            .xSpacing(.center)
            .background(.black.opacity(0.5))
        },
        primaryButtonTitle: "Allow Notifications",
        primaryAction: {},
        onDismiss: {}
    )
}