import UIKit
extension UIViewController {

    private static let loadingViewTag = 1

    func showLoadingView() {
        if let _ = view.viewWithTag(UIViewController.loadingViewTag) as? LoadingView {
            return
        }

        let loadingView = LoadingView(frame: view.bounds)
        loadingView.tag = UIViewController.loadingViewTag
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func hideLoadingView() {
        view.viewWithTag(UIViewController.loadingViewTag)?.removeFromSuperview()
    }
}
