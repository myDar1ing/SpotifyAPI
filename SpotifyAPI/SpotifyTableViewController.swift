//
//  SpotifyTableViewController.swift
//  SpotifyAPI
//
//  Created by Adilet Kenesbekov on 08.05.2025.
//

import UIKit
import Alamofire
import SwiftyJSON


class SpotifyTableViewController: UITableViewController,UISearchBarDelegate {

  var arrayMusic = [Music]()
  var token : String?


    override func viewDidLoad() {
        super.viewDidLoad()

      let search = UISearchController()
      search.searchBar.delegate = self
      navigationItem.searchController = search
      search.searchBar.placeholder = "Search artist"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
      fetchToken {
          self.searchTrack(term: "Shape of You")
      }

      
    }



  func fetchToken(completion : @escaping() -> Void) {
    let clientId = "080ca37a355a4aafa27458fdf303b5be"
    let secretID = "22b2eabd1c43484f83ae6b2de7bb46b2"
    let auth = Data("\(clientId):\(secretID)".utf8).base64EncodedString()
    let head : HTTPHeaders = [
      "Authorization": "Basic \(auth)",
      "Content-Type": "application/x-www-form-urlencoded"
    ]
    let parame = ["grant_type" : "client_credentials"]

    AF.request("https://accounts.spotify.com/api/token", method: .post, parameters: parame,encoder: URLEncodedFormParameterEncoder.default, headers: head).responseData { response in
      let json = JSON(response.data!)
      self.token = json["access_token"].stringValue
      completion()
    }

  }

  func searchTrack(term : String) {
    guard let token = token else {return}
    let encoded = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? term
    let url = "https://api.spotify.com/v1/search?q=\(encoded)&type=track&limit=25"
    let header : HTTPHeaders = ["Authorization" : "Bearer \(token)"]

    AF.request(url, headers: header).responseData { response in
      self.arrayMusic.removeAll()
      if let data = response.data {
        let json = JSON(data)
        let items = json["tracks"]["items"].arrayValue
        for item in items {
          let track = Music(
            artistName: item["artists"].arrayValue.first?["name"].stringValue ?? "",
            trackName: item["name"].stringValue,
            albumName: item["album"]["name"].stringValue,
            artWorkUrl: item["album"]["images"].arrayValue.first?["url"].stringValue ?? "",
            previewUrl: item["preview_url"].stringValue,
            externalUrl: item["external_urls"]["spotify"].stringValue
          )
          self.arrayMusic.append(track)
        }
        self.tableView.reloadData()
      }
    }
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    arrayMusic.removeAll()
    tableView.reloadData()
    if let text = searchBar.text {
      searchTrack(term: text)
    }
  }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return arrayMusic.count
    }


  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SpotifyTableViewCell
      cell.setData(music: arrayMusic[indexPath.row])
      print(arrayMusic)
        // Configure the cell...

        return cell
    }
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let vc = storyboard?.instantiateViewController(withIdentifier: "VIewController") as! ViewController
//    vc.trackPreview = arrayMusic[indexPath.row].externalUrl
//    navigationController?.show(vc, sender: self)

    let track = arrayMusic[indexPath.row]
        if let url = URL(string: track.externalUrl), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid or unsupported URL.")
        } // сразу после нажатие на ячейку, код перекидывает на Сафари, где опять таки мы можем переходить между проектом и браузером
  }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
