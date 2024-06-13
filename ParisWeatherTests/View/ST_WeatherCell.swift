import XCTest
import SnapshotTesting
@testable import ParisWeather

final class ST_WeatherCell: XCTestCase {
    
    private var sut: WeatherCell!
    
    override func setUp()  {
        super.setUp()
        sut = WeatherCell(style: .default, reuseIdentifier: WeatherCell.cellID)
    }
    
    func testWeatherCell() {
        let forecast = givenForecastModel()
        sut.configure(with: forecast)
        sut.frame = CGRect(x: 0, y: 0, width: 375, height: 100)
        assertSnapshot(matching: sut, as: .image)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func givenForecastModel() -> List {
        let iconView = "https://openweathermap.org/img/wn/10d@2x.png"
        let weather = Weather(id: 800,
                              main: .clear,
                              description: .clearSky,
                              icon: iconView)
        let main = MainClass(temp: 298.15,
                             feelsLike: 298.15,
                             tempMin: 298.15,
                             tempMax: 298.15,
                             pressure: 1013,
                             seaLevel: 1013,
                             grndLevel: 1013,
                             humidity: 53,
                             tempKf: 0.0)
        let list = List(dt: 1622512800,
                        main: main,
                        weather: [weather],
                        wind: Wind(speed: 1.54,
                                   deg: 140
                                   , gust: 2.0),
                        dtTxt: "2021-06-01 12:00:00")
        return list
    }
}

