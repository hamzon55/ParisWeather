@testable import ParisWeather

class MockCoordinator: MainCoordinator {
    var navigatedToWeatherDetail = false
    
    override func navigateToWeatherDetail(data: WeatherDetailData) {
        navigatedToWeatherDetail = true
    }
}

