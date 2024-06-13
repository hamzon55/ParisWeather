import Foundation

extension String {
    func asWeatherIconURL() -> URL? {
        guard !self.isEmpty else { return nil }
        let iconURL = String(format: WeatherConstants.imageURL, self)
        return URL(string: iconURL)
    }
}
