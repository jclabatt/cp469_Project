//
//  GameViewController.swift
//  cp469_Project
//
//  Created by user189769 on 3/27/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if #available(iOS 11.0, *), let view = self.view     {
           view.frame = self.view.safeAreaLayoutGuide.layoutFrame
        }
        guard let view = self.view as! SKView? else { return }
        view.translatesAutoresizingMaskIntoConstraints = false // this is the line that stops the constraints from stacking. super important
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        view.showsPhysics = true
        //view.showsDrawCount = true
        let scene = GameScene(size:view.bounds.size)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let scene = StartScene( size: view.bounds.size)
//        let skView = view as! SKView
//        skView.showsFPS = true ;
//        skView.showsNodeCount = true;
//        skView.ignoresSiblingOrder = true;
//        scene.scaleMode = .resizeFill
//        skView.presentScene(scene)
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
