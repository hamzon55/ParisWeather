import Foundation
import RxRelay
import RxSwift

typealias WeatherDetailViewModelOuput = Observable<WeatherDetailViewState>

class WeatherDetailViewModel: WeatherDetailViewModelType {
    
    
    private let disposeBag = DisposeBag()
    let weatherItem: List
    let weatherData: WeatherDataModel
    
    init(weatherItem: List, weatherData: WeatherDataModel) {
        self.weatherItem = weatherItem
        self.weatherData = weatherData
    }
    
    func transform(input: WeatherDetailViewInput) -> WeatherDetailViewOutput {
        
        let state = BehaviorRelay<WeatherDetailViewState>(value: .idle)
        input.appear
            .map { [unowned self] in
                let hourlyForecasts = self.filterHourlyForecasts(for: self.weatherItem)
                
                return WeatherDetailViewState.success(self.weatherItem, hourlyForecasts)
            }
            .bind(to: state)
            .disposed(by: disposeBag)
        return WeatherDetailViewOutput(state: state.asObservable())
        
    }
    private func filterHourlyForecasts(for weatherDetail: List) -> [List] {
           let calendar = Calendar.current
           let selectedDate = Date(timeIntervalSince1970: TimeInterval(weatherDetail.dt))
           let startOfSelectedDay = calendar.startOfDay(for: selectedDate)
           
        return self.weatherData.list.filter { forecast in
               let forecastDate = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
               return calendar.isDate(forecastDate, inSameDayAs: startOfSelectedDay)
           }
       }
}
