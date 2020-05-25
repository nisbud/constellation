import Foundation
import UIKit

public class HomeViewController: UIViewController {
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.frame = CGRect(origin: CGPoint.zero, size: ScreenSize)
		
		let titleLabel = getTitle(text: "Constellation")
		view.addSubview(titleLabel)

		let button = getButton(text: "Start",
							   selector: #selector(pushNextVC),
							   yPosition: 0.7 * ScreenSize.height,
							   alignment: .center)

		view.addSubview(button)
	}
	
	@objc func pushNextVC() {
		self.navigationController?.pushViewController(DotViewController(), animated: true)
	}
}
