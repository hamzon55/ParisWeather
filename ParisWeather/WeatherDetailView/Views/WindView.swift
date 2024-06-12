import Foundation
import UIKit
import SnapKit

class WindView: UIView {
    private enum Constants {
        enum Title {
            static let font = UIFont.boldSystemFont(ofSize: 20)
        }
        enum Text {
            static let font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    private var speedLabel: UILabel = {
       let label = UILabel()
       label.textColor = .black
       label.font = Constants.Text.font
        label.textAlignment = .center
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private var gustLabel: UILabel = {
       let label = UILabel()
       label.textColor = .black
       label.font = Constants.Text.font
       label.textAlignment = .center
       label.translatesAutoresizingMaskIntoConstraints = false
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
        backgroundColor = .green
        addSubview(speedLabel)
        addSubview(gustLabel)
        
        speedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-30)
            
        }
        
        gustLabel.snp.makeConstraints { make in
            make.top.equalTo(speedLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-30)
            
        }
        
    }
    
    func apply(weatherElemt: WeatherDetail) {
        let wind = weatherElemt.weatherItem.wind
        speedLabel.text  =  String(format: WeatherConstants.Wind.speed, wind.speed)
        gustLabel.text = String(format: WeatherConstants.Wind.gust, wind.gust)
    }
}
