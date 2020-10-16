//
//  AddCommentsViewController.swift
//  Project33
//
//  Created by Ronaldo Gomes on 16/10/20.
//

import UIKit

class AddCommentsViewController: UIViewController, UITextViewDelegate {
    
    var genre: String!
    var comments: UITextView!
    let placeholder = "If you have any additional comments that might help identify your tune, enter them here."

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Comments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
        comments.text = placeholder
    }
    
    //Cria textfield com tamanho auto ajustavel e suas constraints
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        comments = UITextView()
        comments.translatesAutoresizingMaskIntoConstraints = false
        comments.delegate = self
        comments.font = UIFont.preferredFont(forTextStyle: .body)
        view.addSubview(comments)

        comments.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        comments.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        comments.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        comments.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    //Funcao que conclui os comentarios
    @objc func submitTapped() {
        let vc = SubmitViewController()
        vc.genre = genre

        //Caso seja o placeholder nao passa nada
        if comments.text == placeholder {
            vc.comments = ""
        } else {
            vc.comments = comments.text
        }

        navigationController?.pushViewController(vc, animated: true)
    }
    
    //Caso comece a digitar entao o placeholder desaparece
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }

}
