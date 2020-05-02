//
//  ViewController.swift
//  FoodTracker
//
//  Created by Ronaldo Gomes on 01/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Propeties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mealNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
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
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Cancela tudo, caso o usuario aperte cancelar
        dismiss(animated: true, completion: nil)
    }
    
    //Metodo chamado quando o usuario escolhe uma foto
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Pega a imagem original escolhida pelo usuario
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //Seta a imagem escolhia com a variavel da imagem
        photoImageView.image = selectedImage
        
        //Termina a animacao de escolha da imagem
        dismiss(animated: true, completion: nil)
        
    }

    //MARK: Actions
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //Isso faz com que se o usuario tocar na imagem enquanto esta digitando, o keyboard seja descartado
        nameTextField.resignFirstResponder()
        
        //Permite ao usuário escolher mídia da sua biblioteca de fotos
        let imagePickerController = UIImagePickerController()
        
        //Permite que as fotos possam ser escolhidas da biblioteca
        imagePickerController.sourceType = .photoLibrary
        
        //Informa que a view controller é seu delegate
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil )
        
    }
    
}

