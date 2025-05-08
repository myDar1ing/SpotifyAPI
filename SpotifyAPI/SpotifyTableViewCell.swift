//
//  SpotifyTableViewCell.swift
//  SpotifyAPI
//
//  Created by Adilet Kenesbekov on 08.05.2025.
//

import UIKit
import SDWebImage

class SpotifyTableViewCell: UITableViewCell {
  
  @IBOutlet weak var artWorkImageView: UIImageView!

  @IBOutlet weak var trackNameLabel: UILabel!
  
  @IBOutlet weak var albumNameLabel: UILabel!
  
  @IBOutlet weak var artistNameLabel: UILabel!
  




    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  func setData(music : Music) {
    trackNameLabel.text = music.trackName
    albumNameLabel.text = music.albumName
    artistNameLabel.text = music.artistName
    artWorkImageView.sd_setImage(with: URL(string: music.artWorkUrl))
  }

}
