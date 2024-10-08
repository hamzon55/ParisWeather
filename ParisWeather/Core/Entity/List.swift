// MARK: - List
struct List: Codable, Equatable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let wind: Wind
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct MainClass: Codable, Equatable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
           case temp
           case feelsLike = "feels_like"
           case tempMin = "temp_min"
           case tempMax = "temp_max"
           case pressure
           case seaLevel = "sea_level"
           case grndLevel = "grnd_level"
           case humidity
           case tempKf = "temp_kf"
       }
}

// MARK: - Weather
struct Weather: Codable, Equatable {
    let id: Int
    let main: MainEnum
    let description: Description
    let icon: String
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case heavyIntensityRain = "heavy intensity rain"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
}

enum MainEnum: String, Codable, Equatable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable, Equatable {
    let speed: Double
    let deg: Int
    let gust: Double
}


struct WeatherDetailData {
    let weatherDetail: List
    let weatherData: WeatherDataModel
}
