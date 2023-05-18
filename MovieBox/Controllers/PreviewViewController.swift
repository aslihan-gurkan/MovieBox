//
//  PreviewViewController.swift
//  MovieBox
//
//  Created by Aslıhan Gürkan on 8.04.2023.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var webView: WKWebView!
    
    var movieTitle = ""
    var movieOverview = ""
    var videoId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movieTitle
        overviewText.text = movieOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
        webView.load(URLRequest(url: url))        
        
    }

}
