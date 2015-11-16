//
//  Pokemon.swift
//  pokedex
//
//  Created by Kennedy Otis on 12/11/15.
//  Copyright © 2015 Kennedy Otis. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    //Member variables
    private var _name: String!
    private var _pokeId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _pokemon_url: String!
    
    
    //Initialize
    init(name: String, pokeId: Int) {
        _name   = name
        _pokeId = pokeId
        _pokemon_url = "\(BASE_URL)\(POKEMON_URL)\(self._pokeId)/"
        
    }
    
    //Getters
    var pokeId: Int {
        return _pokeId
    }
    
    var name: String {
        return _name
    }
    
    var description: String {
        return _description
    }
    
    var type:String {
        return _type
    }
    
    var defense: String {
        return _defense
    }
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    func downloadPokemonDetails(completed: DownloadCompleted) {
        let url =  NSURL(string: _pokemon_url)!
       
        Alamofire.request(.GET, url).responseJSON { response in
           
            if let dic = response as? Dictionary<String, AnyObject> {
                print(dic)
            }
        }
    }
    
}
