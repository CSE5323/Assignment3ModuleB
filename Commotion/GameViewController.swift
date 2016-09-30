//
//  GameViewController.swift
//  Assignment3Game
//
//  Created by Jenn Le on 9/28/16.
//  Copyright © 2016 Thakugan. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneNode = GameScene(size: view.frame.size)
        
        if let view = self.view as! SKView? {
            view.presentScene(sceneNode)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

}

