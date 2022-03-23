//
//  ViewController.swift
//  UIKitApp
//
//  Created by IlyaCool on 18.02.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var rgbToHexLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        setViewColor()
        self.colorView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onViewClick)))
    }
    
    // MARK: WORK WITH COLORS
    func setViewColor() {
        let red = CGFloat(redSlider.value/255)
        let green = CGFloat(greenSlider.value/255)
        let blue = CGFloat(blueSlider.value/255)
        
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        rgbToHexLabel.text = colorView.backgroundColor?.convertToHex()
        rgbToHexLabel.textColor = (redSlider.value > 125 && greenSlider.value > 125) || (blueSlider.value > 125 && redSlider.value > 125) || (greenSlider.value > 125 && blueSlider.value > 125) ? .black : .white
    }
    
    // MARK: CHANGE LABEL TEXT
    @IBAction func slideColor(_ sender: Any) {
        let changedSlider = sender as! UISlider
        
        setViewColor()
        
        if changedSlider == redSlider {
            redColorLabel.text = "Red: \(Int(changedSlider.value))"
            return
        }
        if changedSlider == greenSlider {
            greenColorLabel.text = "Green: \(Int(changedSlider.value))"
            return
        }
        
        blueColorLabel.text = "Blue: \(Int(changedSlider.value))"
    }
     
    @objc func onViewClick() {
        UIPasteboard.general.string = rgbToHexLabel.text
    }
    
}

// MARK: COLOR EXTENSION FOR CONVER INTO HASH
extension UIColor {
    func convertToHex() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
}
