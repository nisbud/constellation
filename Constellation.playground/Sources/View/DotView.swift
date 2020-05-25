import UIKit

public class DotView: UIView {
	public var currentDotTag: Int = 1
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

