//
//  InfoViewController.swift
//  HarryPotterApp
//
//  Created by Anikin Ilya on 19.10.2022.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterBioLabel: UILabel!
    @IBOutlet var secondCharacterBioLabel: UILabel!
    
    var character: HPCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    private func updateView() {
        guard let character = character else { return }
        self.title = character.name
        
        characterBioLabel.text =
                                 """
                                 Name:
                                 \(character.name)
                                 \(!character.alternate_names.isEmpty ? "\nAlso known as:\n" + character.alternate_names.joined(separator: ", ") + "\n" : "")
                                 Species:
                                 \(!character.gender.isEmpty ? character.gender : "") \(!character.species.isEmpty ? character.species : "unknown")
                                 
                                 \(character.wizard ? "Wizzard" : "None wizzard")
                                 
                                 Born:
                                 \(!character.dateOfBirth.isEmpty ? character.dateOfBirth.replacingOccurrences(of: "-", with: ".") : "unknown")
                                 
                                 House:
                                 \(!character.house.rawValue.isEmpty ? character.house.rawValue : "none")
                                 
                                 Blood status:
                                 \(!character.ancestry.isEmpty ? character.ancestry : "unknown")
                                 """

        secondCharacterBioLabel.text =
                                       """
                                       
                                       Wand:
                                       
                                       
                                       Patronus:
                                       \(!character.patronus.isEmpty ? character.patronus : "none")
                                       
                                       \(character.alive ? "Character is alive" : "Character is dead")
                                       
                                       Actor:
                                       \(!character.actor.isEmpty ? character.actor : "none")
                                       \(!character.alternate_actors.isEmpty ? "\nAlternate actors:\n" + character.alternate_actors.joined(separator: ", ") + "\n" : "")
                                       """
        
        getImage()
    }
    
    private func getImage() {
        guard let imageURL = URL(string: character?.image ?? "") else {
            characterImage.image = UIImage(named: "Hogwarts-Crest.png")
            return
        }
        
        NetworkManager.shared.fetchImage(from: imageURL) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                self.characterImage.image = uiImage
            case .failure(let error):
                print(error)
            }
        }
    }
}
