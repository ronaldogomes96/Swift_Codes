//
//  ViewController.swift
//  FoodTracker
//
//  Created by Ronaldo Gomes on 01/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Propeties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //Propiedade da classe meal, um opcional
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Informa que a view controler é o delegate desta variavel
        nameTextField.delegate = self
        
        //Entra no if quando for uma edicao de uma meal ja existente
        if let meal = meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //Ative o botão Salvar apenas se o campo de texto tiver um nome de refeição válido.
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    
    //É chamado quando uma secao de edicao do textfield é exibido
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //Desativa o botao save enquanto essa opcao esta ativa
        saveButton.isEnabled = false
    }
    
    //Mostra o keyboard pra digitacao ate o usuario apertar enter / finalizar de escrever
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Esconde o keyboard
        textField.resignFirstResponder()
        return true
    }
    
    //Funcao que é chamada logo apos textFieldShouldReturn
    //Pega o valor digitado no textfield
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //Verifica se o nome esta vazio
        updateSaveButtonState()
        navigationItem.title = textField.text
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
    
    //MARK: Navigation
    
    //Acao do botao cancelar
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        //Dependendo do tipo de apresentacao, ele deve ser cancelado de uma forma diferente
        
        //Valor boleano que indica se a pagina foi aberta pelo botao de adicionar
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode{
            //Cancela a modal e retorna para a pagina anterior sem salvar nada
            dismiss(animated: true, completion: nil)
        }
        //É chamado se o usuário estiver editando uma refeição existente
        else if let owningNavigationController = navigationController{
            //Retorna na pilha de execucao
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
        
    }
    
    
    // Permite configurar um view controller antes de ser apresentado.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Configura o destino apenas quando o savebutton for pressionado
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        //Cria as constantes a partir do campo de texto atual, da imagem selecionada e da classificação na cena.
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Passa a meal para a classe
        meal = Meal(name: name, photo: photo, rating: rating)
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
    
    //MARK: Private Methods
    
    private func updateSaveButtonState(){
        
        //Desativa o botao salvar se o campo de texto estiver vazio
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

