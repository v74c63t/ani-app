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
        let starredList = Anime.getAnimeList(forKey: Anime.favoritesKey)
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
        
        profileTableView.dataSource=self
        self.profileTableView.separatorInset = UIEdgeInsets.init(top:0, left:0, bottom:0, right:0);
        
    }
    
//    // Fetches a list of popular movies from the TMDB API
//    private func fetchAnimeList() {
//
//        // URL for the TMDB Get Popular movies endpoint: https://developers.themoviedb.org/3/movies/get-popular-movies
//        let url = URL(string: "https://api.jikan.moe/v4/top/anime")!
//
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
//
//        // ---
//        // Create the URL Session to execute a network request given the above url in order to fetch our movie data.
//        // https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
//        // ---
//        let session = URLSession.shared.dataTask(with: request) { data, response, error in
//
//            // Check for errors
//            if let error = error {
//                print("🚨 Request failed: \(error.localizedDescription)")
//                return
//            }
//
//            // Check for server errors
//            // Make sure the response is within the `200-299` range (the standard range for a successful response).
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                print("🚨 Server Error: response: \(String(describing: response))")
//                return
//            }
//
//            // Check for data
//            guard let data = data else {
//                print("🚨 No data returned from request")
//                return
//            }
////            let stringResponse = String(data: data, encoding: .utf8)
////            print(stringResponse)
//            // The JSONDecoder's decode function can throw an error. To handle any errors we can wrap it in a `do catch` block.
//            do {
//                // MARK: - jSONDecoder with custom date formatter
//                let decoder = JSONDecoder()
//
//                // Create a date formatter object
//                let dateFormatter = DateFormatter()
//
//                // Set the date formatter date format to match the the format of the date string we're trying to parse
//                dateFormatter.dateFormat = "yyyy-MM-dd"
//
//                // Tell the json decoder to use the custom date formatter when decoding dates
//                decoder.dateDecodingStrategy = .formatted(dateFormatter)
//
//                // Decode the JSON data into our custom `MovieFeed` model.
//                let animeResponse = try decoder.decode(AnimeFeed.self, from: data)
//
//                // Access the array of movies
////                print(animeResponse)
//                let anime = animeResponse.data
//
//                // Run any code that will update UI on the main thread.
//                DispatchQueue.main.async { [weak self] in
//
//                    // We have movies! Do something with them!
//                    print("✅ SUCCESS!!! Fetched \(anime.count) anime")
//
//                    // Iterate over all movies and print out their details.
////                    for (index, movie) in anime_shows.enumerated() {
////                        print("🍿 MOVIE \(index) ------------------")
////                        print("Title: \(movie.title)")
////                        print("Overview: \(movie.overview)")
////                    }
//
//                    // Update the movies property so we can access movie data anywhere in the view controller.
//                    self?.anime_shows = anime
//                    print("🍏 Fetched and stored \(anime.count) anime")
//
//                    // Prompt the table view to reload its data (i.e. call the data source methods again and re-render contents)
//                    self?.profileTableView.reloadData()
//                }
//            } catch {
//                print("🚨 Error decoding JSON data into Movie Response: \(error.localizedDescription)")
//                return
//            }
//        }
//
//        // Don't forget to run the session!
//        session.resume()
//    }

}
