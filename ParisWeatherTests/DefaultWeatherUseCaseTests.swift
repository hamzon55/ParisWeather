import XCTest
import RxSwift
import RxBlocking
@testable import ParisWeather

final class DefaultWeatherUseCaseTests: XCTestCase {
    
    var sut: DefaultWeatherUseCase!
    var mockAPIClient: MockURLSessionAPIClient!
    var disposeBag: DisposeBag!
    var mockWeather : MockWeatherDataModel!
 
    override func setUp() {
        super.setUp()
        mockAPIClient = MockURLSessionAPIClient()
        sut = DefaultWeatherUseCase(apiClient: mockAPIClient)
        disposeBag = DisposeBag()
        mockWeather = MockWeatherDataModel()
    }
    
    override func tearDown() {
        mockAPIClient = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testGetFiveDayForecastSuccess() {
        let mockWeatherDataModel = mockWeather.createMockWeatherDataModel()
        mockAPIClient.result = Observable.just(mockWeatherDataModel)
        let result = try! sut.getFiveDayForecast(city: "Paris").toBlocking().first()
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.city.name, "Paris")
        XCTAssertEqual(result?.list.count, 2)
    }
    
    func testGetFiveDayForecastFailure() {
        mockAPIClient.error = APIError.invalidResponse
        
        do {
            _ = try sut.getFiveDayForecast(city: "Paris").toBlocking().first()
            XCTFail("Expected an error to be thrown")
        } catch let error as APIError {
            XCTAssertEqual(error, APIError.invalidResponse)
        } catch {
            XCTFail("Expected APIError.invalidResponse but got \(error)")
        }
    }
}
    
    


