
/*
    -  Quando se usa o coreml ele roda no bundle com o app e vai a app store junto com o aplicativo
    - Nestes cenarios, voce so consegue atualizar o modelo ml se atualizar o app
     - Com o model deployment voce consegue atualizar o modelo ml via apple cloud
    - Isso ajuda na flexibilizacao do modelo
     - Essa nova funcaoa ajuda em tres aspectos
 
    1 -> Deixa o desenvolvimento independente
        - Com isso voce consegue atualizar o modelo sem atualizar o codigo
    2 -> Colecao de modelo ml
        - Esse modelos trabalham juntos
        - Voce consegue agrypar os modelos e isso cria uma colecao de modelo
        Esses modelos sao atualizados a qualquer momento pelo dev
    3 -> Alvos para o modelo
        - Podemos mudar o modelo para algum device especifico
         - Ajuda a melhorar as features de cada device
 */

//Codigos usados

//Classificacao usando coreml model deployment

import CoreML
private func classifyFlower(in image: CGImage) {
    // Check for a loaded model
    if let model = flowerClassifier {
        classify(image, using: model)
        return
    }
  
    MLModelCollection.beginAccessing(identifier: "FlowerModels") { [self] result in
        var modelURL: URL?
        switch result {
        case .success(let collection):
            modelURL = collection.entries["FlowerClassifier"]?.modelURL
        case .failure(let error):
            handleModelCollectionFailure(for: error)
        }
                                                           
        let result = loadFlowerClassifier(from: modelURL)
                                                           
        switch result {
        case .success(let model):
            classify(image, using: model)
        case .failure(let error):
            handleModelLoadFailure(for: error)
        }
    }
}

func loadFlowerClassifier(from modelURL: URL?) -> Result<FlowerClassifier, Error> {
    if let modelURL = modelURL {
        return Result { try FlowerClassifier(contentsOf: modelURL) }
    } else {
        return Result { try FlowerClassifier(configuration: .init()) }
    }
}

//Encripitando o modelo

--encrypt "$SRCROOT/HelloFlowers/Models/FlowerStylizer.mlmodelkey"

[Production note] or if we're tight for horizontal space we can use this:

--encrypt "$SRCROOT/.../FlowerStylizer.mlmodelkey"

//Trabalhando com o modelo encriptado

func stylizeImage() {
    // If we already loaded the model, apply the effect
    if let model = flowerStylizer {
        applyStyledEffect(using: model)
        return
    }
        
    // Otherwise load and apply
    FlowerStylizer.load { [self] result in
            
        switch result {

        case .success(let model):
            flowerStylizer = model
            DispatchQueue.main.async {
                applyStyledEffect(using: model)
            }
                
        case .failure(let error):
            handleFailure(for: error)
                
        }
    }
}

func handleFailure(for error: Error) {
    switch error {
    case MLModelError.modelKeyFetch:
        handleNetworkFailure()
            
    default:
        handleModelLoadError(error)
    }
}
