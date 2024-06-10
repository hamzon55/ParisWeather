import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    
    static let cellID = "WeatherCell"
    
    // UI Components
    private let overlallLabel = UILabel()
    private let minTemperatureLabel = UILabel()
    private let maxTemperatureLabel = UILabel()
    private let iconImageView = UIImageView()
    private let dayNameLabel = UILabel()
    private let backgroundImg = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        overlallLabel.text = nil
        minTemperatureLabel.text = nil
        maxTemperatureLabel.text = nil
        dayNameLabel.text = nil
        cancelImageLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraints(){
        
        backgroundImg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.centerY.centerY.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(120)
        }
        
        overlallLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(iconImageView.snp.trailing).offset(16)
        }
        
        // Set min temperature label constraints to the right side
        maxTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(overlallLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(iconImageView.snp.trailing).offset(16)
        }
        
        // Set min temperature label constraints to the right side
        minTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(maxTemperatureLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(iconImageView.snp.trailing).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupUI() {
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.clipsToBounds = true
        
        [backgroundImg, overlallLabel,minTemperatureLabel,iconImageView,maxTemperatureLabel].forEach { addSubview($0)}
        
    }
    
    private func cancelImageLoading() {
        iconImageView.image = nil
    }
    
    private func loadIconImage(from url: URL?) {
        guard let url = url, let data = try? Data(contentsOf: url) else { return }
        iconImageView.image = UIImage(data: data)
    }
    
    func configure(with forecast: List) {
        overlallLabel.text = forecast.weather.first?.description.rawValue
        minTemperatureLabel.text = "Min Temp: \(forecast.main.tempMin.toCelsiusString()) °C"
        maxTemperatureLabel.text = "Max Temp: \(forecast.main.tempKf.toCelsiusString()) °C"
        
        let sunset = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!
        let sunrise = Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: Date())!
        
        let currentDate = Date()
        let isNight = currentDate.isNightTime(sunrise: sunrise, sunset: sunset)
        if let iconName = forecast.weather.first?.icon {
            let suffix = isNight ? "n" : "d"
            let iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconName)\(suffix)@2x.png")
            loadIconImage(from: iconURL)
        }
        
        if let iconName = forecast.weather.first?.icon {
            let iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
            if let data = try? Data(contentsOf: iconURL!) {
                iconImageView.image = UIImage(data: data)
            }
        }
        
    }
}
