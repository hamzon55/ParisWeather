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
    
    private lazy var verticaltackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            weatherView
        ])
        stackView.axis = .vertical
        stackView.spacing = 30
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
            make.leading.equalTo(view.snp.leadingMargin).offset(15)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-15)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-15)
            make.top.equalTo(view.snp.topMargin).offset(15)

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
            label.text = weatherDetails.dtTxt
        case .failure(let error):
            debugPrint(error)
        }
    }
}
