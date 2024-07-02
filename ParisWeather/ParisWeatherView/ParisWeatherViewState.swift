import Foundation
import RxSwift

struct ParisWeatherViewInput {
    let appear: Observable<Void>
    let selection: Observable<Int>
  }

enum ParisWeatherViewState {
    case idle
    case success(WeatherDataModel)
    case failure(String)
    
}

extension ParisWeatherViewState: Equatable {
    static func == (lhs: ParisWeatherViewState, rhs: ParisWeatherViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.success(let lhsData), .success(let rhsData)): return lhsData == rhsData
        case (.failure(let lhsMessage), .failure(let rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}

struct ParisWeatherViewModelOutput {
    let state: Observable<ParisWeatherViewState>
}

protocol ParisWeatherViewModelType: AnyObject {
    func transform(input:ParisWeatherViewInput) -> ParisWeatherViewModelOutput
}
