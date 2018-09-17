//
//  Extensions.swift
//  NMG.CRM
//
//  Created by Soyombo bat-erdene on 4/30/18.
//  Copyright © 2018 soyombo bat-erdene. All rights reserved.
//

import UIKit
import Apollo

extension UIViewController {
    
    func navigate(_ navigation: MyNavigation) {
        navigate(navigation as Navigation)
    }
    
    func showResult(isSuccess:Bool,message:String){
        let bannerView = UIView(frame: CGRect(x:0, y:0, width:view.frame.width, height:(UINavigationController().navigationBar.frame.height)))
        if isSuccess{
            bannerView.backgroundColor=UIColor.init(hexString: "37ce49")
        }else{
            bannerView.backgroundColor=UIColor.red
        }
        navigationController?.navigationBar.addSubview(bannerView)
        let notifyLabel = UILabel()
        notifyLabel.frame = CGRect(x:0, y:0, width:view.frame.width, height:(UINavigationController().navigationBar.frame.height))
        notifyLabel.backgroundColor=UIColor.clear
        notifyLabel.text = message
        notifyLabel.textAlignment = .center
        notifyLabel.textColor = .white
        notifyLabel.font = UIFont.fontWith(type: .light, size: 14)
        bannerView.addSubview(notifyLabel)
        
        bannerView.center.y -= (navigationController?.navigationBar.bounds.height)!
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.curveEaseIn, animations:{
            bannerView.center.y += (self.navigationController?.navigationBar.frame.height)!
            
            
        }, completion:{ finished in
            
            
            
            UIView.animate(withDuration: 1, delay: 1.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9, options: UIViewAnimationOptions.curveEaseOut, animations:{
                
                bannerView.center.y -= ((self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height)
                
            }, completion: { completed in
                bannerView.removeFromSuperview()
            })
            
        })
    }
    
}

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        var str = attributedString.string
        str = str.replacingOccurrences(of: "\n", with: "")
        
        return str
    }
    
    func dateFromString() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.date(from: self)!
    }
    
    func convertHtml() -> NSMutableAttributedString {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do{
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                       .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }catch{
            return NSMutableAttributedString()
        }
    }
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func stringFromDate()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy hh:mm"
        return formatter.string(from: self)
    }
    
    func mainDateString()->String {
//        2018-09-01
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: self)
    }
    
    
}

extension UIView {
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.tag = 1000
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func addBorder(with color:UIColor){
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}



extension UIImageView {
    func setImageWithString(text: String, backGroundColor: UIColor, attributes: [NSAttributedStringKey : Any]) {
        
        var displayString: NSMutableString = NSMutableString(string: "")
        var words = text.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        
        if words.count == 2 {
            let firstWord = words[0]
            if firstWord.count != 0 {
                let firstLetter = firstWord.substring(to: firstWord.index(firstWord.startIndex, offsetBy: 1))
                displayString.append(firstLetter)
            }
            
            let secondWord = words[1]
            if secondWord.count != 0 {
                let firstLetter = secondWord.substring(to: (secondWord.index((secondWord.startIndex), offsetBy: 1)))
                displayString.append(".")
                displayString.append(firstLetter)
            }
        }else{
            let firstWord = words[0]
            if firstWord.count != 0 {
                let firstLetter = firstWord.substring(to: firstWord.index(firstWord.startIndex, offsetBy: 1))
                displayString.append(firstLetter)
            }
        }

        let scale:Float = Float(UIScreen.main.scale)
        var size:CGSize = self.bounds.size
        
        if (self.contentMode == .scaleToFill ||
            self.contentMode == .scaleAspectFill ||
            self.contentMode == .scaleAspectFit ||
            self.contentMode == .redraw)
        {
            size.width = CGFloat(floorf(Float(size.width) * scale) / scale)
            size.height = CGFloat(floorf(Float(size.height) * scale) / scale)
        }

        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat( scale))
        let context = UIGraphicsGetCurrentContext()
        
        let path = CGPath(ellipseIn: self.bounds, transform: nil)
        context!.addPath(path)
        context?.clip()
        context!.setFillColor(backGroundColor.cgColor)
        context!.fill(CGRect(x:0, y:0, width:size.width, height:size.height));
        
