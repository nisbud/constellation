import UIKit

public class PathObject: NSObject {
	public var name: String?
	public var points: [CGPoint] = []
	
	public init(name: String) {
		super.init()
		self.getContentFromJson(filename: name)
	}
	
	func getContentFromJson(filename: String) {
		guard let url = Bundle.main.url(forResource: "\(filename)Object", withExtension: "json") else {
			return
		}
		
		let data = try! Data(contentsOf: url)
		let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
		
		guard
			let jsonArray = JSON as? [String: Any],
			let name = jsonArray["name"] as? String,
			let path = jsonArray["path"] as? [[String:CGFloat]] else {
				return
		}
		
		for point in path {
			guard let xPercent = point["x"], let yPercent = point["y"] else {
				return
			}
			
			let point = CGPoint(x: xPercent * ScreenSize.width, y: yPercent * ScreenSize.height)
			self.points.append(point)
		}
		
		self.name = name
	}
}
