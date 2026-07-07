import SwiftUI

/// Bespoke palette + type for Earplugtrack - Earplug Use Log.
enum Theme {
    static let background = Color(hex: "#12181C")
    static let primary = Color(hex: "#2E5266")
    static let secondary = Color(hex: "#5E7B8C")
    static let accent = Color(hex: "#F2A65A")
    static let cardBackground = Color(hex: "#12181C").opacity(0.6)

    static let titleFont = Font.custom("Georgia", size: 28).weight(.bold)
    static let headlineFont = Font.custom("Georgia", size: 18).weight(.semibold)
    static let bodyFont = Font.custom("Georgia", size: 16)
    static let captionFont = Font.custom("Georgia", size: 13)
}

extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
