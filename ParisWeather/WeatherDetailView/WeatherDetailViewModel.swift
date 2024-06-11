import Foundation
import RxRelay
import RxSwift

typealias WeatherDetailViewModelOuput = Observable<WeatherDetailViewState>

class WeatherDetailViewModel: WeatherDetailViewModelType {
    
    
    private let disposeBag = DisposeBag()
    private let weatherItem: WeatherDetail
    
    init(weatherItem: WeatherDetail) {
        self.weatherItem = weatherItem
    }
    
    func transform(input: WeatherDetailViewInput) -> WeatherDetailViewOutput {
        let state = BehaviorRelay<WeatherDetailViewState>(value: .idle)
        input.appear
            .map { [unowned self] in
                return WeatherDetailViewState.success(self.weatherItem)
            }
            .bind(to: state)
            .disposed(by: disposeBag)
        return WeatherDetailViewOutput(state: state.asObservable())
        
    }
}
