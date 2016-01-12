//
//  ViewController.swift
//  Pokeman
//
//  Created by MR_gong on 16/1/11.
//  Copyright © 2016年 gong. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController ,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var searchbarView: UISearchBar!
    @IBOutlet weak var collectionView:UICollectionView!
    
    var pokemans = [Pokeman]()
    var filterpokemans = [Pokeman]()
    var isEditMode = false
    
    @IBOutlet weak var musicBtn: UIButton!
    var musicPlayer:AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchbarView.delegate = self
        searchbarView.returnKeyType = UIReturnKeyType.Done
        parsePokemanCSV()
        initAudio()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func musicPlayPress(sender: AnyObject) {
        if musicPlayer.playing{
            musicPlayer.stop()
            let btn = sender as? UIButton
            btn?.alpha = 1
            
        }else{
            musicPlayer.play()
            let btn = sender as! UIButton
            btn.alpha = 0.2
        }
        
    }
    
    func initAudio(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            musicBtn.alpha = 0.2
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func parsePokemanCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL:path)
            let rows = csv.rows
            for row in rows {
                let pokeid = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokeman(name: name, pokeInd: pokeid)
                pokemans.append(poke)
            }
        }catch{
            
        }
        
        
        
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isEditMode {
            return filterpokemans.count
        }else{
        return pokemans.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var currentPokes = [Pokeman]()
        if isEditMode{
            currentPokes  = filterpokemans
        }else{
            currentPokes = pokemans
        }
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokemanCell {
            
            let pokeman = currentPokes[indexPath.row]
            cell.configCell(pokeman)
            return cell
            
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poke : Pokeman
        if isEditMode {
            poke = filterpokemans[indexPath.row]
        }else{
            poke = pokemans[indexPath.row]
        }
        
        performSegueWithIdentifier("PokeDetailVC", sender: poke)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isEditMode = false
            view.endEditing(true)
            collectionView.reloadData()
        }else{
            isEditMode = true
            let text = searchBar.text!.lowercaseString
            filterpokemans =  pokemans.filter({ $0.name.rangeOfString(text) != nil})
            collectionView.reloadData()
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokeDetailVC"{
            if let detailvc = segue.destinationViewController as? DetailViewController{
                let poke = sender as? Pokeman
                detailvc.pokeman = poke
            }
            
        }
    }




}

