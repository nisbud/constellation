import SpriteKit
import UIKit

public class BackgroundScene: SKScene {
	
	override public func didMove(to view: SKView) {
		backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
		
		guard let emitter = SKEmitterNode(fileNamed: "Stars") else {
			return
		}
		
		addChild(emitter)
	}
}
