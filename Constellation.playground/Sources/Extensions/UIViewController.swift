import Foundation
import UIKit

extension UIViewController {
	
	public enum HorizontalAlignment {
		case left
		case center
		case right
	}
	
	public func getTitle(text: String) -> UILabel {
		let label = UILabel()
		label.frame = getRect(yPosition: 0.2 * ScreenSize.height, width: 150, height: 50, alignment: .center)
        label.text = text
		label.textAlignment = .center
        label.textColor = .white
		label.font = UIFont.boldSystemFont(ofSize: 20)
		
		return label
	}
	
	public func getSubtitle(text: String) -> UILabel {
		let label = UILabel()
		
		return label
	}
	
	public func getButton(text: String, selector: Selector, yPosition: CGFloat, alignment: HorizontalAlignment) -> UIButton {
		
		let button: UIButton = UIButton()
		button.isUserInteractionEnabled = true
		button.isEnabled = true
		button.layer.borderColor = UIColor.white.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 10
		
		button.setTitle(text, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
		button.tintColor = .white
		
		button.frame = getRect(yPosition: yPosition, width: 80, height: 40, alignment: alignment)
		button.addTarget(self, action: selector, for: .touchUpInside)
		
		return button
	}
	
	public func getRect(yPosition: CGFloat, width: CGFloat, height: CGFloat, alignment: HorizontalAlignment) -> CGRect {
		
		let minSpacing: CGFloat = 150
		
		var rect = CGRect()
		
		switch alignment {
		case .left:
			rect = leftHorizontalRect(yPosition: yPosition,
									  width: width,
									  height: height,
									  spacingFromCenter: minSpacing)
			
		case .center:
			rect = centerHorizontalRect(yPosition: yPosition,
										width: width,
										height: height)
			
		case .right:
			rect = rightHorizontalRect(yPosition: yPosition,
									   width: width,
									   height: height,
									   spacingFromCenter: minSpacing)
		}
		
		return rect
	}
	
	private func leftHorizontalRect(yPosition: CGFloat, width: CGFloat, height: CGFloat, spacingFromCenter: CGFloat) -> CGRect {
		let xPosition: CGFloat = (ScreenSize.width / 2) - (width / 2) - spacingFromCenter
		return CGRect(x: xPosition, y: yPosition, width: width, height: height)
	}
	
	private func centerHorizontalRect(yPosition: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
		let xPosition: CGFloat = (ScreenSize.width / 2) - (width / 2)
		return CGRect(x: xPosition, y: yPosition, width: width, height: height)
	}
	
	private func rightHorizontalRect(yPosition: CGFloat, width: CGFloat, height: CGFloat, spacingFromCenter: CGFloat) -> CGRect {
		let xPosition: CGFloat = (ScreenSize.width / 2) - (width / 2) + spacingFromCenter
		return CGRect(x: xPosition, y: yPosition, width: width, height: height)
	}
	
	private func centerVerticalRect(xPosition: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
		let yPosition: CGFloat = (ScreenSize.height / 2) - (height / 2)
		return CGRect(x: xPosition, y: yPosition, width: width, height: height)
	}
}
