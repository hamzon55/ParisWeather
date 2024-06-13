import Foundation
import RxRelay
import RxSwift

typealias ParisWeatherViewModelOuput = Observable<ParisWeatherViewState>

class ParisWeatherViewModel: ParisWeatherViewModelType {
    
    private let disposeBag = DisposeBag()
    private let useCase: WeatherUseCase
    private let coordinator: MainCoordinator
    
    var weatherDetailsList: WeatherDataModel?
    
    init(useCase: WeatherUseCase, coordinator: MainCoordinator) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    func transform(input: ParisWeatherViewInput) -> ParisWeatherViewModelOutput {
        let state = BehaviorRelay<ParisWeatherViewState>(value: .idle)
        
        input.appear
            .flatMapLatest { [unowned self] _ in
                self.useCase.getFiveDayForecast(city: WeatherConstants.Country)
                    .asObservable()
                    .materialize()
            }
            .subscribe(onNext: { event in
                switch event {
                case .next(let weatherData):
                    self.weatherDetailsList = weatherData
                    let fiveDayForecast = self.processFiveDayForecast(weatherData: weatherData)
                    state.accept(.success(fiveDayForecast))
                case .error(let error):
                    state.accept(.failure(error.localizedDescription))
                case .completed:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        input.selection
            .withLatestFrom(state) { (index, state) -> ParisWeatherViewState? in
                switch state {
                case .success(let weatherDetails):
                    guard weatherDetails.list.indices.contains(index) else {
                        return nil
                    }
                    let selectedDetail = self.weatherDetailsList?.list[index]
                    if let weatherData = self.weatherDetailsList {
                        self.coordinator.navigateToWeatherDetail(weatherDetail: selectedDetail!, weatherData: weatherData)
                    }
                    return state
                default:
                    return nil
                }
            }
            .compactMap { $0 }
            .bind(to: state)
            .disposed(by: disposeBag)
        
        return ParisWeatherViewModelOutput(state: state.asObservable())
    }
    
    private func processFiveDayForecast(weatherData: WeatherDataModel) -> WeatherDataModel {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        var dailyForecasts = [List]()
        var seenDays = Set<Date>()
        
        let filteredList = weatherData.list.filter { item in
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            return date >= today
        }
      
        var dailyGroupedForecasts = [Date: [List]]()
        
        for item in filteredList {
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            let day = calendar.startOfDay(for: date)
            if !seenDays.contains(day) {
                seenDays.insert(day)
                dailyGroupedForecasts[day] = []
            }
            dailyGroupedForecasts[day]?.append(item)
        }
        for day in seenDays.sorted().prefix(5) {
            if let forecasts = dailyGroupedForecasts[day] {
                dailyForecasts.append(contentsOf: forecasts)
            }
        }
        return WeatherDataModel(list: dailyForecasts, city: weatherData.city)
    }
}
