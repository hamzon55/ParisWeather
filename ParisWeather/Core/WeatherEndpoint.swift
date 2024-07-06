import Foundation

enum WeatherEndpoint: APIEndpoint {
    case fiveDayForecast(city: String)
    
    var baseURL: URL {
        return URL(string: WeatherConstants.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .fiveDayForecast:
            return  WeatherConstants.Weather.forecastKey
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fiveDayForecast(let city):
            return ["q": city,
                    "appid": WeatherConstants.apiKey
            ]
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
}
