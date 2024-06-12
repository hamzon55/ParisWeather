import Kingfisher

extension UIImageView {
    func cancelDownloading() {
        kf.cancelDownloadTask()
    }

    func download(image url: URL?) {
        guard let url = url else { return }
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}


extension String {
    func asWeatherIconURL() -> URL? {
        guard !self.isEmpty else { return nil }
        let iconURL = String(format: WeatherConstants.imageURL, self)
        return URL(string: iconURL)
    }
}
