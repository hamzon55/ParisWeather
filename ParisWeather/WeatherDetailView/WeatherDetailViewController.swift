import Foundation
import UIKit
import RxSwift
import SnapKit

class WeatherDetailViewController: UIViewController {
    private let label =  UILabel()
    private let viewModel: WeatherDetailViewModel
    private let appearSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
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
        view.addSubview(label)
        self.view.backgroundColor = .white
        label.textColor = .green
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
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
