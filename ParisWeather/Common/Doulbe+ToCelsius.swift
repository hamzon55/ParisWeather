import Foundation

extension Double {
    func toCelsius() -> Double {
        return (self / 33.8).rounded(to: 0)
    }
    
    func toCelsiusString() -> String {
        return String(format: "%.0f°C", self.toCelsius())
    }
    
    func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
