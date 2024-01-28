//
//  EndPoint.swift
//  FIB
//
//  Created by Ainul Kazi on 29/1/23.
//

import Foundation
import Alamofire


//MARK: - Authentication EndPoints
enum AuthEndPoint: Endpoint {
    
    case signIn(username:String, password: String)
    case createAccountSentOtp(username:String, password:String)
    case createAccount(username:String, password:String, otp:String)
    case refreshToken(refreshToken:String)
    case forgotPassSendOTP(username:String)
    case forgotPassVerifyOTP(username:String, otp:String)
    case forgotPassReset(username:String, otp:String, password:String)
    
    var method: HTTPMethod {
        switch self {
        case .signIn, .createAccountSentOtp, .createAccount, .forgotPassSendOTP, .forgotPassVerifyOTP, .forgotPassReset, .refreshToken :
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "api/v1/public/auth/signin"
          
        case .createAccountSentOtp:
            return "api/v1/auth/sign-up/send-otp"
            
        case .createAccount:
            return "api/v1/auth/sign-up"
            
        case .forgotPassSendOTP:
            return "api/v1/auth/forgot-password/send-otp"
            
        case .forgotPassVerifyOTP:
            return "api/v1/auth/forgot-password/verify-otp"
            
        case .forgotPassReset:
            return "api/v1/auth/forgot-password/reset"
            
        case .refreshToken:
            return "api/v1/auth/refresh-token"
        }
    }
    
    var query: [String: String]?  {
        switch self {
            
        case .signIn(let username, let password):
            return ["email": username, "password": password, "grant_type": "password", "client_id": "mobile-app", "client_secret":"ytEoJitvmnEAzvKC5FGJCyYPpDBETCvG", "scope":"openid profile"]
            
        case .createAccountSentOtp(let username, let password):
            return ["username": username, "password": password]
            
        case .createAccount( let username, let password, let otp):
            return ["username": username, "password": password, "otp": otp]
            
        case .forgotPassSendOTP(let username):
            return ["username":username]
            
        case .forgotPassVerifyOTP( let username, let otp):
            return ["username":username, "otp":otp]
            
        case .forgotPassReset(let username, let otp, let password):
            return ["username":username, "otp":otp, "password":password]
            
        case .refreshToken(let refreshToken):
            return ["grant_type":"refresh_token", "client_id":"mobile-app", "client_secret":"rYTLJ0lgPKUHNluGaSDEeyT2hou2KYq5", "refresh_token":refreshToken]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .forgotPassSendOTP:
            return URLEncodedFormParameterEncoder.default
            
        default:
            return JSONParameterEncoder.default
        }
    }
    
    var contentType: String{
        switch self{
        case .forgotPassSendOTP:
            return ContentType.urlEncoded.rawValue
        default:
            return ContentType.json.rawValue
        }
    }
    
    var headerAuth: Bool{
        return false
    }
}

//MARK: - Profile EndPoints

enum ProfileEndPoint: Endpoint {
    
    case getUserProfile
    case updateUserProfile(nickname:String, isClosed:Bool, isFrozen:Bool, profilePicture:String)
    case getUserPreference
    case updateUserPreference(localCurrency:String, stableCoinPreference:String, timeZone:String)
    case getUserSecurity
    case updateUserSecurity(isEmailVerified:Bool, isMobileVerified:Bool)
    case getUserSecurityCode(verificationType:String,medium:String)
    case updateUserSecurityInfo(verificationType:String,medium:String,otp:String)
    case getAppConfig
    
    var method: HTTPMethod {
        switch self {
        case .getUserProfile, .getUserPreference, .getUserSecurity, .getAppConfig:
            return .get
            
        case .updateUserProfile, .updateUserPreference, .updateUserSecurity, .updateUserSecurityInfo:
            return .put
            
        case .getUserSecurityCode:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getUserProfile, .updateUserProfile:
            return "api/v1/profile/user-profile"
            
        case .getUserPreference, .updateUserPreference:
            return "api/v1/profile/preference"
            
        case .getUserSecurity, .updateUserSecurity:
            return "api/v1/profile/security"
            
        case .getUserSecurityCode:
            return "api/v1/profile/security/send-otp"
            
        case .updateUserSecurityInfo:
            return "api/v1/profile/security/verify-update"
      
        case .getAppConfig:
            return "api/v1/config/user-config"
        
        }
    }
    
