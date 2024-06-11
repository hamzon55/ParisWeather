import Foundation
import RxRelay
import RxSwift

typealias ParisWeatherViewModelOuput = Observable<ParisWeatherViewState>

class ParisWeatherViewModel: ParisWeatherViewModelType {
    
    private let disposeBag = DisposeBag()
    private let useCase: WeatherUseCase
    private let coordinator: MainCoordinator

    var list: [List] = []
 
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
                    self.list =   weather.list
                    state.accept(.success(self.list))
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
                case .success(let lists):
                    guard lists.indices.contains(index) else {
                        return nil
                    }
                    let selectedList = lists[index]
                    self.coordinator.navigateToHeroDetail(weather: selectedList)     
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
}
