import UIKit

class MainCoordinator: Coordinator {
    
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController =  ParisWeatherViewController(viewModel: WeatherViewModelFactory.createViewModel(coordinator: self))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToWeatherDetail(weatherDetail: WeatherDetail) {
       let viewModel = WeatherDetailViewModel(weatherItem: weatherDetail)
        let detailViewController =  WeatherDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
      }
}

