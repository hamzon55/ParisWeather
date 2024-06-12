import Foundation
import RxRelay
import RxSwift

typealias ParisWeatherViewModelOuput = Observable<ParisWeatherViewState>

class ParisWeatherViewModel: ParisWeatherViewModelType {
    
    private let disposeBag = DisposeBag()
    private let useCase: WeatherUseCase
    private let coordinator: MainCoordinator
    
    var weatherDetails: [WeatherDetail] = []
    
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
                case .next(let weather):
                    self.weatherDetails = self.filterAndGroupByDay(weather: weather)
                    state.accept(.success(self.weatherDetails))
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
                    guard weatherDetails.indices.contains(index) else {
                        return nil
                    }
                    let selectedDetail = weatherDetails[index]
                    self.coordinator.navigateToWeatherDetail(weatherDetail: selectedDetail)
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
    
    private func filterAndGroupByDay(weather: WeatherDataModel) -> [WeatherDetail] {
        var groupedDetails = [WeatherDetail]()
        let calendar = Calendar.current
        
        let groupedByDay = Dictionary(grouping: weather.list) { item -> Date in
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            return calendar.startOfDay(for: date)
        }
        
        let sortedKeys = groupedByDay.keys.sorted().prefix(5)
        for key in sortedKeys {
            if let weatherItems = groupedByDay[key] {
                if let firstItem = weatherItems.first {
                    groupedDetails.append(WeatherDetail(city: weather.city, weatherItem: firstItem))
                }
            }
        }
        return groupedDetails
    }
}
