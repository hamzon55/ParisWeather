import Foundation
import UIKit
import Kingfisher
import SnapKit

class HourlyForecastCell: UITableViewCell {
    static let cellID = "HourlyForecastCell"
    
    private let timeLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let iconView = UIImageView()
    let iconSize: CGFloat = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        iconView.snp.makeConstraints { make in
            make.height.width.equalTo(iconSize)
        }
        
        let stackView = UIStackView(arrangedSubviews: [timeLabel,
                                                       iconView,
                                                       windSpeedLabel
                                                      ])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.topOffset)
        }
    }
    
    func configure(with forecast: List) {
        let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
        timeLabel.text = date.timeInHourMinuteFormat()
        windSpeedLabel.text = String(format: WeatherConstants.Wind.windSpeedTextFormat, "\(forecast.wind.speed)")
        let iconURLString = forecast.weather.first?.icon
        if let iconURL = iconURLString?.asWeatherIconURL() {
            iconView.download(image: iconURL)
        }
    }
}