    var query: [String: String]?  {
        switch self {
        case .getUserProfile, .getUserPreference, .getUserSecurity,.getAppConfig:
            return nil
            
        case .updateUserProfile(let nickname, let isClosed, let isFrozen, let profilePicture):
            return [ "nickname":nickname, "isClosed":"\(isClosed)", "isFrozen":"\(isFrozen)", "profilePicture": "\(profilePicture)"]
            
        case .updateUserPreference(let localCurrency, let stableCoinPreference, let timeZone):
            return ["localCurrency":localCurrency, "stableCoinPreference":stableCoinPreference, "timeZone":timeZone]
            
        case .updateUserSecurity(let isEmailVerified, let isMobileVerified):
            return ["isEmailVerified":"\(isEmailVerified)", "isMobileVerified":"\(isMobileVerified)"]
            
        case .getUserSecurityCode(verificationType: let verificationType , medium: let medium):
            return ["verificationType":"\(verificationType)", "medium":"\(medium)"]
            
        case .updateUserSecurityInfo(verificationType: let verificationType , medium: let medium,otp: let otp):
            return ["verificationType":"\(verificationType)", "medium":"\(medium)","otp":"\(otp)"]
            
        }
    }
}

//MARK: - Security EndPoint
enum SecurityEndpoint: Endpoint {
    
    case enableTwoFA(verificationType: String, medium: String)
    case verifyTwoFA(verificationType: String, medium: String, otp:String)
    case disableTwoFA(otp: String)
    case getGoogleAuthSecret
    case submitAuthentictorSecret(authenticator:String, secret:String, otp:String, totp:String)
    case sentOTPSecurityUpdate(verificationType:String, medium:String)
    case resetPassword(newPassword: String)
    
    var method: Alamofire.HTTPMethod{
        switch self {
        case .enableTwoFA, .verifyTwoFA, .disableTwoFA, .submitAuthentictorSecret, .sentOTPSecurityUpdate, .resetPassword:
            return .post
            
        case .getGoogleAuthSecret:
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .enableTwoFA:
            return "api/v1/auth/verify-selected-2fa"
            
        case .verifyTwoFA:
            return "api/v1/auth/add-2fa"
        
        case .disableTwoFA:
            return "api/v1/auth/reset-2fa"

        case .getGoogleAuthSecret, .submitAuthentictorSecret:
            return "api/v1/auth/authenticator"
            
        case .sentOTPSecurityUpdate:
            return "api/v1/profile/security/send-otp"
        
        case .resetPassword:
            return "api/v1/auth/reset-password"
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .enableTwoFA(let verificationType, let medium):
            return ["verificationType": "\(verificationType)", "twoFactorAuthMedium": "\(medium)"]
            
        case .verifyTwoFA(let verificationType, let medium, let otp):
            return ["verificationType": "\(verificationType)", "twoFactorAuthMedium": "\(medium)", "otp":"\(otp)"]
            
        case .disableTwoFA(let otp):
            return ["otp": "\(otp)"]

        case .submitAuthentictorSecret(let authenticator, let secret, let otp, let totp):
            return ["authenticatorApp":authenticator, "secret":secret, "otp":otp, "totp":totp]
            
        case .sentOTPSecurityUpdate(let verificationType, _ ):
            return ["verificationType":verificationType, "medium": ""]
            
        case .getGoogleAuthSecret:
            return nil
            
        case .resetPassword(let newPassword):
            return ["newPassword": newPassword, "confirmNewPassword": newPassword]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .enableTwoFA, .verifyTwoFA, .disableTwoFA:
            return URLEncodedFormParameterEncoder.default
            
        default:
            return JSONParameterEncoder.default
        }
    }
}

//MARK: - Dashboard EndPoints
enum DashboardEndpoint: Endpoint {
    
    case getInstrumentKeywordSearch(searchKey: String)
    case getInstrumentGroupSearch(instType: String = "", instId: String = "", baseCcy: String = "", settleCcy: String = "", searchKey: String = "")
    case getCoinLogo
    case getCurrencyClass
    case getCoins
    case sendFcm(fcmKey:String)
    
    var method: Alamofire.HTTPMethod{
        switch self {
        case .getInstrumentKeywordSearch, .getInstrumentGroupSearch, .getCurrencyClass, .getCoins, .getCoinLogo:
            return .get
        case .sendFcm:
            return .put
        }
    }
    
    var path: String{
        switch self {
        case .getInstrumentKeywordSearch(let searchKey):
            return "api/v1/crypto/instruments/\(searchKey)"
        case .getInstrumentGroupSearch:
            return "api/v1/crypto/instruments/by-group"
        case .getCoinLogo:
            return "api/v1/crypto/coin/logo"
        case .getCurrencyClass:
            return "api/v1/broker-connector/crypto/currency-classification"
        case .getCoins:
            return "api/v1/broker-connector/crypto/coin-list"
        case .sendFcm:
            return "api/v1/notification/fcm-registration"
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .getInstrumentKeywordSearch, .getCurrencyClass, .getCoins, .getCoinLogo:
            return nil
        case .getInstrumentGroupSearch(let instType, let instId, let baseCcy, let settleCcy,  _):
            return ["instType": instType, "instId": instId, "baseCcy": baseCcy, "settleCcy": settleCcy, "searchKey":"USDT"]
        case .sendFcm(fcmKey: let token):
            return ["registrationToken":token]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .getInstrumentGroupSearch,.sendFcm:
            return URLEncodedFormParameterEncoder.default
        default:
            return JSONParameterEncoder.default
        }
    }
}


