import XCTest
import SnapshotTesting
@testable import ParisWeather

final class ST_WindView: XCTestCase {
    
    private var sut: WindView!
    override func setUp() {
        super.setUp()
        sut = WindView()
    }
    
    func testWindView(){
        let mockForecasts = createMockHourlyForecasts()
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 500)
        sut.apply(hourlyForecasts: mockForecasts)
        assertSnapshot(matching: sut, as: .image)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    private func createMockHourlyForecasts() -> [List] {
        let weather = Weather(id: 800, main: .clear, description: .clearSky, icon: "01d")
        let main = MainClass(temp: 298.15, feelsLike: 298.15, tempMin: 298.15, tempMax: 298.15, pressure: 1013, seaLevel: 1013, grndLevel: 1013, humidity: 53, tempKf: 0.0)
        let wind = Wind(speed: 5.0, deg: 140, gust: 6.0)
        let list1 = List(dt: 1622512800, main: main, weather: [weather], wind: wind, dtTxt: "2021-06-01 12:00:00")
        let list2 = List(dt: 1622516400, main: main, weather: [weather], wind: wind, dtTxt: "2021-06-01 13:00:00")
        return [list1, list2]
    }
}
