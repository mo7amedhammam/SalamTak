//  SalamtakWebView.swift
//  Salamtak-DR
//
//  Created by Mohmed Hammam on 26/05/2022.
//
import UIKit
import SwiftUI
import WebKit
import Combine

struct SalamtakWebView: UIViewControllerRepresentable {
    let url: URL
    @Binding var isPresented : Bool
    func makeUIViewController(context: Context) -> WebviewController {
        let webviewController = WebviewController()

        let request = URLRequest(url: self.url, cachePolicy: .returnCacheDataElseLoad)
        webviewController.webview.load(request)

        return webviewController
    }

    func updateUIViewController(_ webviewController: WebviewController, context: Context) {
        //
    }
}

class WebviewController: UIViewController, WKNavigationDelegate {
    @objc lazy var webview: WKWebView = WKWebView()
    lazy var progressbar: UIProgressView = UIProgressView()
    var webViewURLObserver: NSKeyValueObservation?          // Observer for URL
    var newUrl : String = ""
 
    
    deinit {
        self.webview.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webview.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webview.navigationDelegate = self
        self.view.addSubview(self.webview)
        print(webview.url ?? "url")
        self.webview.frame = self.view.frame
        self.webview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            self.webview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])

        self.webview.addSubview(self.progressbar)
        self.setProgressBarPosition()

        webview.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)

        self.progressbar.progress = 0.1
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        
//        // OBSERVER: WebView URL
         webViewURLObserver = webview.observe(\.url, options: .new) { [weak self] webView, change in
             let url = "\(String(describing: change.newValue))"
             self?.urlDidChange(urlString: url)
         }

    }
    
    func urlDidChange(urlString: String) {
        if let url = urlString as? String {
            print(url)
            self.newUrl = url
            if url.contains("404") {
                print("Error 404: Page not found")
            }
            
        }
    }

    func setProgressBarPosition() {
        self.progressbar.translatesAutoresizingMaskIntoConstraints = false
        self.webview.removeConstraints(self.webview.constraints)
        self.webview.addConstraints([
            self.progressbar.topAnchor.constraint(equalTo: self.webview.topAnchor, constant: self.webview.scrollView.contentOffset.y * -1),
            self.progressbar.leadingAnchor.constraint(equalTo: self.webview.leadingAnchor),
            self.progressbar.trailingAnchor.constraint(equalTo: self.webview.trailingAnchor),
        ])
    }

    // MARK: - Web view progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "estimatedProgress":
            if self.webview.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, animations: { () in
                    self.progressbar.alpha = 0.0
                }, completion: { finished in
                    self.progressbar.setProgress(0.0, animated: false)
                })
            } else {
                self.progressbar.isHidden = false
                self.progressbar.alpha = 1.0
                progressbar.setProgress(Float(self.webview.estimatedProgress), animated: true)
            }

        case "contentOffset":
            self.setProgressBarPosition()
 

        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

