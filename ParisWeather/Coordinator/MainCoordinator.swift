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
    
    func navigateToHeroDetail(weather: List) {
         let viewModel = WeatherDetailViewModel(weatherItem: weather)
         let detailViewController =  WeatherDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(detailViewController, animated: true)
      }
}

