//
//  GameScene.swift
//  juego
//
//  Created by DAM on 11/4/18.
//  Copyright © 2018 DAM. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    //personaje
    var personaje = SKSpriteNode()
    //background
    var fondo = SKSpriteNode()
    //barril
    var barril = SKSpriteNode()
    //plataforma
    var ground = SKSpriteNode()
    //trampa
    var trampa = SKSpriteNode()
    var trampa2 = SKSpriteNode()
    //banana
    var banana = SKSpriteNode()
    
    //texturas persoanje
    var texturaPersonaje = SKTexture()
    var texturaPersonaje2 = SKTexture()
    var texturaPersonaje3 = SKTexture()
    var texturaPersonaje4 = SKTexture()
    var texturaPersonaje5 = SKTexture()
    var texturaPersonaje6 = SKTexture()
    var texturaPersonaje7 = SKTexture()

    //textura trampa
    var texturaTrampa = SKTexture()
    var texturaTrampa2 = SKTexture()
    
    //textura barril
    var texturaBarril = SKTexture(imageNamed: "barril1")
    //textura banana
    var texturaBanan = SKTexture(imageNamed: "banana1")
    
    //textura suelo
    var texturaSuelo = SKTexture()
    
    //velocity  signo
    var velocidadX = true
    
    //timer
    var timer = Timer()
    var timervx = Timer()
    var timervx2 = Timer()
    var timerB = Timer()
    
    //tipo de objeto
    var tipoObjeto = ["beer1.png","imagen2","imagen3"]
    
    //gameover
    var gameover = false
    
    //score
    var scoreLabel:SKLabelNode!
    var gameoverLabel:SKLabelNode!
    var score:Int = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    //nodos
   
    struct tipoNodoo {
        static let personaje : UInt32 = 1
        static let ground : UInt32 = 2
        static let barril : UInt32 = 4
        static let trampa : UInt32 = 6
        static let banana : UInt32 = 8
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        restart()
    }
    func restart(){
        
        crearPersonaje()
        crearFondo()
        crearTrampas()
        crearBarril()
        crearSuelo()
        crearBanana()
        timerB = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(self.crearBanana), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.crearBarril), userInfo: nil, repeats: true)
       scorePersoanje()
    }
    func scorePersoanje(){
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: -100, y: self.frame.maxY-40)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.red
        scoreLabel.zPosition = 1
        score = 0
        
        self.addChild(scoreLabel)
    }
    func printGameOver() {
        gameoverLabel = SKLabelNode(text: "GAME OVER")
        gameoverLabel.position = CGPoint(x: -10, y: self.frame.maxY-100)
        gameoverLabel.fontName = "AmericanTypewriter-Bold"
        gameoverLabel.fontSize = 36
        gameoverLabel.fontColor = UIColor.red
        gameoverLabel.zPosition = 1
       
        
        self.addChild(gameoverLabel)
    }
    func crearTrampas(){
        //trampa1
        texturaTrampa = SKTexture(imageNamed: "trap")
        trampa = SKSpriteNode(texture: texturaTrampa)
        trampa.size.width = 100
        trampa.size.height = 120
        trampa.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        trampa.position = CGPoint(x: -((self.frame.width/2)-40), y: -500)
        trampa.physicsBody = SKPhysicsBody(rectangleOf: texturaTrampa.size())
        trampa.physicsBody!.isDynamic = false
        trampa.zPosition = 0
        
        //categoria
        trampa.physicsBody!.categoryBitMask = tipoNodoo.trampa
        //colison
        trampa.physicsBody!.collisionBitMask = tipoNodoo.personaje

        trampa.physicsBody!.contactTestBitMask = tipoNodoo.personaje
        
        
        texturaTrampa2 = SKTexture(imageNamed: "trap2")
        trampa2 = SKSpriteNode(texture: texturaTrampa2)
        trampa2.size.width = 100
        trampa2.size.height = 120
        trampa2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        print((self.frame.width/2)-self.texturaTrampa.size().width)
        trampa2.position = CGPoint(x: +((self.frame.width/2)-40), y: -550)
        trampa2.physicsBody = SKPhysicsBody(rectangleOf: texturaTrampa.size())
        trampa2.physicsBody!.isDynamic = false
        trampa2.zPosition = 0
        
        //categoria
        trampa2.physicsBody!.categoryBitMask = tipoNodoo.trampa
        //colison
        trampa2.physicsBody!.collisionBitMask = tipoNodoo.personaje
        
        trampa2.physicsBody!.contactTestBitMask = tipoNodoo.personaje

        self.addChild(trampa)
        self.addChild(trampa2)
    }
    func crearPersonaje() {
        
        //Asignacion de texturas
        texturaPersonaje = SKTexture(imageNamed: "donky1")
        texturaPersonaje2 = SKTexture(imageNamed: "donky11")
        texturaPersonaje3 = SKTexture(imageNamed: "donky2")
        texturaPersonaje4 = SKTexture(imageNamed: "donky3")
        texturaPersonaje5 = SKTexture(imageNamed: "donky4")
        texturaPersonaje6 = SKTexture(imageNamed: "donkey5")
        texturaPersonaje7 = SKTexture(imageNamed: "donkey6")
        
        
        let animacion = SKAction.animate(with: [texturaPersonaje,texturaPersonaje2,texturaPersonaje3,texturaPersonaje4,texturaPersonaje5,texturaPersonaje6,texturaPersonaje7], timePerFrame: 0.2)
        
        let animacionInfinita = SKAction.repeatForever(animacion)
        
        //textura inicial
        personaje = SKSpriteNode(texture: texturaPersonaje)
        
        //Posicion inicial
        personaje.position = CGPoint(x: self.frame.midX, y: self.frame.minY+100)
        
        //fisicas al personaje
        
        personaje.physicsBody = SKPhysicsBody(rectangleOf: texturaPersonaje.size())
        
        //iniciar persoanje true/false
        
        
        personaje.physicsBody?.isDynamic  = false
        
        personaje.scale(to: CGSize(width: 90, height:90))
        
        //categoria
        personaje.physicsBody!.categoryBitMask = tipoNodoo.personaje
        //colison
        personaje.physicsBody!.collisionBitMask = tipoNodoo.ground
        
        personaje.physicsBody!.contactTestBitMask = tipoNodoo.ground
        
        
        //aplicar animacion
        personaje.run(animacionInfinita)
        personaje.zPosition = 0
        personaje.physicsBody!.velocity = CGVector(dx:0,dy:0)
        
        
        self.addChild(personaje)
    }
    func crearFondo(){
        
        //textura fondo
        let textura = SKTexture(imageNamed: "fondo")
        
        let movimientoFondo =  SKAction.move(by: CGVector(dx: 0, dy: 0), duration: 4)
        
        let movimientoFondoOrigen = SKAction.move(by: CGVector(dx:0, dy: 0), duration: 0)
        
        let movimientoInfinitoFondo = SKAction.repeatForever(SKAction.sequence([movimientoFondo, movimientoFondoOrigen]))
        
        // contador de fondos
     
            // Le ponemos la textura al fondo
            fondo = SKSpriteNode(texture: textura)
            
            // Indicamos la posición inicial del fondo
            fondo.position = CGPoint(x:self.frame.midX, y: textura.size().height*0)
            
            // Estiramos la altura de la imagen para que se adapte al alto de la pantalla
            fondo.size.width = self.frame.width
            fondo.size.height = self.frame.height
            
            // Indicamos zPosition para que quede detrás de todo
            fondo.zPosition = -1
            
            // Aplicamos la acción
            fondo.run(movimientoInfinitoFondo)
            // Ponemos el fondo en la escena
        
            self.addChild(fondo)
            

    }
   
    @objc func crearBarril(){
        
        
        let borrarBarriles = SKAction.removeFromParent()
        
        let moverBarril = SKAction.move(by: CGVector(dx: self.frame.midX, dy: -1 * self.frame.height), duration: TimeInterval(20))
        
        let moverBorrar = SKAction.sequence([moverBarril, borrarBarriles])
        let widthparammax = UInt32(self.frame.width)
        
        let widthparam = CGFloat(375)
        let xrandom = CGFloat(arc4random_uniform(widthparammax))-widthparam
        
        
        barril = SKSpriteNode(texture: texturaBarril)
        barril.position = CGPoint(x: xrandom, y: self.frame.maxY)
        barril.zPosition = 0
        barril.physicsBody = SKPhysicsBody(rectangleOf:self.texturaBarril.size())
        barril.physicsBody?.isDynamic = true
        barril.scale(to: CGSize(width: 50, height: 80))
        
        barril.physicsBody!.categoryBitMask = tipoNodoo.barril
        
        barril.physicsBody!.collisionBitMask = tipoNodoo.personaje
        
        barril.physicsBody!.contactTestBitMask = tipoNodoo.personaje
        
        barril.run(moverBorrar)
        
        self.addChild(barril)
    }
    @objc func crearBanana(){
        
        
        let borrarBananas = SKAction.removeFromParent()
        
        let moverBananas = SKAction.move(by: CGVector(dx: self.frame.midX, dy: -1 * self.frame.height), duration: TimeInterval(20))
        
        let moverBorrar = SKAction.sequence([moverBananas, borrarBananas])
        let widthparammax = UInt32(self.frame.width)
        
        let widthparam = CGFloat(375)
        let xrandom = CGFloat(arc4random_uniform(widthparammax))-widthparam
        
        
        banana = SKSpriteNode(texture: texturaBanan)
        banana.position = CGPoint(x: xrandom, y: self.frame.maxY)
        banana.zPosition = 0
        banana.physicsBody = SKPhysicsBody(rectangleOf:self.texturaBanan.size())
        banana.physicsBody?.isDynamic = true
        banana.scale(to: CGSize(width: 50, height: 80))
        
        banana.physicsBody!.categoryBitMask = tipoNodoo.banana
        
        banana.physicsBody!.collisionBitMask = tipoNodoo.personaje
        
        banana.physicsBody!.contactTestBitMask = tipoNodoo.personaje
        
        banana.run(moverBorrar)
        
        self.addChild(banana)
    }
    
    func crearSuelo(){
        
        texturaSuelo = SKTexture(imageNamed: "plata")
        ground = SKSpriteNode(texture: texturaSuelo)
        ground.size.width = (self.scene?.size.width)!
        ground.size.height = 100
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ground.position = CGPoint(x: CGFloat(0) * ground.size.width, y: -(self.frame.size.height / 2))
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 100))
        
        ground.physicsBody!.isDynamic = false
        //contacto
        ground.physicsBody!.categoryBitMask = tipoNodoo.ground
        ground.physicsBody!.collisionBitMask = tipoNodoo.personaje
        ground.physicsBody!.contactTestBitMask = tipoNodoo.personaje
        
        ground.zPosition = 0
        
        self.addChild(ground)
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if gameover == false {
            // En cuanto el usuario toque la pantalla le damos dinámica a la mosquita (caerá)
            personaje.physicsBody!.isDynamic = true
            
            
            // Le damos una velocidad a la mosquita para que la velocidad al caer sea constante
            if(velocidadX){
                timervx2.invalidate()
                timervx = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.constantVelocityP), userInfo: nil, repeats: true)
                velocidadX = false
            }else{
                timervx.invalidate()
                timervx2 = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.constantVelocityN), userInfo: nil, repeats: true)
                velocidadX = true
            }
            
            // Le aplicamos un impulso a la mosquita para que suba cada vez que pulsemos la pantalla
            // Y así poder evitar que se caiga para abajo
            personaje.physicsBody!.applyImpulse(CGVector(dx: 0, dy: 0))
        } else {
            
            gameover = false
            self.removeAllChildren()
            restart()
        }
        
    }
    @objc func constantVelocityP(){
        
        personaje.physicsBody!.velocity = CGVector(dx: 200, dy: 0)
        
    }
    @objc func constantVelocityN(){
        
        personaje.physicsBody!.velocity = CGVector(dx: -200, dy: 0)
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        // en contact tenemos bodyA y bodyB que son los cuerpos que hicieron contacto
        let cuerpoA = contact.bodyA
        let cuerpoB = contact.bodyB
        // Miramos si la mosca ha pasado por el hueco
        if (cuerpoA.categoryBitMask == tipoNodoo.personaje && cuerpoB.categoryBitMask == tipoNodoo.barril) || (cuerpoA.categoryBitMask == tipoNodoo.barril && cuerpoB.categoryBitMask == tipoNodoo.personaje) {
            if (score > 0){
                score -= 1
            }
            if(cuerpoA.categoryBitMask == tipoNodoo.barril){
                cuerpoA.node?.removeFromParent()
            }else if(cuerpoB.categoryBitMask == tipoNodoo.barril){
                cuerpoB.node?.removeFromParent()
            }
            print(score)
            scoreLabel.text = String(score)
        }else if (cuerpoA.categoryBitMask == tipoNodoo.trampa && cuerpoB.categoryBitMask == tipoNodoo.personaje) || (cuerpoA.categoryBitMask == tipoNodoo.personaje && cuerpoB.categoryBitMask == tipoNodoo.trampa) {
            gameover = true
            printGameOver()
            
        }
        else if (cuerpoA.categoryBitMask == tipoNodoo.trampa && cuerpoB.categoryBitMask == tipoNodoo.personaje) || (cuerpoA.categoryBitMask == tipoNodoo.personaje && cuerpoB.categoryBitMask == tipoNodoo.trampa) {
            gameover = true
            printGameOver()
            
        }else if (cuerpoA.categoryBitMask == tipoNodoo.personaje && cuerpoB.categoryBitMask == tipoNodoo.banana) || (cuerpoA.categoryBitMask == tipoNodoo.banana && cuerpoB.categoryBitMask == tipoNodoo.personaje) {
            
            score += 1
            print("panda")
            if(cuerpoA.categoryBitMask == tipoNodoo.banana){
                cuerpoA.node?.removeFromParent()
            }
            else if(cuerpoB.categoryBitMask == tipoNodoo.banana){
                cuerpoB.node?.removeFromParent()
            }
            print(score)
            scoreLabel.text = String(score)
            
        }
        
    }
    
}
