extension Double {
    func toCelsius() -> Double {
        return self - 273.15
    }
    
    func toCelsiusString() -> String {
        return String(format: "%.1f", self.toCelsius())
    }
}
