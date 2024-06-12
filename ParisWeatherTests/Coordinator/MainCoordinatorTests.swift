import XCTest
@testable import ParisWeather

final class MainCoordinatorTests: XCTestCase {
    
    var mockNavigationController: MockNavigationController!
    var coordinator: MainCoordinator!
    
    override func setUp() {
        super.setUp()
        mockNavigationController =  MockNavigationController()
        coordinator = MainCoordinator(navigationController: mockNavigationController)
    }
    override func tearDown() {
          mockNavigationController = nil
          coordinator = nil
          super.tearDown()
      }
    
    func testStartView() {
        coordinator.start()
        XCTAssertTrue(mockNavigationController.pushedViewController is ParisWeatherViewController)
        
    }
}
