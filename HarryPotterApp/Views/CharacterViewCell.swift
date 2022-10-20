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
    
    private var activityIndicator: UIActivityIndicatorView?
    private var imageURL: URL? {
        didSet {
            characterImageView.image = nil
            updateImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: characterImageView)
    }
    
    func configure(character: HPCharacter) {
        nameLabel.text = character.name
        imageURL = URL(string: character.image)
        
        switch character.house {
        case .gryffindor:
            nameLabel.textColor = #colorLiteral(red: 0.9502467513, green: 0.7710905075, blue: 0.2408055663, alpha: 1)
            nameLabel.backgroundColor = #colorLiteral(red: 0.7453323007, green: 0.09828463942, blue: 0, alpha: 1)
        case .ravenclaw:
            nameLabel.textColor = #colorLiteral(red: 0.7966603637, green: 0.497176826, blue: 0.2289692163, alpha: 1)
            nameLabel.backgroundColor = #colorLiteral(red: 0.1769760251, green: 0.2600095272, blue: 0.5711880326, alpha: 1)
        case .hufflepuff:
            nameLabel.textColor = #colorLiteral(red: 0.5231904387, green: 0.4596741796, blue: 0.4075018466, alpha: 1)
            nameLabel.backgroundColor = #colorLiteral(red: 0.9438773394, green: 0.7680730224, blue: 0.2834273279, alpha: 1)
        case .slytherin:
            nameLabel.textColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
            nameLabel.backgroundColor = #colorLiteral(red: 0.2067463994, green: 0.4526081085, blue: 0.3057038784, alpha: 1)
        case .none:
            nameLabel.textColor = #colorLiteral(red: 0.6274509804, green: 0.6823529412, blue: 0.862745098, alpha: 1)
            nameLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
                completion(.success(uiImage))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        if imageURL.pathComponents.isEmpty {
            self.characterImageView.image = UIImage(named: "Hogwarts-Crest.png")
            return
        }
        getImage(from: imageURL) {[weak self] result in
            switch result {
            case .success(let image):
                if imageURL == self?.imageURL {
                    self?.characterImageView.image = image
                    self?.activityIndicator?.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
