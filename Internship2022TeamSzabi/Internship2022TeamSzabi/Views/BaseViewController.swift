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
    }
    
    func startLoadingIndicator() {
        baseView = UIView(frame: view.bounds)
        baseView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        
        let baseView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        baseView.center = baseView.center
        baseView.startAnimating()
        baseView.addSubview(baseView)
        view.addSubview(baseView)
    }
    
    func stopLoadingIndicator() {
        baseView?.removeFromSuperview()
        baseView = nil
    }
}
