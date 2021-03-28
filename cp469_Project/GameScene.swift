//
//  GameScene.swift
//  cp469_Project
//
//  Created by user189769 on 3/27/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate  {
    
    
    //game setting variables
    private var playerSpeed:CGFloat = 1.0;

    //Private Variables
    private var lastUpdateTime : TimeInterval = 0
    private var unitWidth:CGFloat = 0.0
    private var unitHeight:CGFloat = 0.0

    private var moveDistanceVerticle:CGFloat = 0
    private var moveDistanceHorizontal:CGFloat = 0
    //Private Nodes
    private var player: SKSpriteNode?
    private var upKey: SKSpriteNode?
    private var downKey: SKSpriteNode?
    private var leftKey: SKSpriteNode?
    private var rightKey: SKSpriteNode?
    //Private Constants
    private let widthFrac = 10;
    private let HeightFrac =  20;
    
    private let playerAnimationSpeed = 0.3;
    
    
    override func sceneDidLoad() {
        backgroundColor = .white
        
        let screenWidth = self.frame.width
        let screenHeigh = self.frame.height
        
        unitWidth = CGFloat(screenWidth/CGFloat(widthFrac))
        let halfWidth = unitWidth/2
        
        
        unitHeight = CGFloat(screenHeigh/CGFloat(HeightFrac))
        let halfHeight = unitHeight/2
        
        let unitSize = CGSize(width: unitWidth, height: unitHeight)
        
        self.lastUpdateTime = 0
        
        //MARK: 2DMaze construction
        let TwoDMaze = [
            [1,1,0,1,1,1,1,1,1,1],
            [1,0,0,0,0,0,0,0,0,1],
            [1,0,1,1,1,1,0,1,0,1],
            [1,0,1,1,0,0,0,1,0,1],
            [1,0,1,1,0,1,1,1,1,1],
            [1,0,1,1,0,1,1,0,0,1],
            [1,0,0,1,0,0,0,0,1,1],
            [1,1,0,1,1,0,1,0,1,1],
            [1,1,0,1,0,0,1,0,0,1],
            [1,0,0,1,0,1,1,1,1,1],
            [1,0,1,0,0,1,0,0,0,1],
            [1,0,0,0,1,1,0,1,1,1],
            [1,1,0,1,1,0,0,1,0,1],
            [1,0,0,1,0,0,1,1,0,1],
            [1,1,0,1,0,1,1,1,0,1],
            [1,0,0,1,0,1,0,1,0,1],
            [1,0,0,0,0,0,0,0,0,1],
            [1,1,1,0,1,1,1,1,0,1],
            [1,1,0,0,1,1,0,0,0,1],
            [1,1,0,1,1,1,1,1,1,1]
        ]
        
        //MARK: Player Declaration
        player = SKSpriteNode(imageNamed: "Spaceship.png")
        player!.name = "player"
        player!.size = unitSize
        player!.physicsBody = SKPhysicsBody(rectangleOf: unitSize) // define boundary of body
        player!.physicsBody?.isDynamic = true // 2
        player!.physicsBody?.categoryBitMask = PhysicsCategory.Player //
        player!.physicsBody?.affectedByGravity = false
        player!.physicsBody?.collisionBitMask |= PhysicsCategory.Walls    // No bouncing on
        player!.physicsBody?.contactTestBitMask |= PhysicsCategory.Walls   // Contact with bullet
        player!.physicsBody?.allowsRotation = false
        //MARK: Build Initial Gamestate
        for i in 0..<HeightFrac {//can't use CGFloat
            for j in 0..<widthFrac{//can't use CGFloat
                if TwoDMaze[i][j] == 1 {
                    //build walls corresponding the 1's in the 2Dmatrix
                    let Square = SKSpriteNode()
                    Square.color   = .black
                    Square.size = unitSize
                    Square.position = CGPoint(x: self.frame.minX + halfWidth + CGFloat(j) * unitWidth, y:self.frame.minY + halfHeight + CGFloat(i) * unitHeight)
                    Square.physicsBody = SKPhysicsBody(rectangleOf: unitSize)
                    Square.physicsBody?.isDynamic = false // 2
                    Square.physicsBody?.affectedByGravity = false
                    Square.physicsBody?.categoryBitMask = PhysicsCategory.Walls //
                    Square.physicsBody?.collisionBitMask |= PhysicsCategory.Player
                    
                    
                    addChild(Square)
                }else if i == 0 && TwoDMaze[i][j] == 0 {
                    //player starts at the bottom of the labyrinth at the only 'open' area
                    let point = CGPoint(x: self.frame.minX + halfWidth + CGFloat(j) * unitWidth, y:self.frame.minY + halfHeight + CGFloat(i) * unitHeight)
                    print("playing player at \(point)")
                    player!.position = point
                    addChild(player!)
                }
                //make minotaur spawn on top of the exit
            }
        }
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        //MARK: Make Controls
        //TODO: Change static button placement to dynamic placement
        upKey = SKSpriteNode(imageNamed: "rock.png")
        upKey!.name = "UpKey"
        upKey!.position = CGPoint(x:130,y:200)
        upKey!.size = unitSize
        upKey!.alpha = 0.65
        
        downKey = SKSpriteNode(imageNamed: "rock.png")
        downKey!.name = "downKey"
        downKey!.position = CGPoint(x:130,y:60)
        downKey!.size = unitSize
        downKey!.alpha = 0.65
       
        leftKey = SKSpriteNode(imageNamed: "rock.png")
        leftKey!.name = "leftKey"
        leftKey!.position = CGPoint(x:60,y:130)
        leftKey!.size = unitSize
        leftKey!.alpha = 0.65
       
        
        rightKey = SKSpriteNode(imageNamed: "rock.png")
        rightKey!.name = "rightKey"
        rightKey!.position = CGPoint(x:200,y:130)
        rightKey!.size = unitSize
        rightKey!.alpha = 0.65
       
        
        
        addChild(upKey!)
        addChild(downKey!)
        addChild(rightKey!)
        addChild(leftKey!)
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            
            if theNode.name == upKey!.name {
                
                moveDistanceVerticle += unitHeight

                
            }else if theNode.name == rightKey!.name{
                moveDistanceHorizontal += unitWidth

            }else if theNode.name == downKey!.name{
                
                moveDistanceVerticle -= unitHeight
            }else if theNode.name == leftKey!.name{
                moveDistanceHorizontal -= unitWidth
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        //probably 
        if moveDistanceVerticle > 0 {
            player!.position.y += playerSpeed
            moveDistanceVerticle -= playerSpeed
            if moveDistanceVerticle < 0 {
                player!.position.y += moveDistanceVerticle
                moveDistanceVerticle = 0
            }
        }else if moveDistanceVerticle < 0 {
            player!.position.y -= playerSpeed
            moveDistanceVerticle += playerSpeed
            if moveDistanceVerticle > 0 {
                player!.position.y -= moveDistanceVerticle
                moveDistanceVerticle = 0
            }
        }
        
        if moveDistanceHorizontal > 0 {
            player!.position.x += playerSpeed
            moveDistanceHorizontal -= playerSpeed
            if moveDistanceHorizontal < 0 {
                player!.position.y += moveDistanceHorizontal
                moveDistanceHorizontal = 0
            }
        }else if moveDistanceHorizontal < 0 {
            player!.position.x -= playerSpeed
            moveDistanceHorizontal += playerSpeed
            if moveDistanceHorizontal > 0 {
                player!.position.y -= moveDistanceHorizontal
                moveDistanceHorizontal = 0
            }
        }
        // Calculate time since last update
        _ = currentTime - self.lastUpdateTime
        
        
        self.lastUpdateTime = currentTime
    }
}
