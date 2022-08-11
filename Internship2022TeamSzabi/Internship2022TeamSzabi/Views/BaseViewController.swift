//
//  BaseViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/11/22.
//

import UIKit

class BaseViewController: UIViewController {
    private var baseView: UIView?
    private var nextView: UIView?
    private var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBackButton()
    }
    
    func setupBackButton() {
        let backImage = UIImage(named: "BackArrow")
        navigationController?.navigationBar.backIndicatorImage = backImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationItem.backButtonTitle = ""
    }
    
    func dismissKeyboard() {
        // this allows the user to dismiss the keyboard by tapping anywhere on the screen
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func startLoadingIndicator() {
        baseView = UIView(frame: self.view.bounds)
        baseView?.backgroundColor = UIColor.white
        
        let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityView.center = baseView!.center
        activityView.startAnimating()
        baseView?.addSubview(activityView)
        self.view.addSubview(baseView!)
    }
    
    func stopLoadingIndicator() {
        baseView?.removeFromSuperview()
        baseView = nil
    }
}
