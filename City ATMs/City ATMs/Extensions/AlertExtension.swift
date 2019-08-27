//
//  AlertExtension.swift
//  City ATMs
//
//  Created by admin on 8/19/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController {
    
    func presentOneActionButtonAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
