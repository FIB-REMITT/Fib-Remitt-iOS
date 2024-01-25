//
//  UserSettings.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 25/1/24.
//

import Foundation

class UserSettings{
    
    static let shared = UserSettings()

    
    private init(){
        if favCurrencyList == nil{
            favCurrencyList = [String]()
        }
    }
    
    //TODO: Need to store api token in keychain
    var apiToken: String?{
        get{
            return UserDefaults.standard.string(forKey: K.UserDefaultsKey.APITokenKey)
        }set(apiToken){
            guard let apiToken = apiToken else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.APITokenKey)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(apiToken, forKey: K.UserDefaultsKey.APITokenKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    //TODO: Need to store refresh token in keychain
    var refreshToken: String?{
        get{
            return UserDefaults.standard.string(forKey: K.UserDefaultsKey.RefreshTokenKey)
        }set(refreshToken){
            guard let refreshToken = refreshToken else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.RefreshTokenKey)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(refreshToken, forKey: K.UserDefaultsKey.RefreshTokenKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    var isUserLoggedIn: Bool? {
        get{
            return UserDefaults.standard.bool(forKey: K.UserDefaultsKey.UserLoggedIn)
        }set(isUserLoggedIn){
            guard let isUserLoggedIn = isUserLoggedIn else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.UserLoggedIn)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(isUserLoggedIn, forKey: K.UserDefaultsKey.UserLoggedIn)
            UserDefaults.standard.synchronize()
        }
    }
    
    var tokenExpiredIn:Int?{
        get{
            return UserDefaults.standard.integer(forKey: K.UserDefaultsKey.TokenExpireTime)
        }set(isUserLoggedIn){
            guard let isUserLoggedIn = isUserLoggedIn else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.TokenExpireTime)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(isUserLoggedIn, forKey: K.UserDefaultsKey.TokenExpireTime)
            UserDefaults.standard.synchronize()
        }
    }
    
    var refreshTokenExpiredIn:Int?{
        get{
            return UserDefaults.standard.integer(forKey: K.UserDefaultsKey.RefreshTokenExpireTime)
        }set(isUserLoggedIn){
            guard let isUserLoggedIn = isUserLoggedIn else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.RefreshTokenExpireTime)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(isUserLoggedIn, forKey: K.UserDefaultsKey.RefreshTokenExpireTime)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var favCurrencyList : [String]?{
        get{
            return UserDefaults.standard.stringArray(forKey: K.UserDefaultsKey.FavouriteCurrencyData)
        }set(favCurrencyList){
            guard let favCurrencyList = favCurrencyList else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.FavouriteCurrencyData)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(favCurrencyList, forKey: K.UserDefaultsKey.FavouriteCurrencyData)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var fcmToken: String? {
        get{
            return UserDefaults.standard.string(forKey: K.UserDefaultsKey.FcmToken)
        }set(fcmToken){
            guard let fcmToken = fcmToken else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.FcmToken)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(fcmToken, forKey: K.UserDefaultsKey.FcmToken)
            UserDefaults.standard.synchronize()
        }
    }
    
    func isRefreshTokenExpired() -> Bool {
        if let expireTime = refreshTokenExpiredIn{
            if expireTime > Int(Date().timeIntervalSince1970){
                return false
            }
        }
        return true
    }
    
    func isAccessTokenExpired() -> Bool {
        if let expireTime = tokenExpiredIn{
            if expireTime > Int(Date().timeIntervalSince1970){
                return false
            }
        }
        return true
    }
    
    func shouldRefreshTokenCall() -> Bool {
        if !isRefreshTokenExpired() && isAccessTokenExpired(){
            return true
        }else{
            return false
        }
    }
    
//    var isUserFirstTimeLoggedIn
    
    func invalidateSession(){
        refreshToken = nil
        apiToken = nil
    }
    
    func invalidateDefaults(){
//        perpetualCoin = nil
//        accountTradingLevel = nil
    }
    
//    func setLoginInfo(loginInfo:SignInResponse) {
//        apiToken = loginInfo.access_token
//        refreshToken = loginInfo.refresh_token
//        tokenExpiredIn = Int(Date().timeIntervalSince1970) + (loginInfo.expires_in ?? 0)
//        refreshTokenExpiredIn = Int(Date().timeIntervalSince1970) + (loginInfo.refresh_expires_in ?? 0)
//        isUserLoggedIn = true
//    }
    
    func getAccessToken() -> String{
        if let apiToken = self.apiToken{
            return "Bearer \(apiToken)"
        }else{
            return ""
        }
    }
    
    func logout(){
        invalidateSession()
        invalidateDefaults()
        isUserLoggedIn = false
        loadView(view: InitialView())
    }
    
    // Account Trading level
    var accountTradingLevel: Int?{
        get{
            return UserDefaults.standard.integer(forKey: K.UserDefaultsKey.AccountTradingLevel)
        }set(accountTradingLevel){
            guard let accLevel = accountTradingLevel else {
                UserDefaults.standard.removeObject(forKey: K.UserDefaultsKey.AccountTradingLevel)
                UserDefaults.standard.synchronize()
                return
            }
            
            UserDefaults.standard.set(accLevel, forKey: K.UserDefaultsKey.AccountTradingLevel)
            UserDefaults.standard.synchronize()
        }
    }
}
