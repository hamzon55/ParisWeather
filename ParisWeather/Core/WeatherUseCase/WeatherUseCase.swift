import RxSwift

protocol WeatherUseCase {
    func getFiveDayForecast(city: String) -> Observable<WeatherDataModel>
}

final class DefaultWeatherUseCase: WeatherUseCase {

    private var apiClient: URLSessionAPIClient
    
    /// - Parameter apiClient: The API client for making network requests.
    init(apiClient: URLSessionAPIClient) {
        self.apiClient = apiClient
    }
    
    /// Retrieves the current weather based on the provided city.
    ///
    /// - Returns: An observable emitting Weather
    func getFiveDayForecast(city: String) -> Observable<WeatherDataModel> {
            return apiClient.request(WeatherEndpoint.fiveDayForecast(city: city))
                .catch { error in
                    return Observable.error(APIError.invalidResponse)
                }
        }
    }
