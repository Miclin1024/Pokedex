//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2020/2/15.
//  Copyright © 2020 Michael Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var typeImageStackView: UIStackView!
    
    var showPokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let target = showPokemon {
            self.pokemonName.text = target.name
            self.pokemonID.text = "#" + String(target.id)
            self.pokemonImage.kf.setImage(with: URL(string: target.imageUrlLarge))
            
            typeImageStackView.distribution = .fillEqually
            for index in 0 ..< target.types.count {
                let typeImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                typeImage.image = UIImage(named: target.types[index].rawValue)
                typeImage.contentMode = .scaleAspectFit
                typeImageStackView.addArrangedSubview(typeImage)
            }
            
            
    
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
