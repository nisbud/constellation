//: A SpriteKit based Playground

import Foundation
import PlaygroundSupport
import SpriteKit
import UIKit

let skView = SKView(frame: CGRect(origin: CGPoint.zero, size: ScreenSize))
let scene = BackgroundScene(size: ScreenSize)
scene.scaleMode = .aspectFill
skView.presentScene(scene)

let navigationController = UINavigationController(rootViewController: HomeViewController())
navigationController.navigationBar.isHidden = true
navigationController.view.frame = CGRect(origin: CGPoint.zero, size: ScreenSize)

skView.addSubview(navigationController.view)

PlaygroundSupport.PlaygroundPage.current.liveView = skView
