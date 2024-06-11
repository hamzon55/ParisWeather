import Foundation
import RxSwift

protocol ParisWeatherViewModelType: AnyObject {
    func transform(input:ParisWeatherViewInput) -> ParisWeatherViewModelOutput
}

enum ParisWeatherViewState {
    case idle
    case success([List])
    case failure(String)
}

struct ParisWeatherViewInput {
    let appear: Observable<Void>
    let selection: Observable<Int>
  }

struct ParisWeatherViewModelOutput {
    let state: Observable<ParisWeatherViewState>
}
