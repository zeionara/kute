import Foundation


public extension Date {
    static let dateSeparator: String = "-"
    static let dateTimeSeparator: String = "@"
    static let timeSeparator: String = ":"
    static let timeFractionSeparator: String = "."

    var token: String {
        let components = Calendar.current.dateComponents(
            [.day, .month, .year, .hour, .minute, .second, .nanosecond],
            from: self
        )

        let stringifiedDate =
            String(format: "%02d", components.day!) + Date.dateSeparator +
            String(format: "%02d", components.month!) + Date.dateSeparator +
            String(format: "%04d", components.year!) + Date.dateTimeSeparator +
            String(format: "%02d", components.hour!) + Date.timeSeparator +
            String(format: "%02d", components.minute!) + Date.timeSeparator +
            String(format: "%02d", components.second!) + Date.timeFractionSeparator +
            String(components.nanosecond!).prefix(2)

        return stringifiedDate
    }
}
