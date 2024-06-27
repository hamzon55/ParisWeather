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
    
    private let tableView = UITableView()
    private var hourlyForecasts: [ForeCast] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.register(HourlyForecastCell.self, forCellReuseIdentifier: HourlyForecastCell.cellID)
    }
    
    func apply(hourlyForecasts: [ForeCast]) {
        self.hourlyForecasts = hourlyForecasts
    }
}

extension WindView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyForecastCell.cellID, for: indexPath) as? HourlyForecastCell else {
            return UITableViewCell()
        }
        let forecast = hourlyForecasts[indexPath.row]
        cell.configure(with: forecast)
        return cell
    }
}
