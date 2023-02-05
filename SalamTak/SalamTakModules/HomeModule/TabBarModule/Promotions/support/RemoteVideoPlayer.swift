//
//  RemoteVideoPlayer.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

import Foundation
import SwiftUI
import WebKit

struct LinkView: View {
    @State var link: String
    var body: some View {
        ZStack {
            WebView(url: URL(string: link.embed)!)
        }
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.scrollView.isScrollEnabled = false
    }
}
extension String {
    var embed: String {
        var strings = self.components(separatedBy: "/")
        let videoId = strings.last ?? ""
        strings.removeLast()
        let embedURL = strings.joined(separator: "/") + "/\(videoId)"
        print(embedURL)
        return embedURL
    }
}
