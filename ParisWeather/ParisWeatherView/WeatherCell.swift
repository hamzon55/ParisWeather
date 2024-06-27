import UIKit
import SnapKit
import Kingfisher

class WeatherCell: UITableViewCell {
    static let cellID = "WeatherCell"
    
    private enum Constants {
        enum Day {
            static let font = UIFont.boldSystemFont(ofSize: 22)
        }
        enum Temperature {
            static let font = UIFont.boldSystemFont(ofSize: 14)
        }
        enum Overall {
            static let font = UIFont.boldSystemFont(ofSize: 10)
        }
        
        static let iconSize: CGFloat = 80
    }
    
    private var overallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = Constants.Overall.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dayNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = Constants.Day.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = Constants.Temperature.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        overallLabel.text = nil
        temperatureLabel.text = nil
        dayNameLabel.text = nil
        iconImageView.cancelDownloading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraints(){
        dayNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Spacing.dayNameOffset)
            make.centerY.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(temperatureLabel.snp.trailing).offset(Spacing.offset)
            make.height.width.equalTo(Constants.iconSize)
            make.trailing.equalToSuperview().offset(Spacing.temperaturetrailing)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(iconImageView.snp.leading).offset(-Spacing.offsetStandard)
        }
        overallLabel.snp.makeConstraints { make in
            make.top.equalTo(dayNameLabel.snp.bottom).offset(Spacing.topOffset)
            make.left.equalTo(dayNameLabel).offset(Spacing.offsetStandard)
        }
    }
    
    private func setupUI() {
        [overallLabel,temperatureLabel,iconImageView, dayNameLabel].forEach { addSubview($0)}
    }
    
    func configure(with forecast: ForeCast) {
        let minTemp =   forecast.main.tempMin.toCelsiusString()
        let maxTemp =   forecast.main.tempMax.toCelsiusString()
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
        overallLabel.text = forecast.weather.first?.description.rawValue
        temperatureLabel.text = "\(minTemp) / \(maxTemp)"
        dayNameLabel.text = date.dayOfWeek()
        let iconURLString = forecast.weather.first?.icon
        if let iconURL = iconURLString?.asWeatherIconURL() {
            iconImageView.download(image: iconURL)
        }
    }
}
