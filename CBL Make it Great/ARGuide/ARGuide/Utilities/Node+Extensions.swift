//
//  Node+Extensions.swift
//  ARGuide
//
//  Created by Ronaldo Gomes on 11/11/20.
//

import Foundation
import SceneKit

extension SCNNode {
    //Retorna todos os nodes nesse file
    public class func allNodes(from file: String) -> [SCNNode] {
        var nodesInFile = [SCNNode]()
        
        do {
            guard let sceneUrl = Bundle.main.url(forResource: file, withExtension: nil ) else {
                //print("Could not find scene file" \(file))
                return nodesInFile
            }
            
            let objScene = try SCNScene(url: sceneUrl, options: [SCNSceneSource.LoadingOption.animationImportPolicy: SCNSceneSource.AnimationImportPolicy.doNotPlay])
            //Pega todos os nodes e joga no array
            objScene.rootNode.enumerateChildNodes({ (node, _) in
                nodesInFile.append(node)
            })
        } catch {}
        
        return nodesInFile
    }
}
