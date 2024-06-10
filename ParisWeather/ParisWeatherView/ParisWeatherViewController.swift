import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ParisWeatherViewController: UIViewController {
    
    
    private let disposeBag = DisposeBag()
    private let viewModel: ParisWeatherViewModel
    private let appearSubject = PublishSubject<Void>()
    private let selectionSubject = PublishSubject<Int>()
    private var tableView: UITableView!
    var coordinator: MainCoordinator?

    init(viewModel: ParisWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(WeatherCell.self,
                           forCellReuseIdentifier: WeatherCell.cellID)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .systemBackground
    }
    
    private func bindViewModel() {
          let input = ParisWeatherViewInput(
              appear: appearSubject.asObservable(),
              selection: selectionSubject.asObservable()
          )
          
          let output = viewModel.transform(input: input)
          
        output.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                            self?.handleState(state)
                        })
                        .disposed(by: disposeBag)
                    
                    appearSubject.onNext(())
      }
    
    
    private func handleState(_ state: ParisWeatherViewState) {
           switch state {
           case .idle: 
               break
           case .success(let weatherResponse):
               // Update the table view with the new weather data
               self.viewModel.list = weatherResponse
               tableView.reloadData()
           case .failure(let error):
            break
           }
       }
    
}



extension ParisWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.cellID, for: indexPath) as! WeatherCell
        let weatherList = viewModel.list[indexPath.row]
        if let weatherItem = weatherList.weather.first {
            cell.configure(with: weatherItem)

        } else {
            print("Weather data not available")

        }
        cell.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        return cell
    }
}
