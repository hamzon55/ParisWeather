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
        stackView.spacing = Spacing.topOffset
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
        self.title =  WeatherConstants.detailWeatherTitle
        view.addSubview(verticaltackView)
        self.view.backgroundColor = .white
        verticaltackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(Spacing.StackViewOffset)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-Spacing.StackViewOffset)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-Spacing.StackViewOffset)
            make.top.equalTo(view.snp.topMargin).offset(Spacing.offsetStandard)
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
            showLoadingView()
        case .success(let weatherDetail, let foreCast):
            hideLoadingView()
            weatherView.apply(weatherElement: weatherDetail)
            windView.apply(hourlyForecasts: foreCast)
        case .failure(_):
            hideLoadingView()
        }
    }
}
