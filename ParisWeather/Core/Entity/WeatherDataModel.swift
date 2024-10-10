// MARK: - WeatherDataModel
struct WeatherDataModel: Equatable,Codable {
    let list: [List]
    let city: City
    
    init(list: [List], city: City) {
        self.list = list
        self.city = city
    }
    
    static func == (lhs: WeatherDataModel, rhs: WeatherDataModel) -> Bool {
           return lhs.list == rhs.list && lhs.city == rhs.city
       }
}
