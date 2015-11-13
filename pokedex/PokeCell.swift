//
//  PokeCell.swift
//  pokedex
//
//  Created by Kennedy Otis on 12/11/15.
//  Copyright © 2015 Kennedy Otis. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var pokeThumbImg: UIImageView!
    @IBOutlet weak var nameLabel:UILabel!
    
    //Pokemon obj variable
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLabel.text     = self.pokemon.name.capitalizedString
        pokeThumbImg.image = UIImage(named: "\(self.pokemon.pokeId)")
    }
    
    
}
