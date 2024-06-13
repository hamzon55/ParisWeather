import XCTest
import SnapshotTesting
@testable import ParisWeather

final class ST_HourlyForeCastView: XCTestCase {
    
    private var sut : HourlyForecastCell!
    
    override func setUp() {
        super.setUp()
        sut = HourlyForecastCell(style: .default, reuseIdentifier: HourlyForecastCell.cellID)
    }
    
    func testHourlyForecastCell() {
        let mockForecast = createMockForecast()
        sut.configure(with: mockForecast)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 80)
        assertSnapshot(matching: sut, as: .image)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func createMockForecast() -> List {
        let weather = Weather(id: 800, main: .clear, description: .clearSky, icon: "01d")
        let mainClass = MainClass(temp: 298.15, feelsLike: 298.15, tempMin: 298.15, tempMax: 298.15, pressure: 1013, seaLevel: 1013, grndLevel: 1013, humidity: 53, tempKf: 0.0)
        let wind = Wind(speed: 5.0, deg: 140, gust: 6.0)
        return List(dt: 1622512800, main: mainClass, weather: [weather], wind: wind, dtTxt: "2021-06-01 12:00:00")
    }
}
