//
//  DetailViewController.swift
//  capstone
//
//  Created by Vanessa Tang on 11/16/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var synopsis: UITextView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var watchingButton: UIButton!
    var anime:Anime!
    @IBAction func didTapStarButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func didTapWatchingButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let imageUrl = anime.images.jpg.imageUrl,

            // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
           let url = URL(string: imageUrl) {

            // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
            Nuke.loadImage(with: url, into: pic)
        }

        // Set the text on the labels
        animeTitle.text = anime.title
        synopsis.text = anime.synopsis
        score.text = "Score: \(anime.score)"
//        starButton.layer.cornerRadius = starButton.frame.width / 2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
