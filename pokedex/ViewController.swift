//
//  ViewController.swift
//  pokedex
//
//  Created by Kennedy Otis on 12/11/15.
//  Copyright © 2015 Kennedy Otis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray         = [Pokemon]()
    var filteredPokemonArray = [Pokemon]()
    var audioPlayer          : AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate   = self
        collectionView.dataSource = self
        searchBar.delegate        = self
        searchBar.returnKeyType   = UIReturnKeyType.Done
        
        initAudioplayer()
        parsePokemonCSV()
    }
    
    func initAudioplayer() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
             let csv = try CSV(contentsOfURL: path)
             let rows = csv.rows
            
            for row in rows {
                 let name   = row["identifier"]!
                 let pokeId = Int(row["id"]!)!
                
                 let poke = Pokemon(name: name, pokeId: pokeId)
                 pokemonArray.append(poke)
            }
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            var poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemonArray[indexPath.row]
                
            }else {
                poke = pokemonArray[indexPath.row]
            }
            
            cell.configureCell(poke)
            return cell
            
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemonArray.count
        }
        return pokemonArray.count
    }
    
    
    //UISearchBarDelegate class
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true) // hides the keyboard
            collectionView.reloadData()
            
        }else {
            inSearchMode = true
            let lowerString = searchBar.text!.lowercaseString
            
            filteredPokemonArray = pokemonArray.filter({$0.name.rangeOfString(lowerString) != nil })
            collectionView.reloadData()
        }
    }
    
 
    //Music button command
    @IBAction func musicButtonPressed(sender: UIButton) {
        
        if audioPlayer.playing {
            audioPlayer.stop()
            sender.alpha = 0.2
        }else {
            audioPlayer.play()
            sender.alpha = 1.0
        }
    }

}

