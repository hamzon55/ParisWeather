struct WeatherConstants {
    
    static let apiKey = "f8e955b0d6f11e304b7dc6c04d0a4641"
    static let baseUrl = "http://api.openweathermap.org/data/2.5"
    static let imageURL = "https://openweathermap.org/img/wn/%@@2x.png"
    
    enum Wind {
        static let title = "Wind Information:"
        static let speed = "Speed: %.2f"
        static let gust = "Gust: %.2f"
        static let windSpeedTextFormat = "Wind : %@ m/s"
        static let speedFormat = "Wind Speed: %@ m/s"
        static let gustFormat = "Wind Gust: %@ m/s"
    }
    enum Country {
        static let countryTitle = "Paris"
    }
    enum Humidity {
        static let format = "Humidity: %@%%"
    }
    enum Pressure {
        static let format = "Pressure: %@ hPa"
    }
    enum Weather {
        static let forecastKey = "forecast"
        static let weatherKey = "weather"
        static let weatherTitle = "Paris Weather"
        static let detailWeatherTitle = " Weather Details"
    }
}
