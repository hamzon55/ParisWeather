import RxSwift
@testable import ParisWeather

class MockWeatherUseCase: WeatherUseCase {
    
    var result: Observable<WeatherDataModel>!
    
    func getFiveDayForecast(city: String) -> Observable<WeatherDataModel> {
        return result
    }
}
