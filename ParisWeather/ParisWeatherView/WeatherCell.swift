import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    static let cellID = "WeatherCell"
    
    private enum Constants {
        enum Day {
            static let font = UIFont.boldSystemFont(ofSize: 22)
        }
        enum MinMax {
            static let font = UIFont.boldSystemFont(ofSize: 16)
        }
        enum Overall {
            static let font = UIFont.boldSystemFont(ofSize: 12)
        }
        
        static let iconSize: CGFloat = 80
        
    }
    
    // UI Components
    private var overallLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
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
        label.textAlignment = .center
        label.font = Constants.MinMax.font
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
        cancelImageLoading()
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
            make.centerX.equalToSuperview()
            make.height.width.equalTo(Constants.iconSize)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(Spacing.offset)
            make.trailing.equalToSuperview().offset(Spacing.temperaturetrailing)
        }
        
        overallLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(Spacing.overallOffset)
            make.leading.equalTo(iconImageView.snp.trailing).offset(Spacing.offset)
            make.trailing.equalToSuperview().offset(Spacing.overallTrailing)
        }
        
    }
    
    private func setupUI() {
        [overallLabel,temperatureLabel,iconImageView, dayNameLabel].forEach { addSubview($0)}
        
    }
    
    private func cancelImageLoading() {
        iconImageView.image = nil
    }
    
    private func loadIconImage(from url: URL?) {
        guard let url = url, let data = try? Data(contentsOf: url) else { return }
        iconImageView.image = UIImage(data: data)
    }
    
    func configure(with forecast: List) {
        
        overallLabel.text = forecast.weather.first?.description.rawValue
        temperatureLabel.text = "\(forecast.main.tempMin.toCelsiusString()) °C / \(forecast.main.tempMax.toCelsiusString()) °C"
        
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
        dayNameLabel.text = date.dayOfWeek()
        
        if let iconName = forecast.weather.first?.icon {
            let iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
            if let data = try? Data(contentsOf: iconURL!) {
                iconImageView.image = UIImage(data: data)
            }
        }
    }
}
