//
//  CoinUIKitViewController.swift
//  swiftUIClicker
//
//  (c) Neofonie Mobile GmbH (2020)
//
//  This computer program is the sole property of Neofonie
//  Mobile GmbH (http://mobile.neofonie.de) and is protected
//  under the German Copyright Act (paragraph 69a UrhG).
//
//  All rights are reserved. Making copies, duplicating,
//  modifying, using or distributing this computer program
//  in any form, without prior written consent of Neofonie
//  Mobile GmbH, is prohibited.
//
//  Violation of copyright is punishable under the German
//  Copyright Act (paragraph 106 UrhG).
//
//  Removing this copyright statement is also a violation.

import UIKit


class CoinUIKitViewController: UIViewController {
        
    lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        
        return imageView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        coinImageView.image = UIImage(named: "euro")
        coinImageView.contentMode = .scaleAspectFit
        coinImageView.isUserInteractionEnabled = true
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(coinTapped))
        
        coinImageView.addGestureRecognizer(tapGest)
    }
    
    var smallCoinImageViews: [UIImageView] = []
    
    @objc func coinTapped(_ gesturereg: UIGestureRecognizer) {
        
        let smallCoinImageView = createSmallCoinImageView(at: coinImageView.center)
        
        view.addSubview(smallCoinImageView)
        
        view.bringSubviewToFront(smallCoinImageView)
        
        animateCoinBounce()
        animateSmallCoinFall(smallCoinImageView: smallCoinImageView)
    }
    
    
    func createSmallCoinImageView(at point: CGPoint) -> UIImageView {
        
        let imageView = UIImageView(image: UIImage(named: "euro"))
        imageView.frame = CGRect(x: point.x, y: point.y, width: 40, height: 40)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }
    
    func animateCoinBounce() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.allowAnimatedContent, .allowUserInteraction, .beginFromCurrentState], animations: {
            self.coinImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { finished in
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [.allowAnimatedContent, .allowUserInteraction, .beginFromCurrentState], animations: {
                self.coinImageView.transform = .identity
            }, completion: nil)
        })
    }
    
    func animateSmallCoinFall(smallCoinImageView: UIView) {
        UIView.animate(withDuration: 1.0, animations: {
            smallCoinImageView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        }) { (finised) in
            smallCoinImageView.removeFromSuperview()
        }
    }
        
}

