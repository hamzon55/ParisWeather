// MARK: - WeatherDataModel
struct WeatherDataModel: Equatable,Codable {
    let list: [List]
    let city: City
    
    static func == (lhs: WeatherDataModel, rhs: WeatherDataModel) -> Bool {
           return lhs.list == rhs.list && lhs.city == rhs.city
       }
}
