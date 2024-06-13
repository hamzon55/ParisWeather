import Foundation
import RxRelay
import RxSwift

typealias WeatherDetailViewModelOuput = Observable<WeatherDetailViewState>

class WeatherDetailViewModel: WeatherDetailViewModelType {
    
    
    private let disposeBag = DisposeBag()
    let weatherData: WeatherDetailData
    
    init(weatherData: WeatherDetailData) {
        self.weatherData = weatherData
    }
    
    func transform(input: WeatherDetailViewInput) -> WeatherDetailViewOutput {
        
        let state = BehaviorRelay<WeatherDetailViewState>(value: .idle)
        input.appear
            .map { [unowned self] in
                let hourlyForecasts = self.filterHourlyForecasts(for: self.weatherData.weatherDetail)
                return WeatherDetailViewState.success(self.weatherData, hourlyForecasts)
            }
            .bind(to: state)
            .disposed(by: disposeBag)
        return WeatherDetailViewOutput(state: state.asObservable())
        
    }
    private func filterHourlyForecasts(for weatherDetail: List) -> [List] {
           let calendar = Calendar.current
           let selectedDate = Date(timeIntervalSince1970: TimeInterval(weatherDetail.dt))
           let startOfSelectedDay = calendar.startOfDay(for: selectedDate)
           
        return self.weatherData.weatherData.list.filter { forecast in
               let forecastDate = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
               return calendar.isDate(forecastDate, inSameDayAs: startOfSelectedDay)
           }
       }
}
