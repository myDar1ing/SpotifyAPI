//
//  ViewController.swift
//  SpotifyAPI
//
//  Created by Adilet Kenesbekov on 07.05.2025.
//

/*
 Понравилось работать с музыкой и его api, взял Spotify, были сложности ибо доступ только через аутенфикацию и надо было читать документацию долго
 чтобы разобраться. Для веб вью нужен превью ссылка, но у каждой спотифай музыки ее практический не была, поэтому пришлось добавить внешнюю ссылку чтоб перекидовал на приложение( в нашем случае сайт) самого Спотифай и мы могли слушать этот превью 30 секундный. Сделал его в начале на веб вью, однако там требовал регистрацию чтоб могли послушать музыку, теперь, его сделал через UIApplication, где та же страница, но можно послушать музыку. Оставлю два кода, для UIApplication(основной) и для Веб вью.

 */

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

