//
//  ViewController.swift
//  SpotifyAPI
//
//  Created by Adilet Kenesbekov on 07.05.2025.
//

import UIKit
import WebKit
class ViewController: UIViewController {

  @IBOutlet weak var previewWebkit: WKWebView!

  var trackPreview = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    guard let url = URL(string: trackPreview), !trackPreview.isEmpty else {
      let alert = UIAlertController(title: "No Preview", message: "This track does not have a preview", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .default))
      present(alert, animated: true)
      return
    }

    let request = URLRequest(url: url)
    previewWebkit.load(request)
  }


}

