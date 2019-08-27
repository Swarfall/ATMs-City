//
//  ViewController.swift
//  City ATMs
//
//  Created by admin on 8/19/19.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchTextField.text = ""
    }

    @IBAction func didTapGoToATMsVC(_ sender: Any) {
        isConnectedToNetwork()
    }
    
    func isConnectedToNetwork() {
        if Reachability.isConnectedToNetwork() {
            if cityTextField.text != "" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ATMsViewController") as! ATMsViewController
                vc.requestModel.city = searchTextField.text
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                presentOneActionButtonAlert(title: "Внимание!", message: "Введите город для поиска", buttonTitle: "OK")
            }
        } else {
            presentOneActionButtonAlert(title: "Отсутствует подключение к сети", message: "Проверьте сеть", buttonTitle: "OK")
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

