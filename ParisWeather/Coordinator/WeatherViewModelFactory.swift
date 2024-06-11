class WeatherViewModelFactory {
    
    static func createViewModel(coordinator: MainCoordinator) -> ParisWeatherViewModel {
        let apiClient = URLSessionAPIClient()
        let weatherUseCase = DefaultWeatherUseCase(apiClient: apiClient)
       
        return .init(useCase: weatherUseCase, coordinator: coordinator)
    }
}

