# Vimeo Player
## Example
![alt text](https://github.com/romin2394/RDOTP/blob/master/testDemo.gif)

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
        player.load(url: "https://player.vimeo.com/video/372852453")
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
