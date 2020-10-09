import UIKit
import PlaygroundSupport

//Criando uma view com tamamnho fixo
let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 480.0))
containerView.backgroundColor = .black

//Criando uma segunda view, do mesmo tamanho que ira interagir com a primeira
let targetView = UIView(frame: CGRect(x: containerView.bounds.midX,
                                      y: containerView.bounds.midY,
                                      width: 50.0,
                                      height: 50.0))
targetView.backgroundColor = .orange

//Adicionando a segunda view na primeira view
containerView.addSubview(targetView)

//Criando o objeto de animacao, instanciando na view principal
let animator = UIDynamicAnimator(referenceView: containerView)

//Animacao de gravidade
//Criando o objeto de gravidade, instanciando na view de target
let gravityBehaviour = UIGravityBehavior(items: [targetView])
gravityBehaviour.angle = .pi / 2.0
gravityBehaviour.magnitude = 2
//Adicionando a animacao de gravidade
animator.addBehavior(gravityBehaviour)

 
//Animacao do item
//Criando o objeto de comportamento do item, podendo ser mais de um item, um array no caso
let dynamicBehaviour = UIDynamicItemBehavior(items: [targetView])
//Adicionando alguns comportamentos, existem outros parametros
dynamicBehaviour.elasticity = 0.8
dynamicBehaviour.friction = 0
dynamicBehaviour.addAngularVelocity(30, for: targetView)
dynamicBehaviour.linearVelocity(for: targetView)
//Adicionando a animacao de comportamento
animator.addBehavior(dynamicBehaviour)

/*
//Comportamento de puxar
//Criando o objeto de push behavior, no modo continuos
let pushContinousBehaviour = UIPushBehavior(items: [targetView], mode: .continuous)
//Colocando a direcao para a direita
pushContinousBehaviour.pushDirection = CGVector(dx: 20, dy: 0)
//Usando magnitude e angulo
pushContinousBehaviour.magnitude = 50
pushContinousBehaviour.angle = 0
//Adicionando a animacao de puxar
animator.addBehavior(pushContinousBehaviour)
*/

/*
//Comportamento de gancho
//Criando o objeto de snap behavior, e fazendo o quanto ele vai movimentar
let snapBehaviour = UISnapBehavior(item: targetView, snapTo: CGPoint(x: 100, y: 100))
animator.addBehavior(snapBehaviour)

//A oscilacao em que o item ira para o outro local
snapBehaviour.damping = 1 // Medium oscillation
*/

//Comportamento de colisao
//Criando o objeto de colisao
let collisionBehaviour = UICollisionBehavior(items: [targetView])
//Adicionando a animacao de colisao
animator.addBehavior(collisionBehaviour)

//Colidindo com os bounds da superview
collisionBehaviour.setTranslatesReferenceBoundsIntoBoundary(with: .zero)

//Colisao com uma view customizada
///collisionBehaviour.addBoundary(withIdentifier: "barrier" as NSCopying,
//                               for: UIBezierPath(ovalIn: containerView.bounds))


//Mostrando no playground
PlaygroundPage.current.liveView = containerView
