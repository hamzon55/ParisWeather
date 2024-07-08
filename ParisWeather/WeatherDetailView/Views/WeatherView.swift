import UIKit
import SnapKit
import Kingfisher

class WeatherView: UIView {
    
    private enum Constants {
        enum Location {
            static let font = UIFont.boldSystemFont(ofSize: 48)
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
      
    }
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.Location.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var weatherSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.SmallFont.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var weatherGustLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.SmallFont.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private lazy var overallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.Overall.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.Temperature.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = Constants.SmallFont.font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var pressureLabel: UILabel = {
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
         weatherSpeedLabel, weatherGustLabel, humidityLabel, pressureLabel].forEach { addSubview($0)}
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Spacing.topOffset)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(Spacing.offset)
            make.centerY.equalTo(weatherImageView.snp.centerY)
            make.height.equalTo(weatherImageView)
        }
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(Spacing.weatherImgOffset)
            make.trailing.equalTo(temperatureLabel.snp.leading).offset(Spacing.topOffset)
            make.leading.equalToSuperview().offset(Spacing.highOffset)
        }
        overallLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(Spacing.offsetStandard)
            make.centerX.equalToSuperview()
        }
        weatherSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(overallLabel.snp.bottom).offset(Spacing.topOffset)
            make.centerX.equalToSuperview()
        }
        weatherGustLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherSpeedLabel.snp.bottom).offset(Spacing.offsetStandard)
            make.centerX.equalToSuperview()
        }
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherGustLabel.snp.bottom).offset(Spacing.topOffset)
            make.centerX.equalToSuperview()
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(Spacing.offsetStandard)
            make.centerX.equalToSuperview()
        }
    }
    
    func apply(weatherElement: WeatherDetailData) {
       
        locationLabel.text = weatherElement.weatherData.city.name
        overallLabel.text =  weatherElement.weatherDetail.weather.first?.description.rawValue
        temperatureLabel.text = String(weatherElement.weatherDetail.main.temp.toCelsiusString())
        humidityLabel.text = String(format: WeatherConstants.Humidity.format, "\(weatherElement.weatherDetail.main.humidity)")
        pressureLabel.text = String(format: WeatherConstants.Pressure.format, "\(weatherElement.weatherDetail.main.pressure)")
        weatherSpeedLabel.text = String(format: WeatherConstants.Wind.speedFormat, weatherElement.weatherDetail.wind.speed.toString())
        weatherGustLabel.text = String(format: WeatherConstants.Wind.gustFormat, weatherElement.weatherDetail.wind.gust.toString())
        let iconURLString = weatherElement.weatherDetail.weather.first?.icon
        if let iconURL = iconURLString?.asWeatherIconURL() {
            weatherImageView.download(image: iconURL)
        }
    }
}
