//
//  PokemanCell.swift
//  Pokeman
//
//  Created by MR_gong on 16/1/11.
//  Copyright © 2016年 gong. All rights reserved.
//

import UIKit

class PokemanCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemanImg:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    
    
    var pokeman:Pokeman!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius  = 5
    }
    
    func configCell(pokeman:Pokeman){
        self.pokeman = pokeman
        self.nameLbl.text = self.pokeman.name.capitalizedString
        self.pokemanImg.image = UIImage(named: "\(self.pokeman.pokeIndexId)")
    }
    
    
    

}
