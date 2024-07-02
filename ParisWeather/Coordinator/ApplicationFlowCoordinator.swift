import UIKit

// MainCoordinator class conforms to the Coordinator protocol
class MainCoordinator: FlowCoordinator {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // Start method to initiate the flow of the coordinator

    func start() {
        let viewController =  ParisWeatherViewController(viewModel: WeatherViewModelFactory.createViewModel(coordinator: self))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // Method to navigate to the weather detail screen
    func navigateToWeatherDetail(data: WeatherDetailData) {
        let viewModel = WeatherDetailViewModel(weatherData: data)
        let detailViewController =  WeatherDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
      }
}
