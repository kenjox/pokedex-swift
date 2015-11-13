//
//  Pokemon.swift
//  pokedex
//
//  Created by Kennedy Otis on 12/11/15.
//  Copyright © 2015 Kennedy Otis. All rights reserved.
//

import Foundation

class Pokemon {
    
    //Member variables
    private var _name: String!
    private var _pokeId: Int!
    
    //Initialize
    init(name: String, pokeId: Int) {
        _name   = name
        _pokeId = pokeId
    }
    
    //Getters
    var name: String {
        return _name
    }
    
    var pokeId: Int {
        return _pokeId
    }
    
}
