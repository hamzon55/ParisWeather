import Foundation

enum WeatherEndpoint: APIEndpoint {
    case currentWeather(city: String)
    case fiveDayForecast(city: String)
    
    var baseURL: URL {
        return URL(string: WeatherConstants.baseUrl)!
    }
    
    var path: String {
        switch self {
        case.currentWeather:
            return WeatherConstants.weatherKey
        case .fiveDayForecast:
            return  WeatherConstants.forecastKey
        }
    }
        
        var parameters: [String: Any]? {
            switch self {
            case .currentWeather(let city), .fiveDayForecast(let city):
                return ["q": city, "appid": WeatherConstants.apiKey, "units": "metric"]
            }
        }
        
        var headers: [String : String]? {
            return nil
        }
        
        var method: HTTPMethod {
            
            return .get
        }
    }
