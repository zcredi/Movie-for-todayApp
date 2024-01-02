//
//  AboutUSViewController.swift
//  Movie for todayApp
//
//  Created by Andrei Shpartou on 02/01/2024.
//

import UIKit

class AboutUSViewController: UIViewController {

    private lazy var textView = setupTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
    }
    
    func setupTextView() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .primaryDark
        textView.font = .systemFont(ofSize: 15.0)
        textView.textColor = .textColorWhiteGrey
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text =
        """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit.Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                        
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                        
            Lorem ipsum dolor sit amet, consectetur adipiscing elit.Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                                                
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.
                        
        """
        return textView
    }
    
    func setupView() {
        view.backgroundColor = .primaryDark
        title = "About Us"
        view.addSubview(textView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10.0),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
