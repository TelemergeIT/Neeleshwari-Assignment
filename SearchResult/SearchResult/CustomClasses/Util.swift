//
//  Util.swift
//  SearchResult
//
//  Created by Neeleshwari Mehra on 23/03/21.
//  Copyright © 2021 Hiteshi. All rights reserved.
//

import UIKit

class Util: NSObject {

}

class appColor :NSObject {

   static let colorDarkBlue =  UIColor(red: 39.0/255.0, green: 50.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
   static let colorLightBlue = UIColor(red: 33.0/255.0, green: 85.0/255.0, blue: 113.0/255.0, alpha: 1.0).cgColor

}
extension UIView {
     func addBottomBorder(color: UIColor, height: CGFloat) {
         let border = UIView()
         border.backgroundColor = color
         border.translatesAutoresizingMaskIntoConstraints = false
         self.addSubview(border)
         border.addConstraint(NSLayoutConstraint(item: border,
                                                 attribute: NSLayoutConstraint.Attribute.height,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.height,
                                                 multiplier: 1, constant: height))
         self.addConstraint(NSLayoutConstraint(item: border,
                                               attribute: NSLayoutConstraint.Attribute.bottom,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: self,
                                               attribute: NSLayoutConstraint.Attribute.bottom,
                                               multiplier: 1, constant: 0))
         self.addConstraint(NSLayoutConstraint(item: border,
                                               attribute: NSLayoutConstraint.Attribute.leading,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: self,
                                               attribute: NSLayoutConstraint.Attribute.leading,
                                               multiplier: 1, constant: 0))
         self.addConstraint(NSLayoutConstraint(item: border,
                                               attribute: NSLayoutConstraint.Attribute.trailing,
                                               relatedBy: NSLayoutConstraint.Relation.equal,
                                               toItem: self,
                                               attribute: NSLayoutConstraint.Attribute.trailing,
                                               multiplier: 1, constant: 0))
     }
     
 }
extension UIViewController{
 
    func setGradientBackground() {
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [appColor.colorDarkBlue, appColor.colorLightBlue]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

    func setNavAppTheme(className:String) {
              self.navigationController?.setNavigationBarHidden(false, animated: true)
              self.navigationController?.navigationBar.tintColor = UIColor.white//UIColor.black
              
              self.navigationController?.navigationBar.barTintColor = UIColor.white
              self.navigationController?.navigationBar.topItem?.title = ""
              self.title = className
          
              let titleViewNav = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 70, height: 40))
              let lbl1 = UILabel(frame: CGRect.init(x: 0 , y: 0, width: view.frame.size.width - 70, height: 40))
              lbl1.text = className
              lbl1.font = UIFont.boldSystemFont(ofSize: 25.0)
               lbl1.lineBreakMode = .byWordWrapping
                lbl1.backgroundColor = UIColor.clear
              lbl1.textColor = UIColor.white
              lbl1.textAlignment = .left
              lbl1.numberOfLines = 1
              titleViewNav.addSubview(lbl1)
              self.navigationItem.titleView = titleViewNav
              self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
              lbl1.center = titleViewNav.center
            
              lbl1.backgroundColor = UIColor.clear
              titleViewNav.backgroundColor = UIColor.clear
            
          }
    
  
}

//================*******************************================================

//================*******************************================================
extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        self.addSublayer(border)
    }

}


extension UITextField {
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
            ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
}
