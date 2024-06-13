import  UIKit
@testable import ParisWeather

class MockWeatherDataModel {
    func createMockWeatherDataModel() -> WeatherDataModel {
        let weather1 = Weather(id: 800,
                               main: .clear,
                               description: .clearSky,
                               icon: "01d")
        let weather2 = Weather(id: 801,
                               main: .clouds,
                               description: .fewClouds,
                               icon: "02d")
        
        let mainClass1 = MainClass(temp: 298.15,
                                   feelsLike: 298.15,
                                   tempMin: 298.15,
                                   tempMax: 298.15,
                                   pressure: 1013,
                                   seaLevel: 1013,
                                   grndLevel: 1013,
                                   humidity: 53,
                                   tempKf: 0.0)
        let mainClass2 = MainClass(temp: 300.15,
                                   feelsLike: 300.15,
                                   tempMin: 300.15,
                                   tempMax: 300.15,
                                   pressure: 1012,
                                   seaLevel: 1012,
                                   grndLevel: 1012,
                                   humidity: 55,
                                   tempKf: 0.0)
        
        let wind1 = Wind(speed: 1.54,
                         deg: 140,
                         gust: 2.0)
        let wind2 = Wind(speed: 2.06,
                         deg: 150,
                         gust: 2.5)
        
        let list1 = List(dt: 1622512800,
                         main: mainClass1,
                         weather: [weather1],
                         wind: wind1,
                         dtTxt: "2021-06-01 12:00:00")
        let list2 = List(dt: 1622599200,
                         main: mainClass2,
                         weather: [weather2],
                         wind: wind2,
                         dtTxt: "2021-06-02 12:00:00")
        
        let city = City(id: 2988507,
                        name: "Paris")
        
        return WeatherDataModel(list: [list1, list2], city: city)
    }
    
    func createMockWeatherDetailData() -> WeatherDetailData {
        let weatherDataModel = createMockWeatherDataModel()
        let weatherDetail = weatherDataModel.list.first!
        return WeatherDetailData(weatherDetail: weatherDetail, weatherData: weatherDataModel)
    }
}
