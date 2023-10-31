//
//  GameScene.swift
//  Exploding Monkeys
//
//  Created by Bambang Tri Rahmat Doni on 31/10/23.
//

import SpriteKit

enum CollisionTypes: UInt32 {
    case banana = 1
    case building = 2
    case player = 4
}

class GameScene: SKScene {
    weak var viewController: GameViewController!
    
    private var buildings = [BuildingNode]()
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        createBuildings()
    }
    
    private func createBuildings() -> Void {
        var currentX = CGFloat(-15)
        
        while currentX < 1024 {
            let size = CGSize(width: Int.random(in: 2...4) * 40, height: Int.random(in: 300...600))
            currentX += size.width + 2
            
            let building = BuildingNode(color: UIColor.red, size: size)
            building.position = CGPoint(x: currentX - (size.width / 2), y: size.height / 2)
            building.setup()
            addChild(building)
            
            buildings.append(building)
        }
    }
}
