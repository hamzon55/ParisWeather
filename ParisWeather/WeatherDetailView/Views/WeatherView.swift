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
            static let font = UIFont.boldSystemFont(ofSize: 20)
        }
        enum MinMax {
            static let font = UIFont.boldSystemFont(ofSize: 18)
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
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
        backgroundColor = .white
        addSubview(locationLabel)
        addSubview(weatherImageView)
        addSubview(temperatureLabel)
        addSubview(overallLabel)
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(24)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(100)
            make.width.equalTo(100)
            
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(35)
            make.height.equalTo(100)
            
        }
        
        overallLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func apply(weatherElemt: WeatherDetail) {
        overallLabel.text =  weatherElemt.weatherItem.weather.first?.description.rawValue
        temperatureLabel.text = weatherElemt.weatherItem.main.temp.toCelsiusString()
        locationLabel.text = weatherElemt.city.name
        if let iconName = weatherElemt.weatherItem.weather.first?.icon {
            let iconURLString = "\(iconName)"
            if let iconURL =  map(iconURLString: iconURLString) {
                weatherImageView.download(image: iconURL)
            }
        }
        
    }
    
    func map(iconURLString: String?) -> URL? {
        guard let iconURLString = iconURLString else { return nil }
        let iconURL = String(format: WeatherConstants.imageURL, iconURLString)
        return URL(string: iconURL)
    }
}
