# Vimeo Player
## Example
![alt text](https://github.com/romin2394/VimeoPlayer/blob/master/ss1.png)

#### Manually
1. Download and drop ```RDVimeoPlayerView.swift``` in your project.  
2. Congratulations!  

## Usage example

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet var player: RDVimeoPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        player.load(url: "https://player.vimeo.com/video/70591644")
    }
}

extension ViewController: RDVimeoPlayerViewDelegate {
    public func vimeoPlayer(_ vimeoPlayer: RDVimeoPlayerView, on event: RDVimeoPlayerView.PlayerEvent) {
        
    }
}

```
## Contribute

We would love you for the contribution to **Vimeo Player**.
## Author

rdc2394@gmail.com

## Buy me a Coffee

<a href="https://www.buymeacoffee.com/romin" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-red.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

