//
//  ProfileViewController.swift
//  capstone
//
//  Created by Vanessa Tang on 11/17/23.
//

import UIKit
import Nuke

class ProfileViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var profileTableView: UITableView!
    var starredList:[Anime] = []
    var watchingList:[Anime] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return starredList.count
        }
        else {
            return watchingList.count
        }
//        return starredList.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if starredList.count != 0 {
                return "Starred"
            }
        }
        else {
            if watchingList.count != 0 {
                return "Watching"
            }
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create, configure and return a table view cell for the given row (i.e. `indexPath.row`)

//        print("🍏 cellForRowAt called for row: \(indexPath.row)")

        // Get a reusable cell
        // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table. This helps to optimize table view performance as the app only needs to create enough cells to fill the screen and can reuse cells that scroll off the screen instead of creating new ones.
        // The identifier references the identifier you set for the cell previously in the storyboard.
        // The `dequeueReusableCell` method returns a regular `UITableViewCell` so we need to cast it as our custom cell (i.e. `as! MovieCell`) in order to access the custom properties you added to the cell.
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "AnimeCell", for: indexPath) as! AnimeCell

        // Get the movie associated table view row
        let anime:Anime
        if indexPath.section == 0{
            anime = starredList[indexPath.row]
        }
        else{
            anime = watchingList[indexPath.row]
        }

        // Configure the cell (i.e. update UI elements like labels, image views, etc.)

        // Unwrap the optional poster path
        if let imageUrl = anime.images.jpg.imageUrl,

            // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
           let url = URL(string: imageUrl) {

            // Use the Nuke library's load image function to (async) fetch and load the image from the image url.
            Nuke.loadImage(with: url, into: cell.pic)
        }

        // Set the text on the labels
        cell.animeTitle.text = anime.title
        cell.synopsis.text = anime.synopsis
        cell.rating.text = "Score: \(anime.score)"

        // Return the cell for use in the respective table view row
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // MARK: - Pass the selected movie data

        // Get the index path for the selected row.
        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = profileTableView.indexPathForSelectedRow else { return }

        // Get the selected movie from the movies array using the selected index path's row
        let selectedAnime:Anime
        if selectedIndexPath.section == 0{
            selectedAnime = starredList[selectedIndexPath.row]
        }
        else {
            selectedAnime = watchingList[selectedIndexPath.row]
        }

        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        guard let detailViewController = segue.destination as? DetailViewController else { return }

        detailViewController.anime = selectedAnime
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Customary to call the overridden method on `super` any time you override a method.
        super.viewWillAppear(animated)
        // TODO: Get favorite movies and display in table view
        // Get favorite movies and display in table view
        // 1. Get the array of favorite movies
        // 2. Set the favoriteMovies property so the table view data source methods will have access to latest favorite movies.
        // 3. Reload the table view
        // ------

        // 1.
        let starredList = Anime.getAnimeList(forKey: Anime.starredKey)
        // 2.
        self.starredList = starredList
        // 3.
        let watchingList = Anime.getAnimeList(forKey: Anime.watchingKey)
        self.watchingList = watchingList
        profileTableView.reloadData()

        // get the index path for the selected row
        if let selectedIndexPath = profileTableView.indexPathForSelectedRow {

            // Deselect the currently selected row
            profileTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.sectionIndexColor = UIColor.white
        profileTableView.dataSource=self
        self.profileTableView.separatorInset = UIEdgeInsets.init(top:0, left:0, bottom:0, right:0);
        
    }
    
}
