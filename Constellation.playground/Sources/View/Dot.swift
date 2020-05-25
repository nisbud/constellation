import Foundation
import UIKit

public class Dot: UIView {
	private let imageView: UIImageView = UIImageView()
	private var panGestureStartPoint: CGPoint = .zero
	
	private lazy var lineShape: CAShapeLayer = {
		let lineShape = CAShapeLayer()
		lineShape.strokeColor = UIColor.yellow.cgColor
		lineShape.fillColor = UIColor.white.cgColor
		lineShape.lineWidth = 2.0

		return lineShape
	}()
	
	private lazy var panRecognizer: UIPanGestureRecognizer = {
		return UIPanGestureRecognizer(target: self, action: #selector(panGestureCalled(_:)))
	}()
	
	public init(tag: Int) {
		super.init(frame: CGRect(x: 0,
								 y: 0,
								 width: DotRegion,
								 height: DotRegion))
		
		self.tag = tag
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setup() {
		guard let superDotView: DotView = self.superview as? DotView else {
			return
		}
		
		if self.tag <= superDotView.currentDotTag {
			setupImageView()
			setupAnimation()
			
			super.addSubview(imageView)
			self.addGestureRecognizer(panRecognizer)
		}
	}
	
	func setupImageView() {
		imageView.image = UIImage(named: "yellowSpark")
		
		imageView.contentMode = .scaleAspectFill
		imageView.frame = CGRect(x: 0,
								 y: 0,
								 width: DotSize,
								 height: DotSize)
	}
	
	func setupAnimation() {
		UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
			self.imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
		}, completion: nil)
	}
	
	@objc func panGestureCalled(_: UIPanGestureRecognizer) {
		
		let currentPanPoint = panRecognizer.location(in: self)
		let linePath = UIBezierPath()
		
		switch panRecognizer.state {
		case .began:
			panGestureStartPoint = CGPoint(x: DotSize / 2, y: DotSize / 2)
			self.layer.addSublayer(lineShape)

		case .changed:
			linePath.move(to: panGestureStartPoint)
			linePath.addLine(to: currentPanPoint)
			
			lineShape.path = linePath.cgPath
			lineShape.path = CGPath.dragLine(from: panGestureStartPoint, to: currentPanPoint, barThickness: 2.0, bellRadius: 6.0)

		case .ended:
			let endedPanPoint = panRecognizer.location(in: self)
			let pointInSuperView = self.convert(endedPanPoint, to: self.superview)
			
			let dotSubviews = self.superview?.subviews.filter { (view) -> Bool in
				return view is Dot
			}
			
			let endPointSubview = self.superview?.subviews.first(where: { (view) -> Bool in
				return view.frame.contains(pointInSuperView)
			})
			
			if let dotView = endPointSubview as? Dot, dotView.tag == self.tag + 1 {
				self.isUserInteractionEnabled = false
				updateCurrentDot(tag: dotView.tag)
				
			} else {
				
				guard self.tag + 1 != dotSubviews?.count else {
					return
				}
				
				lineShape.path = nil
				lineShape.removeFromSuperlayer()
			}
			
		case .possible, .cancelled, .failed:
			break
			
		@unknown default:
			break
		}
	}
	
	func setupNextDot(tag: Int) {
		guard let nextDot = self.superview?.subviews.first(where: { (view) -> Bool in
			return view.tag == tag
		}) as? Dot else {
			return
		}
		
		nextDot.setup()
	}
	
	func updateCurrentDot(tag: Int) {
		guard let superDotView = self.superview as? DotView else {
			return
		}
		
		superDotView.currentDotTag += 1
		setupNextDot(tag: tag + 1)
	}
}
