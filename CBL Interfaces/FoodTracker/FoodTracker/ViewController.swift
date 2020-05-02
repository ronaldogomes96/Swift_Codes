//
//  ViewController.swift
//  FoodTracker
//
//  Created by Ronaldo Gomes on 01/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Propeties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mealNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Informa que a view controler é o delegate desta variavel
        nameTextField.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    
    //Mostra o keyboard pra digitacao ate o usuario apertar enter / finalizar de escrever
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Esconde o keyboard
        textField.resignFirstResponder()
        return true
    }
    
    //Funcao que é chamada logo apos textFieldShouldReturn
    //Pega o valor digitado no textfield
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }


    //MARK: Actions
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default text"
    }
    
}

