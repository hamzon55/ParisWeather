import Foundation
import UIKit
@testable import ParisWeather


class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
           pushedViewController = viewController
           super.pushViewController(viewController, animated: animated)
       }
}
