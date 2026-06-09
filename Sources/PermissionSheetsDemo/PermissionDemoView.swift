import SwiftUI

struct PermissionDemoView: View {
    @State private var model = PermissionDemoModel()

    var body: some View {
        NavigationSplitView {
            Form {
                permissionSection
                behaviorSection
            }
            .formStyle(.grouped)
            .navigationTitle("PermissionSheets")
        } detail: {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header
                    configurationSummary
                    platformNote
                }
                .padding(32)
                .frame(maxWidth: 680, alignment: .topLeading)
            }
            .navigationTitle(model.permission.title)
        }
        .frame(minWidth: 760, minHeight: 520)
    }

    private var permissionSection: some View {
        Section("Permission") {
            Picker("Type", selection: $model.permission) {
                ForEach(PermissionDemoPermission.allCases) { permission in
                    Label(permission.title, systemImage: permission.symbolName)
                        .tag(permission)
                }
            }
            .pickerStyle(.inline)
        }
    }

    private var behaviorSection: some View {
        Section("Configuration") {
            Picker("Frequency", selection: $model.frequency) {
                ForEach(PermissionDemoFrequency.allCases) { frequency in
                    Text(frequency.title)
                        .tag(frequency)
                }
            }

            Toggle("Force show", isOn: $model.forceShow)
            Toggle("Custom copy", isOn: $model.usesCustomCopy)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(model.permission.title, systemImage: model.permission.symbolName)
                .font(.title2.weight(.semibold))

            Text(model.resolvedTitle)
                .font(.title.weight(.bold))

            Text(model.resolvedDescription)
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var configurationSummary: some View {
        GroupBox("Resolved Configuration") {
            Grid(alignment: .leadingFirstTextBaseline, horizontalSpacing: 24, verticalSpacing: 12) {
                GridRow {
                    Text("Type")
                        .foregroundStyle(.secondary)
                    Text(model.permission.rawValue)
                }

                GridRow {
                    Text("Frequency")
                        .foregroundStyle(.secondary)
                    Text(model.frequency.title)
                }

                GridRow {
                    Text("Force show")
                        .foregroundStyle(.secondary)
                    Text(model.forceShow ? "Enabled" : "Disabled")
                }

                GridRow {
                    Text("Display now")
                        .foregroundStyle(.secondary)
                    Text(model.shouldDisplayNow ? "Yes" : "No")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4)
        }
    }

    private var platformNote: some View {
        Label("macOS demo target: shared configuration only", systemImage: "macwindow")
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    PermissionDemoView()
}
