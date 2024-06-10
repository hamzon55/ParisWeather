class WeatherViewModelFactory {
    
    static func createViewModel(coordinator: MainCoordinator) -> ParisWeatherViewModel {
        let apiClient = URLSessionAPIClient()
        let weatherUseCase = DefaultWeatherUseCase(apiClient: apiClient)
        let viewModel = ParisWeatherViewModel(useCase: weatherUseCase)
        return viewModel
    }
}

