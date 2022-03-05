//
//  WebView.swift
//  Sports
//
//  Created by Mohamed Kamal on 22/02/2022.
//

import UIKit
import WebKit
class WebView: UIViewController {

    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero,configuration: configuration)
        return webView
    }()
    private let url : URL
    init(url: URL)
    {
        
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}
