import RxSwift

protocol APIClientProtocol {
    func request<T>(_ endpoint: APIEndpoint) -> Observable<T> where T: Decodable
}

class URLSessionAPIClient: APIClientProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T>(_ endpoint: APIEndpoint) -> Observable<T> where T : Decodable {
        return Observable.create { observer in
            let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = endpoint.parameters?.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
            var request = URLRequest(url: components?.url ?? url)
            request.httpMethod = endpoint.method.rawValue
            
            endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
            
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(APIError.networkError(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(APIError.invalidResponse)
                    return
                }
                
                guard let data = data else {
                    observer.onError(APIError.invalidResponse)
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(decodedData)
                    observer.onCompleted()
                } catch {
                    observer.onError(APIError.networkError(error))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
