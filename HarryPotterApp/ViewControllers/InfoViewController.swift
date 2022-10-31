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
        self.title = character?.name
        
        characterBioLabel.text =
"""
Name: \(character?.name ?? "unknown")
Species: \(character?.gender ?? "") \(character?.species ?? "unknown")
Date of birth: \(character?.dateOfBirth ?? "unknown")
House: \(character?.house.rawValue ?? "unknown") isStudentOrStuff
Ancestry: \(character?.ancestry ?? "unknown")
"""

        secondCharacterBioLabel.text =
"""
isWizard
Wand: 
Patronus:
isAlive
Actor: \(character?.actor ?? "none")
Alternate actors:

"""
        
        getImage()
    }
    
    private func getImage() {
        let imageURL = URL(string: character?.image ?? "")!
        
        if imageURL.pathComponents.isEmpty {
            self.characterImage.image = UIImage(named: "Hogwarts-Crest.png")
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
