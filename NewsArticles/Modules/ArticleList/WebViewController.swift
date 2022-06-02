//
//  WebViewController.swift
//  NewsArticles
//
//  Created by Anastasia Kholod on 02.06.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()

    private var url: URL
    
    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Main.backgroundGrey
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    override func loadView() {
        super.loadView()
        webView.frame = view.bounds
    }
}
