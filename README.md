# GradientVC
![](https://travis-ci.org/shion0111/GradientVC.svg?branch=master)

A former prototyping project has been ported to swift -- a view controller with looped gradient background. These gradient properties can be edited in IB.
<p align="center">
  <img src="https://github.com/shion0111/GradientVC/blob/master/gradientVC.gif"/>
</p>


### About GradientView
Currently the background gradient contains two colors. And these colors are divided into several colors to present the "loop" effect. 

GradientView supports:
- Gradient with 2 colors with user defined angle
- Device orientation
- Animation will be restored when view reappearing


### Usage

```swift
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if gradient == nil {
            gradient = GradientView(frame: self.view.bounds, hexColor1: "#F298e7", hexColor2: "#a5f9f9", angle: 25.0)
            view.addSubview(gradient)
            view.sendSubview(toBack: gradient)
            gradient.isUserInteractionEnabled = false
        } else {
            gradient.start()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if gradient != nil {
            gradient.stop()
        }
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
