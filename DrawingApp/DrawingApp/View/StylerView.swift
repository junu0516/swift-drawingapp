import Foundation
import UIKit

class StylerView: UIView{
    
    private var viewController: ViewMutable?
    private var rectangleColorTextLabel: UILabel = UILabel()
    private var rectangleColorValueField: UIButton = UIButton()
    private var rectangleAlphaTextLabel: UILabel = UILabel()
    private var rectangleAlphaSlider: UISlider = UISlider()
    
    init(frame: CGRect, backgroundColor: UIColor, viewController: ViewMutable){
        super.init(frame: frame)
        self.viewController = viewController
        self.backgroundColor = backgroundColor
        setRectangleColorInformationView()
        setColorChangeAction()
        setRectangleAlphaInformationView()
        setAlphaChangeAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func clearRectangleInfo(){
        self.rectangleAlphaSlider.value = 0
        self.rectangleColorValueField.backgroundColor = .white
        self.rectangleColorValueField.setTitle("", for: .normal)
    }
    
    func updateRectangleInfo(r: Double, g: Double, b: Double, opacity: Float){
        let hexString = "#\(String(Int(r*255), radix: 16))\(String(Int(g*255), radix: 16))\(String(Int(b*255), radix: 16))"
        self.rectangleColorValueField.setTitle(hexString, for: .normal)
        self.rectangleColorValueField.titleLabel?.textAlignment = .center
        self.rectangleColorValueField.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        self.rectangleAlphaSlider.value = opacity
    }
    
    private func setRectangleColorInformationView(){
        self.rectangleColorTextLabel.text = "배경색"
        self.rectangleColorTextLabel.frame = CGRect(x: self.frame.width*0.1,
                                                    y: self.frame.height*0.07,
                                                    width: 100,
                                                    height: self.frame.height*0.05)
        self.addSubview(self.rectangleColorTextLabel)
        
        self.rectangleColorValueField.frame = CGRect(x: self.frame.width*0.1,
                                                     y: self.rectangleColorTextLabel.frame.maxY+10,
                                                     width: self.frame.width*0.75,
                                                     height: self.frame.height*0.05)
        self.rectangleColorValueField.layer.cornerRadius = 10
        self.rectangleColorValueField.layer.borderWidth = 1
        self.addSubview(self.rectangleColorValueField)
    }
    
    private func setColorChangeAction(){
        self.rectangleColorValueField.addAction(UIAction(title: ""){_ in
            let newColor = UIColor(red: CGFloat.random(in: 0...1),
                                   green: CGFloat.random(in: 0...1),
                                   blue: CGFloat.random(in: 0...1),
                                   alpha: 1)
            guard let rgb = newColor.cgColor.components else { return }
            guard let viewController = self.viewController else { return }
            let newHexString = "#\(String(Int(rgb[0]*255), radix: 16))\(String(Int(rgb[1]*255), radix: 16))\(String(Int(rgb[2]*255), radix: 16))"
            self.rectangleColorValueField.backgroundColor = newColor
            self.rectangleColorValueField.setTitle(newHexString, for: .normal)
            viewController.changeSelectedRecntagleViewColor(rgb: rgb.map{Double($0)})
        }, for: .touchDown)
    }
    
    private func setRectangleAlphaInformationView(){
        self.rectangleAlphaTextLabel.text = "투명도"
        self.rectangleAlphaTextLabel.frame = CGRect(x: self.frame.width*0.1,
                                                    y: self.rectangleColorValueField.frame.maxY+25,
                                                    width: 100,
                                                    height: self.frame.height*0.05)
        self.addSubview(self.rectangleAlphaTextLabel)
        
        self.rectangleAlphaSlider.frame = CGRect(x: self.frame.width*0.1,
                                                 y: self.rectangleAlphaTextLabel.frame.maxY+10,
                                                 width: self.frame.width*0.75,
                                                 height: 10)
        self.rectangleAlphaSlider.value = 10
        self.addSubview(self.rectangleAlphaSlider)
    }
    
    private func setAlphaChangeAction(){
        self.rectangleAlphaSlider.addAction(UIAction(title: ""){ _ in
            if let viewController = self.viewController{
                viewController.changeSelectedRectangleViewAlpha(opacity: Int(self.rectangleAlphaSlider.value * 10))
            }
        }, for: .valueChanged)
    }
    
}