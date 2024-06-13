import RxSwift

protocol WeatherUseCase {
    func getFiveDayForecast(city: String) -> Observable<WeatherDataModel>
}

final class DefaultWeatherUseCase: WeatherUseCase {

    private var apiClient: URLSessionAPIClient
    
    init(apiClient: URLSessionAPIClient) {
        self.apiClient = apiClient
    }
    
    func getFiveDayForecast(city: String) -> Observable<WeatherDataModel> {
            return apiClient.request(WeatherEndpoint.fiveDayForecast(city: city))
                .catch { error in
                    return Observable.error(APIError.invalidResponse)
                }
        }
    }
