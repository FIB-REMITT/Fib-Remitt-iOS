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
    
    //case signIn(username:String, password: String)
    case createAccountSentOtp(username:String, password:String)
    case createAccount(username:String, password:String, otp:String)
    case refreshToken(refreshToken:String)
    case forgotPassSendOTP(username:String)
    case forgotPassVerifyOTP(username:String, otp:String)
    case forgotPassReset(username:String, otp:String, password:String)
    case ssoLogin(code: String)
    case authWithFIB(idToken:String, accessToken:String)
    
    var method: HTTPMethod {
        switch self {
        case  .createAccountSentOtp, .createAccount, .forgotPassSendOTP, .forgotPassVerifyOTP, .forgotPassReset, .refreshToken, .ssoLogin, .authWithFIB :
            return .post
        }
    }
    
    var path: String {
        switch self {
//        case .signIn:
//            return "api/v1/public/auth/signin"
          
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
        case .ssoLogin:
            return "auth/realms/fib-business-application/protocol/openid-connect/token"
        case .authWithFIB:
            return "api/v1/oauth/login/fib"
        }
    }
    
    var query: [String: String]?  {
        switch self {
            
//        case .signIn(let username, let password):
//            return ["email": username, "password": password, "grant_type": "password", "client_id": "mobile-app", "client_secret":"ytEoJitvmnEAzvKC5FGJCyYPpDBETCvG", "scope":"openid profile"]
            
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
        case .ssoLogin(let code):
            return ["grant_type":Constant.grant_type, "client_id":Constant.client_id, "client_secret":Constant.client_secret, "redirect_uri":Constant.redirect_url, "code": code ]
        case .authWithFIB(let idToken ,let accessToken):
            return ["idToken":idToken, "accessToken":accessToken]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .forgotPassSendOTP, .ssoLogin, .authWithFIB:
            return URLEncodedFormParameterEncoder.default
            
        default:
            return JSONParameterEncoder.default
        }
    }
    
    var contentType: String{
        switch self{
        case .forgotPassSendOTP, .ssoLogin, .authWithFIB:
            return ContentType.urlEncoded.rawValue
        default:
            return ContentType.json.rawValue
        }
    }
    
    var headerAuth: Bool{
        return false
    }
}

//MARK: - Basic EndPoints
enum BasicEndPoint: Endpoint {
    
    case getNationalities
    case getPurposes
    case getAllBanks
    case getAllCurrencies
    case currencyConversion
    
    var method: HTTPMethod {
        switch self {

        case .getNationalities, .getPurposes, .getAllBanks, .getAllCurrencies, .currencyConversion:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getNationalities:
            return "api/v1/private/nationalities"
          
        case .getPurposes:
            return "api/v1/private/purposes"
            
        case .getAllBanks:
            return "api/v1/public/bank"
            
            
        case .getAllCurrencies:
            return "api/v1/private/currencies"
            
        case .currencyConversion:
            return "api/v1/private/currency/IQD/all"
        }
    }
    
