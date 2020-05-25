import Foundation
import UIKit

public class DotViewController: UIViewController {
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		let view = DotView(frame: CGRect(origin: CGPoint.zero, size: ScreenSize))
		let pathObject = PathObject(name: "Apple")
		
		let titleLabel = getTitle()
		view.addSubview(titleLabel)
		
		for index in 0...pathObject.points.count-1 {
			let point = pathObject.points[index]
			
			let objectRect = CGRect(x: point.x,
									y: point.y,
									width: DotRegion,
									height: DotRegion)
			
			let dot = Dot(tag: index)
			dot.frame = objectRect
			view.addSubview(dot)
			
			dot.setup()
			
			self.view = view
		}
	}
	
	func getTitle() -> UILabel {
		let label = UILabel()
		label.frame = getRect(yPosition: 0.1 * ScreenSize.height, width: 200, height: 50, alignment: .center)
        label.text = "Connect the Dots"
		label.textAlignment = .center
        label.textColor = .white
		label.font = UIFont.boldSystemFont(ofSize: 20)
		
		return label
	}
}
