//
//  StringExtensions.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 08/04/21.
//

import Foundation

public extension String {
    
    /// Returns base64 encoded of string
    var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }
    
    /// Returns Character count
    var length: Int {
        return self.count
    }
    
    /// Returns if String is a Valid email
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Returns if String is a Valid mobile number
    var isValidMobileNumber: Bool {
        
        let PHONE_REGEX = "[6789][0-9]{9}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return  phoneTest.evaluate(with: self)
    }
    
    /// Returns if String is a Valid URL
    var isValidUrl: Bool {
        let regEx  = "^(http[s]?://)?([www]\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: self)
    }
    
    /// Trims white space and new line characters, returns a new string
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /// Validate string which contains `(null)`, `<null>`, returns a new string
    var validateEmptyString:String {
        
        if (self.count ) == 0 || (self == "") || (self == "(null)") || (self == "<null>") {
            return ""
        }
        return self
    }
    
    /// Extracts URLS from String, returns a new [URL]
    var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }
        
        let text = self
        
        if let detector = detector {
            detector.enumerateMatches(in: text,
                                      options: [],
                                      range: NSRange(location: 0, length: text.count),
                                      using: { (result: NSTextCheckingResult?, _, _) -> Void in
                if let result = result, let url = result.url {
                    urls.append(url)
                }
            })
        }
        
        return urls
    }
    /// split string using a separator string, returns an array of string
    func split(_ separator: String) -> [String] {
        return self.components(separatedBy: separator).filter {
            !$0.trim.isEmpty
        }
    }
    
    /// Returns count of words in string
    var countofWords: Int {
        let regex = try? NSRegularExpression(pattern: "\\w+", options: NSRegularExpression.Options())
        return regex?.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: self.length)) ?? 0
    }
    
    /// Returns count of paragraphs in string
    var countofParagraphs: Int {
        let regex = try? NSRegularExpression(pattern: "\\n", options: NSRegularExpression.Options())
        let str = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return (regex?.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: str.length)) ?? -1) + 1
    }
    
    /// Converts String to Int
    var toInt:Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// Converts String to Double
    var toDouble:Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// Converts String to Float
    var toFloat:Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// Converts String to Bool
    var toBool:Bool? {
        let trimmedString = trim.lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    
    /// Converts String to Date
    /// - Parameter format: default date format is `"yyyy-MM-dd"`, Can override
    /// - Returns: date
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
    
    ///Returns the first index of the occurrence of the character in String
    func getIndexOf(_ char: Character) -> Int? {
        for (index, c) in self.enumerated() where c == char {
            return index
        }
        return nil
    }
    
    /// Returns bold NSAttributedString
    var bold:NSAttributedString {
        let boldString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
        return boldString
    }
        
    /// Returns underlined NSAttributedString
    var underline:NSAttributedString {
        let underlineString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        return underlineString
    }
            
    /// Returns italic NSAttributedString
    var italic:NSAttributedString {
        let italicString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
        return italicString
    }
            
    /// Returns hight of rendered string
    func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
        var attrib: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }
        let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))
        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrib, context: nil).height)
    }
            
    /// Returns coloured NSAttributedString
    func color(_ color: UIColor) -> NSAttributedString {
        let colorString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor: color])
        return colorString
    }
    
    /// Returns NSAttributedString.
    ///
    ///  String should be included with substring and pass subString in func parameter.
    /// - Parameters:
    ///   - subString: String to be coloured
    ///   - color: string colour
    /// - Returns: attribute string
    func setColor(_ color: UIColor, ofSubstring subString: String) -> NSMutableAttributedString {
        let range = (self as NSString).range(of: subString)
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return attributedString
    }
    
    ///  URL encode a string (percent encoding special chars)
    var urlEncoded:String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlAllowed)!
    }
    /// Removes percent encoding from string
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
}

public extension CharacterSet {
    static let urlAllowed = CharacterSet.urlFragmentAllowed
        .union(.urlHostAllowed)
        .union(.urlPasswordAllowed)
        .union(.urlQueryAllowed)
        .union(.urlUserAllowed)
}
