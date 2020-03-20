//
//  LocalizationManager.swift
//  Food Recognizer+
//
//  Created by dev on 20.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import Foundation

extension Notification.Name {
    public static let notificationLanguageChanged = Notification.Name("LanguageChanged")
}

open class LocalizationManager {
    
    // MARK: - Properties
    
    public private(set) static var locale: Locale = .current
    public static var availableLocales: [String] = ["en", "ru"]
    
    private static var languageCode: String = ""
    private static var regionCode: String = ""
    private static var languageBundle: Bundle?
    private static var englishLanguageBundle = languageBundle(withCode: "en", andType: "lproj")
    private static var nakedLocalizationEnabled: Bool = false
    
    // MARK: - Static part
    
    public static func setNakedLocalization(to value: Bool) {
        nakedLocalizationEnabled = value
        NotificationCenter.default.post(name: .notificationLanguageChanged, object: nil)
    }
    
    public static func format(key: String, values: [String]) -> String {
        if !nakedLocalizationEnabled {
            let key = _L(key)
            let formatCounter = key.components(separatedBy: "%@").count - 1
            if formatCounter != values.count {
                return "FORMAT ERROR: \(key) -\(values)"
            }
            
            let args: [CVarArg] = values
            let formattedString = withVaList(args) { NSString(format: key, arguments: $0) } as String
            
            return formattedString
        } else {
            return key
        }
    }
    
    public static func localizedString(_ key: String) -> String {
        initLanguageCode()
        if !nakedLocalizationEnabled {
            languageBundle = languageBundle(withCode: languageCode, andType: "lproj")
            
            var val = languageBundle?.localizedString(forKey: key, value: key, table: nil)
            val = val?.replacingOccurrences(of: "%s", with: "%@")
            
            if val == key {
                guard let englishString = englishLanguageBundle?.localizedString(forKey: key,
                                                                                 value: key,
                                                                                 table: nil) else { return key }
                return englishString.replacingOccurrences(of: "%s", with: "%@")
            }
            
            return val ?? key
        } else {
            return key
        }
    }
    
    public static func localizedTitleForCurrency(isoCode: String?) -> String {
        if let isoCode = isoCode {
            return self.currentLocale().displayName(forKey: .currencyCode, value: isoCode) ?? ""
        } else {
            return ""
        }
    }
    
    public static func localizedString(forReplacedKey key: String) -> String {
        var replaced = localizedString(key)
        replaced = replaced.replacingOccurrences(of: "%s", with: "%@")
        return replaced
    }
    
    public static func localizedString(forCount count: Float, key: String) -> String {
        initLanguageCode()
        
        if !nakedLocalizationEnabled {
            let fewKey = localizedString(key.appending("_FEW"))
            let manyKey = localizedString(key.appending("S"))
            let singleKey = localizedString(key)
            
            let countInt = Int(count)
            
            if languageCode == "ru" {
                if count < 1 && count > 0 {
                    return fewKey
                }
                
                let mod100 = countInt % 100
                let mod10 = countInt % 10
                
                switch mod10 {
                case 1:         return mod100 == 11 ? manyKey : singleKey
                case 2, 3, 4:   return mod100 > 10 && mod100 < 20 ? manyKey : fewKey
                case 5, 6, 7, 8, 9, 0: return manyKey
                default: return manyKey
                }
                
            }
            
            return count <= 1 ? singleKey : manyKey
        } else {
            return key
        }
    }
    
    public static func currentLanguageName() -> String {
        initLanguageCode()
        return languageName(withCode: languageCode)
    }
    
    public static func currentLanguageCode() -> String {
        initLanguageCode()
        return languageCode
    }
    
    //    class func currentCurrencyCode() -> String {
    //        return ""
    //    }
    
    public static func currentRegionCode() -> String {
        let locale = Locale.current as NSLocale
        
        if let country = locale.object(forKey: .countryCode) as? String {
            return country
        }
        
        // writeToLog
        
        return ""
    }
    
    public static func languageName(withCode code: String) -> String {
        let locale = NSLocale(localeIdentifier: code)
        let newCode = languageCode(withLocale: code)
        let language = locale.displayName(forKey: .identifier, value: newCode)
        return language ?? ""
    }
    
    public static func countryName(withCode code: String) -> String {
        let locale = self.currentLocale()
            let name = locale.displayName(forKey: .countryCode, value: code)
            return name ?? ""
    }
    
    
    public static func currentLocale() -> NSLocale {
        initLanguageCode()
        let locale = NSLocale(localeIdentifier: languageCode)
        return locale
    }
    
    public static func setCurrentLocale(code: String) {
        let code = code.lowercased()
        
        guard languageCode != code else { return }
        guard availableLocales.contains(code) else { return }
        
        let appleLanguages = code != "sys" ? [code] : []
        
        UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        languageCode = code
        self.regionCode = Locale.current.regionCode ?? ""
        languageBundle = languageBundle(withCode: languageCode, andType: "lproj")
        reinstallLocale(languageCode: languageCode, regionCode: regionCode)
        
        NotificationCenter.default.post(name: .notificationLanguageChanged, object: nil)
    }
    
    // MARK: - Private part
    
    private static func initLanguageCode() {
        guard languageCode.isEmpty else { return }
        
        let languageCodeArray = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String] ?? []
        var code = languageCodeArray.count == 1 ? languageCodeArray[0] : Locale.preferredLanguages[0]
        
        code = languageCode(withLocale: code)
        
        if !availableLocales.contains(code) {
            code = "en"
        }
        
        languageCode = code
        languageBundle = nil
    }
    
    private static func languageCode(withLocale locale: String) -> String {
        var code = locale
        
        if let range = code.range(of: "-") {
            let idx = NSRange(range, in: code).location
            code = code[0..<idx]
        }
        
        return code
    }
    
    private static func languageBundle(withCode code: String, andType type: String) -> Bundle? {
        let path = Bundle.main.path(forResource: code, ofType: type)
        return Bundle(path: path ?? "")
    }
    
    private static func reinstallLocale(languageCode: String, regionCode: String) {
        let identifier =  "\(languageCode.lowercased())_\(regionCode.uppercased())"
        locale = Locale(identifier: identifier)
    }
    
}

