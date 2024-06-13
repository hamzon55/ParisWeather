import RxSwift
import UIKit
@testable import ParisWeather

class MockURLSessionAPIClient: URLSessionAPIClient {
    var result: Observable<WeatherDataModel>?
    var error: Error?

    override func request<T>(_ endpoint: APIEndpoint) -> Observable<T> where T: Decodable {
        if let error = error {
            return Observable.error(error)
        }
        return result as! Observable<T>
    }
}
