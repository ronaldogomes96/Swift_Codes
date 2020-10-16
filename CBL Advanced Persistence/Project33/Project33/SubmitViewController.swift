//
//  SubmitViewController.swift
//  Project33
//
//  Created by Ronaldo Gomes on 16/10/20.
//

import UIKit
import CloudKit

class SubmitViewController: UIViewController {

    var genre: String!
    var comments: String!
    var stackView: UIStackView!
    var status: UILabel!
    var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "You're all set!"
        //Esconde a navigation back button para impedir o usuario de retornar antes do final da submissao
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doSubmission()
    }
    
    //Faz a submissao pro cloudkit
    func doSubmission() {

        //Cria o objeto que sera enviado para o cloudKit, com um nome especifico, nesse caso Whistles
        //Funciona como um dicionario key-value
        let whistleRecord = CKRecord(recordType: "Whistles")
        
        //Adicionando elemntos para esse dicionario
        whistleRecord["genre"] = genre as CKRecordValue
        whistleRecord["comments"] = comments as CKRecordValue
        
        let audioUrl = RecordWhistleViewController.getWhistleURL()
        let whistleAsset = CKAsset(fileURL: audioUrl)
        whistleRecord["audio"] = whistleAsset
        
        //Salvando os dados no icloud, public database
        CKContainer.default().publicCloudDatabase.save(whistleRecord) { [unowned self] record, error in
            //Voltamos para a thread principal para ter acesso aos elementos da interface
            DispatchQueue.main.async {
                //Esse salvamento pode gerar um erro
                if let error = error {
                    //Informa o erro no status
                    self.status.text = "Error: \(error.localizedDescription)"
                    //Para a animacao da view
                    self.spinner.stopAnimating()
                    
                } else { //Caso tenha sido sucesso
                    //Muda o background da tela
                    self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
                    self.status.text = "Done!"
                    self.spinner.stopAnimating()
                    
                    //Chama uma funcao da view controller
                    ViewController.isDirty = true
                }
                
                //De ambas as formas mostra novamente o botao de Done
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
            }
            
        }
        
    }

    //Aciona o botao de voltar quando a requisicao é finalizada
    @objc func doneTapped() {
        //Retorna para a primeira tela da pilha de views, a original
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    //Faz toda a configuracao da interface da view
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor.gray

        //Cria uma stackview, preenchendo toda a tela
        stackView = UIStackView()
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        //Label que ira mostrar o status da submissao pro icloud
        status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Submitting…"
        status.textColor = UIColor.white
        status.font = UIFont.preferredFont(forTextStyle: .title1)
        status.numberOfLines = 0
        status.textAlignment = .center

        //Animacao do carregamento
        spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()

        //Adiciona na stack view
        stackView.addArrangedSubview(status)
        stackView.addArrangedSubview(spinner)
    }
    
}
