import RxSwift
import RxCocoa
import XCTest
import RxBlocking
import RxTest
@testable import ParisWeather

class ParisWeatherViewModelTests: XCTestCase {
    
    private var viewModel: ParisWeatherViewModel!
    private var mockUseCase: MockWeatherUseCase!
    private var mockCoordinator: MockCoordinator!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    private var mockNavigationController: MockNavigationController!
    
    override func setUp() {
        super.setUp()
        mockNavigationController = MockNavigationController()
        mockUseCase = MockWeatherUseCase()
        mockCoordinator = MockCoordinator(navigationController: mockNavigationController )
        viewModel = ParisWeatherViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testLoadingState() {
        
        let appearSubject = scheduler.createHotObservable([.next(10, ())])
        let selectionSubject = scheduler.createHotObservable([Recorded<Event<Int>>]())
        let input = ParisWeatherViewInput(
            appear: appearSubject.asObservable(),
            selection: selectionSubject.asObservable()
        )
        let output = viewModel.transform(input: input)
        let stateObserver = scheduler.createObserver(ParisWeatherViewState.self)
        output.state.subscribe(stateObserver).disposed(by: disposeBag)
        
        let weatherData = WeatherDataModel(list: [], city: City(id: 1, name: "Paris"))
        mockUseCase.result = Observable.just(weatherData)
        scheduler.start()
        
        let expectedStates: [Recorded<Event<ParisWeatherViewState>>] = [
            .next(10, .idle),
            .next(10, .success(weatherData))
        ]
        XCTAssertEqual(stateObserver.events, expectedStates)
        
    }
}
