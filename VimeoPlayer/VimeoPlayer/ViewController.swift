//
//  ViewController.swift
//  VimeoPlayer
//
//  Created by Romin Dhameliya on 30/12/19.
//  Copyright © 2019 Romin Dhameliya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var player: RDVimeoPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.delegate = self
        player.load(url: "https://player.vimeo.com/video/70591644")
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: RDVimeoPlayerViewDelegate {
    public func vimeoPlayer(_ vimeoPlayer: RDVimeoPlayerView, on event: RDVimeoPlayerView.PlayerEvent) {
        
    }
}

