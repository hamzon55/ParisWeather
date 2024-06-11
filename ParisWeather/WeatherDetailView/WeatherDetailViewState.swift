import Foundation
import RxSwift

protocol WeatherDetailViewModelType: AnyObject {
    func transform(input:WeatherDetailViewInput) -> WeatherDetailViewOutput
}

enum WeatherDetailViewState {
    case idle
    case success(WeatherDetail)
    case failure(String)
}

struct WeatherDetailViewInput {
    let appear: Observable<Void>
  }

struct WeatherDetailViewOutput {
    let state: Observable<WeatherDetailViewState>
}
