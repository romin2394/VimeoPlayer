//
//  RDVimeoPlayerView.swift
//  VimeoPlayer
//
//  Created by Romin Dhameliya on 30/12/19.
//  Copyright © 2019 Romin Dhameliya. All rights reserved.
//

import UIKit
import WebKit

public protocol RDVimeoPlayerViewDelegate: class {
    func vimeoPlayer(_ vimeoPlayer:RDVimeoPlayerView, on event:RDVimeoPlayerView.PlayerEvent)
}

open class RDVimeoPlayerView: UIView {
    open private(set) var webView:WKWebView!
    
    open private(set) var aspectRatio:CGFloat = 0.5625, resolution:CGSize = .zero
    
    weak open var delegate:RDVimeoPlayerViewDelegate?
    
    public init() {
        super.init(frame: .zero)
        initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    private func initView() {
        let controller = WKUserContentController()
        PlayerEvent.allCases.forEach({ controller.add(self, name: $0.rawValue) })
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.userContentController = controller
        webView = WKWebView(frame: frame, configuration: config)
        webView.isOpaque = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.isScrollEnabled = false
        addSubview(webView)
        NSLayoutConstraint.activate(
            [webView.leftAnchor.constraint(equalTo: leftAnchor),
             webView.rightAnchor.constraint(equalTo: rightAnchor),
             webView.topAnchor.constraint(equalTo: topAnchor),
             webView.bottomAnchor.constraint(equalTo: bottomAnchor)]
        )
    }
    
    open func load(url:String) {
        webView.loadHTMLString(RDVimeoPlayerView.getVimeoWebPlayerFor(video: url), baseURL: nil)
    }
    
    open func play() {
        let playScr = """
            play();
        """
        webView?.evaluateJavaScript(playScr)
    }
    
    open func pause() {
        let pauseScr = """
           pause();
        """
        webView?.evaluateJavaScript(pauseScr)
    }
}

extension RDVimeoPlayerView: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let event = PlayerEvent(rawValue: message.name) else { return }
        
        switch event {
        case .dimensions:
            if let dimention = message.body as? [Int] {
                resolution = CGSize(width: dimention[0], height: dimention[1])
                aspectRatio = CGFloat(dimention[1])/CGFloat(dimention[0])
            }
        case .play:break
        case .ended:break
        }
        delegate?.vimeoPlayer(self, on: event)
    }
}

public extension RDVimeoPlayerView {
    
    enum PlayerEvent: String, CaseIterable {
        case play, ended, dimensions
    }
    
    
    static func getVimeoWebPlayerFor(video url:String) -> String {
        return """
        <!DOCTYPE html>
        <html>
        <body>
        <style type="text/css">
        body, html {width: 100%; height: 100%; margin: 0; padding: 0;background:black}
        .main {position: absolute;top: 0; left: 0; right: 0; background-color: #101010;height:100%;}
        .main iframe {display: block; width: 100%; height: 100%; border: none;}
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
        <script src="https://player.vimeo.com/api/player.js"></script>
        <div class="main">
        <iframe src=\(url)></iframe>
        </div>
        
        <script src="https://player.vimeo.com/api/player.js"></script>
        <script>
        var iframe = document.querySelector('iframe');
        var player = new Vimeo.Player(iframe);
        
        player.on('play', function() {
        window.webkit.messageHandlers.play.postMessage("play")
        });
        
        player.on('ended', function(data) {
        window.webkit.messageHandlers.ended.postMessage("ended")
        });
        
        Promise.all([player.getVideoWidth(), player.getVideoHeight()]).then(function(dimensions) {
        var width = dimensions[0];
        var height = dimensions[1];
        window.webkit.messageHandlers.dimensions.postMessage(dimensions)
        });
        
        function play() {
        player.play();
        }
        
        function pause() {
        player.pause();
        }
        
        </script>
        
        </body>
        </html>
        """
    }
}
