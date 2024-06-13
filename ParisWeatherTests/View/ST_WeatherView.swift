import XCTest
import SnapshotTesting
@testable import ParisWeather

final class ST_WeatherView: XCTestCase {
    
    private var sut: WeatherView!
    
    override func setUp() {
        super.setUp()
        sut = WeatherView()
    }
    
    func testWeatherView() {
        let mockWeatherDetailData = createMockWeatherDetailData()
        sut.apply(weatherElement: mockWeatherDetailData)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
        assertSnapshot(matching: sut, as: .image)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func createMockWeatherDetailData() -> WeatherDetailData {
        let weather = Weather(id: 800, main: .clear, description: .clearSky, icon: "01d")
        let mainClass = MainClass(temp: 298.15, feelsLike: 298.15, tempMin: 298.15, tempMax: 298.15, pressure: 1013, seaLevel: 1013, grndLevel: 1013, humidity: 53, tempKf: 0.0)
        let wind = Wind(speed: 5.0, deg: 140, gust: 6.0)
        let list = List(dt: 1622512800, main: mainClass, weather: [weather], wind: wind, dtTxt: "2021-06-01 12:00:00")
        let city = City(id: 2988507, name: "Paris")
        let weatherDataModel = WeatherDataModel(list: [list], city: city)
        return WeatherDetailData(weatherDetail: list, weatherData: weatherDataModel)
    }
}
