struct WeatherConstants {
    
    static let apiKey = "f8e955b0d6f11e304b7dc6c04d0a4641"
    static let baseUrl = "http://api.openweathermap.org/data/2.5"
    static let forecastKey = "forecast"
    static let weatherKey = "weather"
    static let Country = "Paris"
    static let imageURL = "https://openweathermap.org/img/wn/%@@2x.png"  
    
    enum Wind {
       static let title = "Wind Information:"
       static let speed = "Speed: %.2f"
       static let gust = "Gust: %.2f"
        static let windSpeedTextFormat = "Wind : %@ m/s"
    }
}
