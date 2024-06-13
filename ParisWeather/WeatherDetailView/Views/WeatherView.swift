import UIKit
import SnapKit
import Kingfisher

class WeatherView: UIView {
    
    private enum Constants {
        enum Location {
            static let font = UIFont.boldSystemFont(ofSize: 32)
        }
        enum Temperature {
            static let font = UIFont.boldSystemFont(ofSize: 55)
        }
        enum Overall {
            static let font = UIFont.boldSystemFont(ofSize: 34)
        }
        enum MinMax {
            static let font = UIFont.boldSystemFont(ofSize: 18)
        }
        enum SmallFont {
            static let font = UIFont.boldSystemFont(ofSize: 14)
        }
        enum Wind {
            static let speedFormat = "Wind Speed: %@ m/s"
            static let gustFormat = "Wind Gust: %@ m/s"
        }
        enum Humidity {
            static let format = "Humidity: %@%%"
        }
        enum Pressure {
            static let format = "Pressure: %@ hPa"
        }
    }
    
    private var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.Location.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var weatherSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.SmallFont.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var weatherGustLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.SmallFont.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private var overallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.Overall.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.Temperature.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.SmallFont.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var pressureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.SmallFont.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        
        [locationLabel, weatherImageView, temperatureLabel, overallLabel,
         weatherSpeedLabel, weatherGustLabel, humidityLabel, pressureLabel
        ].forEach { addSubview($0)}
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(15)
            make.centerY.equalTo(weatherImageView.snp.centerY)
            make.height.equalTo(weatherImageView)
        }
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(24)
            make.trailing.equalTo(temperatureLabel.snp.leading).offset(10)
            make.leading.equalToSuperview().offset(65)
        }
        overallLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        weatherSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(overallLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        weatherGustLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherSpeedLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherGustLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    func apply(weatherElemt: List) {
        overallLabel.text =  weatherElemt.weather.first?.description.rawValue
        temperatureLabel.text = String(weatherElemt.main.humidity)
        humidityLabel.text = String(format: Constants.Humidity.format, "\(weatherElemt.main.humidity)")
        pressureLabel.text = String(format: Constants.Pressure.format, "\(weatherElemt.main.pressure)")
        weatherSpeedLabel.text = String(format: Constants.Wind.speedFormat, weatherElemt.wind.speed.toString())
        weatherGustLabel.text = String(format: Constants.Wind.gustFormat, weatherElemt.wind.gust.toString())
        let iconURLString = weatherElemt.weather.first?.icon
        if let iconURL = iconURLString?.asWeatherIconURL() {
            weatherImageView.download(image: iconURL)
        }
    }
}
