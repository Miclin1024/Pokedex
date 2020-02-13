//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/12.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {

    @IBOutlet weak var welcomeImageView: UIImageView!
    
    fileprivate let pokedexCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "entry")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    fileprivate let blurEffectView = UIVisualEffectView(effect: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1.2, delay: 0.7, options: .curveEaseInOut, animations: {
            self.welcomeImageView.alpha = 0
            self.toggleOverlayBlur(false)
        }, completion: { finished in
            self.welcomeImageView.removeFromSuperview()
        })
        
        view.insertSubview(pokedexCollectionView, at: 0)
        view.insertSubview(blurEffectView, at: 1)
        self.blurEffectView.effect = UIBlurEffect(style: .light)
        
        self.blurEffectView.frame = view.bounds
        self.blurEffectView.isUserInteractionEnabled = false
        
        pokedexCollectionView.backgroundColor = .white
        pokedexCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        pokedexCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 40).isActive = true
        pokedexCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 40).isActive = true
        pokedexCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        
        pokedexCollectionView.delegate = self
        pokedexCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false);

    }

    func toggleOverlayBlur(_ enabled: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.blurEffectView.effect = enabled ? UIBlurEffect(style: .light) : nil
        }
    }

}

extension PokedexViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pokedexCollectionView.frame.width/3.5, height: pokedexCollectionView.frame.height/3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let entry = pokedexCollectionView.dequeueReusableCell(withReuseIdentifier: "entry", for: indexPath)
        entry.backgroundColor = .lightGray
        
        return entry
    }
    
    
}
