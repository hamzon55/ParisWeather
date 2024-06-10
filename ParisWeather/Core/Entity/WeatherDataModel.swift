struct WeatherDataModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}
