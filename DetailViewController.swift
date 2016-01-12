//
//  DetailViewController.swift
//  Pokeman
//
//  Created by MR_gong on 16/1/11.
//  Copyright © 2016年 gong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var pokeman:Pokeman!
    
    
    @IBOutlet weak var nameLbl: UILabel!
    
 
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var baseattackLbl: UILabel!
    @IBOutlet weak var pokeIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    @IBOutlet weak var evoLbl: UILabel!
    
    @IBOutlet weak var nextEvoImg: UIImageView!

    @IBOutlet weak var currentEvoImg: UIImageView!
    
    
    @IBAction func returnBtnPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokeman.name
        let img = UIImage(named: "\(pokeman.pokeIndexId)")
        
        
        mainImg.image = img
        
        currentEvoImg.image = img
        
        pokeman.downloadPokemonDetails { () -> () in
            self.updateUI()
        }

        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        descriptionLbl.text = pokeman.description
        typeLbl.text = pokeman.type
        defenseLbl.text = pokeman.defense
        heightLbl.text = pokeman.height
        weightLbl.text = pokeman.weight
        baseattackLbl.text = pokeman.attack
        pokeIDLbl.text = "\(pokeman.pokeIndexId)"
        if pokeman.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImg.hidden = true
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokeman.nextEvolutionId)
            var str = "Next Evolution: \(pokeman.nextEvolutionTxt)"
            
            if pokeman.nextEvolutionLvl != "" {
                str += " - LVL \(pokeman.nextEvolutionLvl)"
            }
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
