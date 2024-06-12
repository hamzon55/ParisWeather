import Foundation
import UIKit
import RxSwift
import SnapKit

class WeatherDetailViewController: UIViewController {
    private let label =  UILabel()
    private let viewModel: WeatherDetailViewModel
    private let appearSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    private let weatherView = WeatherView()
    private let windView = WindView()

    private lazy var verticaltackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            weatherView,
            windView
        ])
        stackView.axis = .vertical
        stackView.distribution  = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        bindViewModel()
    }
    
    private func updateUI(){
        view.addSubview(verticaltackView)
        self.view.backgroundColor = .white
        verticaltackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(20)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-20)
            make.top.equalTo(view.snp.topMargin).offset(5)

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    private func bindViewModel() {
        let input = WeatherDetailViewInput(appear: appearSubject.asObservable())
        let output = viewModel.transform(input: input)
        
        output.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                self?.handleState(state)
            })
            .disposed(by: disposeBag)
        
        appearSubject.onNext(())
    }
    
    private func handleState(_ state: WeatherDetailViewState) {
        switch state {
        case .idle:
            break
        case .success(let weatherDetails):
            weatherView.apply(weatherElemt: weatherDetails)
            windView.apply(weatherElemt: weatherDetails)
        case .failure(let error):
            debugPrint(error)
        }
    }
}
