import Foundation
import RxSwift

protocol WeatherDetailViewModelType: AnyObject {
    func transform(input:WeatherDetailViewInput) -> WeatherDetailViewOutput
}

enum WeatherDetailViewState {
    case idle
    case success(WeatherDetailData, [List])
    case failure(String)
}

struct WeatherDetailViewInput {
    let appear: Observable<Void>
  }

struct WeatherDetailViewOutput {
    let state: Observable<WeatherDetailViewState>
}
