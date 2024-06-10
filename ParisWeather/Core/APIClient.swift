import RxSwift

protocol APIClient {
    func request<T>(_ endpoint: APIEndpoint) -> Observable<T> where T: Decodable
}
