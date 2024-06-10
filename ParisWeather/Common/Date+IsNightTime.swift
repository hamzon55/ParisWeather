import Foundation

extension Date {
    func isNightTime(sunrise: Date, sunset: Date) -> Bool {
        return self < sunrise || self > sunset
    }
}
