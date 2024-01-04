//
//  SearchResult.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 04.01.2024.
//

import UIKit

class SearchResult: UIViewController {
    
    // MARK: - UI
    
    let textField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.layer.cornerRadius = 10
        return textField
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

