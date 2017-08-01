# GradientVC
![](https://travis-ci.org/shion0111/GradientVC.svg?branch=master)

An old experiement project ported to swift...

A viewController with looped gradient background, these gradient properties can be changed in IB.

### About GradientView
Currently the background gradient contains two colors. And these colors are divided into several colors to present the "loop" effect.

### Usage
```swift
  override func viewDidLoad() {
      super.viewDidLoad()
      
      let testview = GradientView(frame: self.frame, hexColor1: "#F298e7", hexColor2: "#a5f9f9", angle: 25.0)
    
      view.insertSubview(testview, at: 0)
  }
```

### Setup GradientView in IB
- IBColor1
- IBColor2
- Angle : gradient angle (impletemented by startPoint and endPoint)
- Loop Duration : duration for animation
<p align="center">
  <img src="https://github.com/shion0111/GradientVC/blob/master/setup.jpg" width="640"/>
</p>
