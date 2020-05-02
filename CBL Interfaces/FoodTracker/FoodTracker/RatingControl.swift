//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Ronaldo Gomes on 02/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    //Definem o tamanho e quantos botoes irao ter na tela
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        //Chama a funcao a cada vez que a variavel é alterada
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        //Chama a funcao a cada vez que a variavel é alterada
        didSet{
           setupButtons()
        }
    }
    
    //Lista de botoes
    private var ratingButtons = [UIButton]()
    
    //Classificacao do usuario
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    
    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButtons()
    }
    
    //MARK: Button Action
    
    //Acao para quando o botao for pressionado
    @objc func ratingButtonTapped(button: UIButton) {
        
        //Retorna o indice do botao selecionado
        guard let index = ratingButtons.firstIndex(of: button) else{
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        //Calculando a classificacao do botao
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    
    //MARK: Private Methods
    
    //Configuracao e criacao do botao
    private func setupButtons(){
        
        //Excluindo os botoes existentes
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Carregando as imagens dos botoes
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
       
        //Criando os 5 botoes de classificacao
        for index in 0..<starCount {
            
            //Criando um botao
            let button = UIButton()
            
            //Setando suas imagens de acordo com o estado do botao
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            //Adicionando constraints
            //Desabilita as restricoes geradas automaticamente
            button.translatesAutoresizingMaskIntoConstraints = false
            
            //Restricoes de altura e largura
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //Setando as labels de acessibilidade
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //Button action
            //anexando o método ratingButtonTapped(_:) de ação ao objeto button, que será acionado sempre que o .TouchDownevento ocorrer.
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //Adicionando o button a view
            addArrangedSubview(button)
            
            //Adicionando o botao ao array de botoes
            ratingButtons.append(button)
            
            //Atualiza o estado de selecao dos botoes
            updateButtonSelectionStates()
        }
    }
    
    //Atualiza o estado da selecao do botao
    private func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated(){
            
            //Se o indice do botao for menor que a classificao, o botao deve ser selecionado
            button.isSelected = index < rating
            
            //Se o botao for acionado, é chamada uma dica
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            //Calculando o valor da string
            let valueString: String
            switch rating {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            //Seta os valores nas propiedades
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
}