    var query: [String: String]?  {
        switch self {
            
        case .getNationalities, .getAllBanks, .getPurposes, .getAllCurrencies, .currencyConversion:
            return nil
            
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

//(fullName:String,nationalityId:String,phoneNumber:String, address:String, invoice:Data?)

//MARK: - Beneficiary EndPoint
enum BeneficiaryEndpoint: Endpoint {
    
    case getCashPickupBeneficiaries
    case getBankBeneficiaries
    case getCashPickupDetails(id:String)
    case getBankDetails(id:String)
    case createCashPickupPersonalBeneficiary(fullName:String, nationality:String, phoneNumber:String, address:String, gender:String, relationShip:String)
    case createCashPickupBusinessBeneficiary(fullName:String, nationality:String, phoneNumber:String, address:String)
    case createBankBusinessBeneficiary(fullName:String, nationality:String, phoneNumber:String, address:String, bankId:String, accNo:String)
    case createBankPersonalBeneficiary(fullName:String, nationality:String, phoneNumber:String, address:String, gender:String, relationShip:String, bankId:String, accNo:String)
    case resetPassword(newPassword: String)
    
    var method: Alamofire.HTTPMethod{
        switch self {
        case .createCashPickupPersonalBeneficiary, .createBankPersonalBeneficiary, .resetPassword, .createCashPickupBusinessBeneficiary, .createBankBusinessBeneficiary:
            return .post
            
        case .getCashPickupBeneficiaries, .getBankBeneficiaries, .getCashPickupDetails , .getBankDetails:
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .getCashPickupBeneficiaries:
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/cashpickup"
            
        case .getCashPickupDetails(let id):
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/cashpickup/\(id)"
        
        case .getBankDetails(let id):
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/bank/\(id)"
            
        case .createBankPersonalBeneficiary:
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/bank"
        
        case .resetPassword:
            return "api/v1/auth/reset-password"
        case .createCashPickupPersonalBeneficiary:
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/cashpickup"
        case .getBankBeneficiaries:
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/bank"
        case .createCashPickupBusinessBeneficiary(fullName: let fullName, nationality: let nationality, phoneNumber: let phoneNumber, address: let address):
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/cashpickup"
        case .createBankBusinessBeneficiary(fullName: let fullName, nationality: let nationality, phoneNumber: let phoneNumber, address: let address, bankId: let bankId, accNo: let accNo):
            return "api/v1/private/beneficiary/\(UserSettings.shared.getSUB())/bank"
        }
    }
    
    var query: [String : String]? {
        switch self {
            
        case .getCashPickupDetails, .getBankDetails:
            return nil

        case .createCashPickupPersonalBeneficiary(let fullName, let nationality, let phoneNumber, let address, let gender, let relationShip):
            return ["fullName":fullName, "nationalityId":nationality, "phoneNumber":phoneNumber, "address":address, "typeOfBeneficiary":"Personal","gender":gender, "relationship":relationShip]
            
        case .createBankPersonalBeneficiary(let fullName, let nationality, let phoneNumber, let address, let gender, let relationShip,let bankId, let accNo):
            return ["fullName":fullName, "nationalityId":nationality, "phoneNumber":phoneNumber, "address":address, "typeOfBeneficiary":"Personal","gender":gender, "relationship":relationShip, "bankId":bankId, "accountNumber":accNo]
            
        case .getCashPickupBeneficiaries, .getBankBeneficiaries:
            return nil
            
        case .resetPassword(let newPassword):
            return ["newPassword": newPassword, "confirmNewPassword": newPassword]
        case .createCashPickupBusinessBeneficiary(fullName: let fullName, nationality: let nationality, phoneNumber: let phoneNumber, address: let address):
            return ["fullName":fullName, "nationalityId":nationality, "phoneNumber":phoneNumber, "address": address, "typeOfBeneficiary":"Business"]
            //"fullName": fullName,"nationalityId": nationalityId, "phoneNumber" : phoneNumber, "address": address, "typeOfBeneficiary":"Business"
        case .createBankBusinessBeneficiary(fullName: let fullName, nationality: let nationality, phoneNumber: let phoneNumber, address: let address, bankId: let bankId, accNo: let accNo):
            return ["fullName":fullName, "nationalityId":nationality, "phoneNumber":phoneNumber, "address":address,"typeOfBeneficiary":"Business","bankId":bankId, "accountNumber":accNo]
           // "fullName": fullName,"nationalityId": nationalityId, "phoneNumber" : phoneNumber, "address": address, "typeOfBeneficiary":"Business", "bankId" : bankId, "accountNumber" : accountNo
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .resetPassword, .createCashPickupPersonalBeneficiary, .createBankPersonalBeneficiary:
            return MultipartFormData() as! ParameterEncoder
            
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
    case confirmationByTrx(trxId:String)
    case confirmationPaymentByTrx(trxId:String)
    
    var method: Alamofire.HTTPMethod{
        switch self {
        case .getInstrumentKeywordSearch, .getInstrumentGroupSearch, .getCurrencyClass, .getCoins, .getCoinLogo,.confirmationPaymentByTrx:
            return .get
        case .sendFcm:
            return .put
//        case .bankReceivedInBank:
//            return .post
        case .confirmationByTrx:
            return .post
       
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

        case .confirmationByTrx(trxId: let transactionId):
            return "api/v1/private/transfer/personal/transaction/\(transactionId)"
        case .confirmationPaymentByTrx(trxId: let transactionId):
            return "api/v1/transfer/status"
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
            
        case .confirmationByTrx:
            return nil
        case .confirmationPaymentByTrx(trxId: let transactionId):
            return ["transactionId":transactionId]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .getInstrumentGroupSearch,.sendFcm,.confirmationPaymentByTrx:
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



//MARK: - TransactionList EndPoints
enum TransactionListEndpoint: Endpoint{
    case TransactionList(page: Int, from:String, to:String)
    case TransactionDetails(transactionNumber: String)
    
    var method: HTTPMethod{
        switch self{
        case .TransactionList,.TransactionDetails:
            return .get
            
        }
    }
    
    var path: String{
        switch self {
        case .TransactionList:
            return "api/v1/private/personal/transaction"
        case .TransactionDetails(transactionNumber: let trxNumber):
            return "api/v1/private/personal/transaction/\(trxNumber)"
            
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .TransactionList(let page, let from , let to):
            var parameters  = [String: String]()
            parameters["page"] = "\(page)"
            
            if from.isBlankOrEmpty == false && to.isBlankOrEmpty == false{
                parameters["from"] = "\(from)"
                parameters["to"] = "\(to)"
            }
            
            return parameters
            
        case .TransactionDetails:
            return nil
            
        }
    }
    
    var encoder: ParameterEncoder {
       
        switch self{
        case .TransactionList:
            return  URLEncodedFormParameterEncoder.default
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