        let textSize = displayString.size(withAttributes: attributes)
        
        
        displayString.draw(in: CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height), withAttributes: attributes)
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        self.image = image
    }
    
    func fontName(fontName:String) -> UIFont {
        let fontSize:CGFloat = self.bounds.width * 40
        if fontName.count != 0 {
            return UIFont(name: fontName, size: fontSize)!
        }else{
            return UIFont.systemFont(ofSize: fontSize)
        }
    }
}

public extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
  
    func tint(with color: UIColor) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        // flip the image
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -self.size.height)
        
        // multiply blend mode
        context.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        
        // create UIImage
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    class func resize(_ image: UIImage) -> Data! {
        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)
        let maxHeight: Float = 1000.0
        let maxWidth: Float = 1000.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 0.5
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(img!, CGFloat(compressionQuality))
        return imageData!
    }
    
}

public typealias JSON = [String: Any]

extension Dictionary: JSONDecodable {
    public init(jsonValue value: JSONValue) throws {
        
        if var array = value as? NSArray {
            self.init()
            if var dict = self as? [String: JSONDecodable & JSONEncodable] {
                dict["data"] = array as! [[String:Any]]
                self = dict as! Dictionary<Key, Value>
                return
            }
        }
        
        guard let dictionary = forceBridgeFromObjectiveC(value) as? Dictionary else {
            
            
            throw JSONDecodingError.couldNotConvert(value: value, to: Dictionary.self)
        }
        self = dictionary
    }
}

extension Array: JSONDecodable {
    public init(jsonValue value: JSONValue) throws {
        guard let array = forceBridgeFromObjectiveC(value) as? Array else {
            
            throw JSONDecodingError.couldNotConvert(value: value, to: Array.self)
        }
        self = array
    }
}


private func forceBridgeFromObjectiveC(_ value: Any) -> Any {
    switch value {
    case is NSString:
        return value as! String
        
    case is Bool:
        return value as! Bool
    case is Int:
        return value as! Int
    case is Double:
        return value as! Double
    case is NSDictionary:
        return Dictionary(uniqueKeysWithValues: (value as! NSDictionary).map { ( $0.key as! AnyHashable, forceBridgeFromObjectiveC($0.value)) })
    case is NSArray:
        return (value as! NSArray).map { forceBridgeFromObjectiveC($0) }
    default:
        return value
    }
}

extension Array {
    func contain<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

public extension UIFont {
    enum FontType: String {
        case black = "Montserrat-Black"
        case bold = "Montserrat-Bold"
        case extrabold = "Montserrat-ExtraBold"
        case hairline = "Montserrat-Hairline"
        case light = "Montserrat-Light"
        case regular = "Montserrat-Regular"
        case semibold = "Montserrat-SemiBold"
        case thin = "Montserrat-Thin"
        case ultralight = "Montserrat-UltraLight"
        case medium = "Montserrat-Medium"
    }
    
    public class func fontWith(type:FontType, size:CGFloat)->UIFont{
        return UIFont(name:type.rawValue, size: size)!
    }
    
}

public extension UIColor {
    
    static let ERXES_COLOR = UIColor(red:86 / 255, green: 41 / 255, blue: 182 / 255, alpha: 1.0)
    static let TEXT_COLOR = UIColor(red: 96 / 255, green: 96 / 255, blue: 96 / 255, alpha: 1.0)
    static let CELL_COLOR = UIColor(red: 248 / 255, green: 244 / 255, blue: 249 / 255, alpha: 1.0)
    static let KEYBOARD_COLOR = UIColor(red: 209 / 255, green: 213 / 255, blue: 218 / 255, alpha: 1.0)
    static let GRAY_COLOR = UIColor(red: 74 / 255, green: 74 / 255, blue: 74 / 255, alpha: 1.0)
    static let LIGHT_GRAY_COLOR = UIColor(red: 160 / 255, green: 160 / 255, blue: 160 / 255, alpha: 0.6)
    static let SHIMMER_COLOR = UIColor(red: 202 / 255, green: 202 / 255, blue: 202 / 255, alpha: 1.0)
    static let INBOX_BG_COLOR = UIColor(red: 245 / 255, green: 244 / 255, blue: 250 / 255, alpha: 1.0)
    static let FB_COLOR = UIColor(red: 59 / 255, green: 89 / 255, blue: 152 / 255, alpha: 1.0)
    static let GREEN = UIColor(red: 55 / 255, green: 206 / 255, blue: 73 / 255, alpha: 1.0)
}
