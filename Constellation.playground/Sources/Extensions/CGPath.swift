import Foundation
import UIKit

extension CGPath {
	public class func dragLine(from start: CGPoint, to end: CGPoint, barThickness proposedBarThickness: CGFloat, bellRadius proposedBellRadius: CGFloat) -> CGPath {
		let barThickness = max(0, proposedBarThickness)
		let bellRadius = max(barThickness / 2, proposedBellRadius)

		let vector = CGPoint(x: end.x - start.x, y: end.y - start.y)
		let length = hypot(vector.x, vector.y)

		if length == 0 {
			return CGPath(ellipseIn: CGRect(origin: start, size: .zero).insetBy(dx: -bellRadius, dy: -bellRadius), transform: nil)
		}

		var yOffset = barThickness / 2
		var xOffset = sqrt(bellRadius * bellRadius - yOffset * yOffset)
		let halfLength = length / 2
		if xOffset > halfLength {
			xOffset = halfLength
			yOffset = sqrt(bellRadius * bellRadius - xOffset * xOffset)
		}

		let jointRadians = asin(yOffset / bellRadius)
		let path = CGMutablePath()
		path.addArc(center: .zero, radius: bellRadius, startAngle: jointRadians, endAngle: -jointRadians, clockwise: false)
		path.addArc(center: CGPoint(x: length, y: 0), radius: bellRadius, startAngle: .pi + jointRadians, endAngle: .pi - jointRadians, clockwise: false)
		path.closeSubpath()

		let unitVector = CGPoint(x: vector.x / length, y: vector.y / length)
		var transform = CGAffineTransform(a: unitVector.x, b: unitVector.y, c: -unitVector.y, d: unitVector.x, tx: start.x, ty: start.y)
		return path.copy(using: &transform)!
	}
}
