//
//  CharacterViewCell.swift
//  HarryPotterApp
//
//  Created by Anikin Ilya on 19.10.2022.
//

import UIKit

class CharacterViewCell: UICollectionViewCell {
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    func configure(character: HPCharacter) {
        nameLabel.text = character.name
        
        NetworkManager.shared.fetchImage(from: character.image) { data in
            self.characterImageView.image = UIImage(data: data)
        }
    }
}