//MARK: - FIAT EndPoints
enum FiatEndpoint: Endpoint{
    case getFiatCurrency
    case getPaymentMethod
    case getCryptoCurrency
    case getPriceConversion(amount: String, from: String, to: String)
    case initiatePayment(amount: String, from: String, to: String)
    case proceedPaymentMethod(orderId: String, methodId: String)
    case confirmPayment(orderId: String, methodId: String)
    
    var method: HTTPMethod{
        switch self{
        case .getFiatCurrency, .getPaymentMethod, .getCryptoCurrency, .getPriceConversion:
            return .get
        case .initiatePayment, .proceedPaymentMethod, .confirmPayment:
            return .post
        }
    }
    
    var path: String{
        switch self {
        case .getFiatCurrency:
            return "api/v1/currency/fiat"
        case .getPaymentMethod:
            return "api/v1/payment-method"
        case .getCryptoCurrency:
            return "api/v1/currency/crypto"
        case .getPriceConversion:
            return "api/v1/currency/price-conversion"
        case .initiatePayment:
            return "api/v1/buy/initialize"
        case .proceedPaymentMethod:
            return "api/v1/buy/payment-method"
        case .confirmPayment:
            return "api/v1/buy/payment-method/confirm"
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .getFiatCurrency, .getPaymentMethod, .getCryptoCurrency:
            return nil
        case .getPriceConversion(let amount, let from, let to):
            return ["amount": amount, "from": from, "to": to]
        case .initiatePayment(let amount, let from, let to):
            return ["amount": amount, "from": from, "to": to]
        case .proceedPaymentMethod(let orderId, let methodId):
            return ["orderId": orderId, "paymentMethodId": methodId]
        case .confirmPayment(let orderId, let methodId):
            return ["orderId": orderId, "paymentMethodId": methodId]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .getPriceConversion, .initiatePayment, .proceedPaymentMethod, .confirmPayment:
            return URLEncodedFormParameterEncoder.default
        default:
            return JSONParameterEncoder.default
        }
    }
}

//MARK: - SellCrypto EndPoints
enum SellCryptoEndpoint: Endpoint{
    case getSellCryptoCoins
    case initializeSell(cryptoId:String)
    case submitSellDetails(orderId:String, amount:String, walletAddress:String, paymentMethodId:String)
    case sellCryptoSentOtp(medium: String)
    case cryptoSellRequest(email:String, emailOtp:String, phone:String, phnOtp:String, orderId:String, googleAuthOtp:String)
    
    var method: HTTPMethod{
        switch self{
        case .getSellCryptoCoins:
            return .get
        case .initializeSell, .submitSellDetails, .sellCryptoSentOtp, .cryptoSellRequest:
            return .post
        }
    }
    
    var path: String{
        switch self {
        case .getSellCryptoCoins:
            return "api/v1/sell/crypto-currency"
        case .initializeSell:
            return "api/v1/sell/initialize"
        case .submitSellDetails:
            return "api/v1/sell/process"
        case .sellCryptoSentOtp:
            return "api/v1/sell/send-otp"
        case .cryptoSellRequest:
            return "api/v1/sell/verify-otp"
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .getSellCryptoCoins:
            return nil
        case .initializeSell(let id):
            return ["cryptoId":id]
        case .submitSellDetails(let orderId, let amount, let walletAddress, let paymentMethod):
            return ["orderId":orderId, "amount":amount, "walletAddress": walletAddress, "paymentMethodId":paymentMethod]
        case .sellCryptoSentOtp(let medium):
            return ["otpMedium":medium]

        case .cryptoSellRequest(let email,let emailOtp, let phone, let phnOtp, let orderId, let googleAuthOtp):
            return ["email": email, "emailOtp": emailOtp, "phone":phone,"phnOtp":phnOtp,"orderId":orderId,"googleAuthOtp":googleAuthOtp]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .sellCryptoSentOtp, .initializeSell, .submitSellDetails, .cryptoSellRequest:
            return URLEncodedFormParameterEncoder.default
        default:
            return JSONParameterEncoder.default
        }
    }
}
/**
 *  Protocol for all endpoints to conform to.
 */

//MARK: - EndPoint

protocol Endpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var query: [String: String]? { get }
    var contentType:String{get}
    var encoder: ParameterEncoder { get }
    var headerAuth: Bool {get}
}

extension Endpoint {
    var contentType: String{get{return ContentType.json.rawValue}}
    var encoder: ParameterEncoder { get{return JSONParameterEncoder.default} set {} }
    var headerAuth:Bool{return true}
}
