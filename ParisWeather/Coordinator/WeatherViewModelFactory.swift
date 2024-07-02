//  Factory responsible for creating instances of ParisWeatherViewModel
class WeatherViewModelFactory {
    
    static func createViewModel(coordinator: MainCoordinator) -> ParisWeatherViewModel {
        let apiClient = URLSessionAPIClient()
        let weatherUseCase = DefaultWeatherUseCase(apiClient: apiClient)
        return ParisWeatherViewModel(useCase: weatherUseCase, coordinator: coordinator)
    }
}
