//
//  CustomAlertViewController.swift
//  WeatherNow
//
//  Created by Gokul P on 20/02/23.
//

import UIKit

class CustomAlertViewController: UIAlertController {
    
    lazy var menuPressRecognizer: UITapGestureRecognizer = {
        let menuPressRecognizer = UITapGestureRecognizer()
        menuPressRecognizer.addTarget(self, action: #selector(onMenuPressOnRemote))
        menuPressRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        return menuPressRecognizer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuPressHandler()
    }
    
    deinit {
        print("deiniting the Alert")
    }

    func setUpMenuPressHandler() {
        self.view.addGestureRecognizer(menuPressRecognizer)
    }
    
    @objc func onMenuPressOnRemote() {
        self.dismiss(animated: true)
    }
}
