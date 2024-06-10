import UIKit
import SnapKit

class WeatherCell: UITableViewCell {
    
    static let cellID = "WeatherCell"
    
    // UI Components
    private let dateLabel = UILabel()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(dateLabel)
        
        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    func configure(with forecast: Weather) {
        dateLabel.text = forecast.description.rawValue
    }
}
