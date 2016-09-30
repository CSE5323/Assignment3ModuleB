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
    @IBOutlet weak var gameStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneNode = GameScene(size: view.frame.size)
        
        if let view = self.view as! SKView? {
            view.presentScene(sceneNode)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        _ = Timer.scheduledTimer(timeInterval: 10,
                                 target: self,
                                 selector: #selector(GameViewController.update),
                                 userInfo: nil, 
                                 repeats: true)
        
       
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func update() {
        gameStatus.text = "Game Over!"
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2) ) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "viewController") as! GameViewController
            self.present(vc, animated: true, completion: nil)
        }
        
    }

}

