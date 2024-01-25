//
//  EndPoint.swift
//  IQDX
//
//  Created by Ainul Kazi on 29/1/23.
//

import Foundation
import Alamofire


//MARK: - Authentication EndPoints

enum AuthEndPoint: Endpoint {
    
    case signIn(username:String, password: String , otp:String)
    case createAccountSentOtp(username:String, password:String)
    case createAccount(username:String, password:String, otp:String)
    case refreshToken(refreshToken:String)
    case forgotPassSendOTP(username:String)
    case forgotPassVerifyOTP(username:String, otp:String)
    case forgotPassReset(username:String, otp:String, password:String)
    
    var method: HTTPMethod {
        switch self {
        case .signIn,.createAccountSentOtp, .createAccount, .forgotPassSendOTP, .forgotPassVerifyOTP, .forgotPassReset, .refreshToken :
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "api/v1/auth/sign-in"
          
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
            
        case .signIn(let username, let password, let otp):
            if otp.isEmpty{
                return ["username": username, "password": password, "grant_type": "password", "client_id": "mobile-app", "client_secret":"rYTLJ0lgPKUHNluGaSDEeyT2hou2KYq5"]
            }else{
                return ["username": username, "password": password, "grant_type": "password", "client_id": "mobile-app", "client_secret":"rYTLJ0lgPKUHNluGaSDEeyT2hou2KYq5", "otp":otp]
            }
            
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

//MARK: - Assets EndPoints
enum AssetsEndPoint: Endpoint {
    
    case getAssetsOverview(currency:String = "")
    case getFundingBalance
    case getCurrencies
    case transferFundFromFunding(ccy:String, amount:String)
    case transferFundFromTrading(ccy:String, amount:String)
    case getDepositAddress(ccy:String)
    case getDepositHistory
    case getAssetsHistory
    case getAccountBalance
    case getPnlData(accountType:String)
    case fundWithdrawRequest(ccy:String, amount:String, address:String, chain:String, fee:String, areaCode:String)
    
    var method: HTTPMethod {
        switch self {
        case .getAssetsOverview, .getFundingBalance, .getCurrencies , .getDepositAddress, .getDepositHistory, .getAccountBalance, .getAssetsHistory, .getPnlData:
            return .get
        case .transferFundFromFunding, .transferFundFromTrading, .fundWithdrawRequest:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getAssetsOverview(let currency):
            return "api/v1/funding/asset-overview?ccy=\(currency)"
        case .getFundingBalance:
            return "api/v1/funding/funding-balance"
        case .getCurrencies:
            return "api/v1/funding/asset-currencies"
        case .transferFundFromFunding:
            return "api/v1/funding/transfer/funding-to-trading"
        case .transferFundFromTrading:
            return "api/v1/funding/transfer/trading-to-funding"
        case .getDepositAddress(let ccy):
            return "api/v1/funding/all-deposit-addresses?ccy=\(ccy)"
        case .getDepositHistory:
            return "api/v1/funding/deposit-history"
        case .getAccountBalance:
            return "api/v1/account/trading-balance"
        case .fundWithdrawRequest:
            return "api/v1/funding/onchain-withdrawal"
        case .getAssetsHistory:
            return "api/v1/funding/funding-history"
        case .getPnlData(let accountType):
            return "api/v1/funding/calculate-portfolio/asset-overview?typeOfAccount"//=\(accountType)&startDate=\("".todayDate())&endDate=\("".todayDate())"
        }
    }
    
    var query: [String: String]?  {
        switch self {
        case .getAssetsOverview, .getFundingBalance, .getCurrencies, .getDepositAddress, .getDepositHistory, .getAccountBalance, .getAssetsHistory, .getPnlData:
            return nil
        case .transferFundFromFunding(let ccy,  let amount), .transferFundFromTrading(let ccy, let amount):
            return ["ccy": ccy, "amt": amount]
        case .fundWithdrawRequest(let ccy, let amount, let address, let chain, let fee, let areaCode):
            return ["ccy": ccy, "amt": amount, "toAddr": address, "chain": chain, "fee": fee, "areaCode": areaCode]
        }
    }
}

//MARK: - AssetWithdraw EndPoints

enum AssetWithdrawEndpoint: Endpoint {
    case withdrawConfig(ccy: String)
    case withdrawRequest(ccy: String, amount:String, address:String, chain:String, fee:String)
    case internalWithdrawRequest(ccy:String, amt:String, withdrawEmail:String, withdrawPhn:String, withdrawUid:String, note:String)
    case sentWithdrawOTP(withdrawId:String, email:String, phone:String)
    case verifyWithdrawOTP(withdrawId:String, email:String, emailOtp:String, phone:String, phnOtp:String, googleCode:String)
    case getWithdrawHistory(clientId:String, txId:String, type:String, state:String, after:String, before:String, limit:String)
    
    var method: Alamofire.HTTPMethod{
        switch self {
        case .getWithdrawHistory, .withdrawConfig:
            return .get
        case .withdrawRequest, .internalWithdrawRequest, .sentWithdrawOTP, .verifyWithdrawOTP:
            return .post
        }
    }
    
    var path: String{
        switch self {
        case .withdrawConfig(let ccy):
            return "api/v1/funding/withdraw/withdrawal-config?ccy=\(ccy)"
        case .withdrawRequest:
            return "api/v1/funding/onchain-withdrawal"
        case .internalWithdrawRequest:
            return "api/v1/funding/internal-withdrawal"
        case .sentWithdrawOTP:
            return "api/v1/funding/send-withdrawal-otp"
        case .verifyWithdrawOTP:
            return "api/v1/funding/verify-withdraw-otp"
        case .getWithdrawHistory(let clientId, let txId, let type, let state, let after, let before, let limit):
            return "api/v1/funding/withdrawal-history?clientId=\(clientId)&txId=\(txId)&type=\(type)&state=\(state)&after=\(after)&before=\(before)&limit=\(limit)"
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .withdrawRequest(let ccy, let amount, let address, let chain, let fee):
            return ["ccy":ccy, "amt":amount, "toAddr":address, "chain":chain, "fee": fee, "dest":"4"]
            
        case .internalWithdrawRequest(let ccy, let  amt, let withdrawEmail, let withdrawPhn, let withdrawUid, let note):
            return ["ccy":ccy, "amt":amt, "withdrawEmail":withdrawEmail, "withdrawPhone":withdrawPhn, "withdrawUid":withdrawUid, "note": note]
            
        case .sentWithdrawOTP(let withdrawId, let email, let phone):
            if email.isEmpty{
                return ["withdrawId": withdrawId, "phone": phone]
            }else if phone.isEmpty{
                return ["withdrawId": withdrawId, "email": email]
            }else{
                return ["withdrawId": withdrawId, "email": email, "phone": phone]
            }
            
        case .verifyWithdrawOTP(let withdrawId, let email, let emailOtp, let phone, let phnOtp, let googleCode):
            if email.isEmpty{
                return ["withdrawId":withdrawId, "phone":phone, "phnOtp":phnOtp]
            }else if phone.isEmpty{
                if googleCode.isEmpty{
                    return ["withdrawId":withdrawId, "email":email, "emailOtp":emailOtp]
                }else{
                    return ["withdrawId":withdrawId, "email":email, "emailOtp":emailOtp, "tOtp": googleCode]
                }
            }else{
                return ["withdrawId":withdrawId, "email":email, "emailOtp":emailOtp, "phone":phone, "phnOtp":phnOtp]
            }
                
        case .getWithdrawHistory, .withdrawConfig:
            return nil
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .withdrawRequest, .sentWithdrawOTP, .verifyWithdrawOTP, .internalWithdrawRequest:
            return URLEncodedFormParameterEncoder.default
        default:
            return JSONParameterEncoder.default
        }
    }
}

//MARK: - Trade EndPoints
enum TradeEndPoint: Endpoint{
    
    case getTradeConfig
    case getOrderList(instType: String, instId: String)
    case getOrderDetails(instType: String, instId: String, ordId: String, clOrdId: String)
    case createSpotOrder(orderType: String, instId: String, side: String, tradeSize: String, orderPrice: String, tradeType:String = "")
    case createSpotOrderTpSl(orderType: String, instId: String, side: String, tradeSize: String, orderPrice: String, tradeType:String = "", tpTriggerPx:String = "", tpOrdPx:String = "", slTriggerPx:String = "", slOrdPx:String = "",slTriggerPxType:String = "index")
    case updateSpotOrder(orderMode: String, instId: String, ordId: String, clOrdId: String, newSize: String, newPrice: String, cancelOnFail: Bool)
    case cancelSpotOrder(orderMode: String, instId: String, ordId: String, clOrdId: String, orderCategory:String)
    
    var method: HTTPMethod{
        switch self {
        case .getTradeConfig, .getOrderList, .getOrderDetails:
            return .get
        case .createSpotOrder, .createSpotOrderTpSl, .updateSpotOrder, .cancelSpotOrder:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getTradeConfig:
            return "api/v1/trade/trade-config"
        case .getOrderList(let instType, let instId):
            return "api/v1/trade/order-list?instType=\(instType)&instId=\(instId)"
        case .getOrderDetails(let instType, let instId, let ordId, let clOrdId):
            return "api/v1/trade/order-details?instType=\(instType)&instId=\(instId)&ordId=\(ordId)&clOrdId=\(clOrdId)"
        case .createSpotOrder, .createSpotOrderTpSl:
            return "api/v1/trade/spot-order"
        case .updateSpotOrder:
            return "api/v1/trade/amend-order"
        case .cancelSpotOrder:
            return "api/v1/trade/cancel-order"
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .getTradeConfig, .getOrderList, .getOrderDetails:
            return nil
        case .createSpotOrder(let orderType, let instId, let side, let tradeSize, let orderPrice, let tradeType):
            return ["orderType": orderType, "instId": instId, "side": side, "tradeSize": tradeSize, "orderPrice": orderPrice, "tradeType":tradeType]
        case .createSpotOrderTpSl(let orderType, let instId, let side, let tradeSize, let orderPrice, let tradeType, let tpTriggerPx, let tpOrdPx, let slTriggerPx, let slOrdPx , let slTriggerPxType):
            return ["orderType": orderType, "instId": instId, "side": side, "tradeSize": tradeSize, "orderPrice": orderPrice, "tradeType":tradeType, "tpTriggerPx":tpTriggerPx, "tpOrdPx":tpOrdPx, "slTriggerPx":slTriggerPx,"slOrdPx":slOrdPx, "siTriggerPxType":slTriggerPxType]
        case .updateSpotOrder(let orderMode, let instId, let ordId, let clOrdId, let newSize, let newPrice, let cancelOnFail):
            return ["orderMode": orderMode, "instId": instId, "ordId": ordId, "clOrdId": clOrdId, "newSize": newSize, "newPrice": newPrice, "cancelOnFail": String(cancelOnFail)]
        case .cancelSpotOrder(let orderMode, let instId, let ordId, let clOrdId, _): //algoClOrdId:String,algoId:String,orderCategory:String
            return ["orderMode": orderMode, "instId": instId, "ordId": ordId, "clOrdId": clOrdId,"orderCategory":"regular"]
        }
    }
}

// MARK: - Trade Perpetual EndPoint
enum TradePerpetualEndpoint: Endpoint {
    
    case perpPlaceOrder(tradeType:String, orderType:String, instId:String, tradeMode:String, side:String, posSide:String, tradeSize:String, orderPrice:String, tgtCcy:String, banAmend:String, tpTriggerPx:String, tpOrdPx:String, slTriggerPx:String, slOrdPx:String, tpTriggerPxType:String, slTriggerPxType:String, unit:String, clOrdId:String, reduceOnly:String)
    case updatePerpOrder(orderMode: String, instId: String, ordId: String, clOrdId: String, newSize: String, newPrice: String, cancelOnFail: String)
    case subSetAccountLvl(setLvl:String)
    case getFundingRate(instaId: String)
    case getLeverage(instaId:String, mngMode:String)
    case setLeverage(instaId:String, mngMode:String, lever:String, ccy:String, posSide:String)
    case getPosition(instType:String, instId:String, posId:String)
    case setPositionMode(posMode:String)
    case closeAllPosition(orderMode: String, instId: String, posSide: String, mgnMode: String, autoCxl: String)
    case getAccountAndPosition(instType:String)
    case getAccountConfiguration
    case getMaxTradableSizeForInst(instId:String, tdMode:String, ccy:String, px:String, leverage:String, upSpotOffset:String)
    case getMaxTradableAmount(instId:String, tdMode:String, ccy:String, reduceOnly:String, px:String, unSpotOffset:String)
    case changeMargin(instId:String, posSide:String, type:String, amt:String, loanTrans:String, ccy:String, auto:String)
    case getFeeRates(instType:String, instId:String, uly:String, instFamily:String)
    case getInstrument(instType:String, instId:String, uly:String, instFamily:String)
    case getMarkPrice(instType:String, instId:String, uly:String, instFamily:String)
    case cancelOrder(orderMode: String, orderCategory: String, instId: String, ordId: String, clOrdId: String, algoId: String)
    case getAlgoOrder(algoId: String, instType: String, instId: String, ordType: String)
    case getOrderDetails(instType: String, instId: String, ordId: String, clOrdId: String)
    case getOrderHistory(instType: String, uly: String, instId: String, ordType: String, instFamily: String, state: String, category: String, after: String, before: String, limit: String, end: String)
    
    var method: Alamofire.HTTPMethod{
        switch self {
        case .setLeverage, .setPositionMode, .changeMargin, .subSetAccountLvl, .perpPlaceOrder, .updatePerpOrder, .closeAllPosition, .cancelOrder:
            return .post
            
        case .getFundingRate, .getLeverage, .getPosition, .getAccountAndPosition, .getAccountConfiguration, .getMaxTradableSizeForInst,
                .getMaxTradableAmount, .getFeeRates, .getInstrument, .getMarkPrice, .getAlgoOrder, .getOrderDetails, .getOrderHistory:
            return .get
        }
    }
    
    var path: String{
        switch self {
            case .perpPlaceOrder:
                return "api/v1/trade/swap-order"
            
            case .updatePerpOrder:
                return "api/v1/trade/amend-order"
                
            case .subSetAccountLvl:
                return "api/v1/account/set-account-level"
                
            case .getFundingRate(let instId):
                return "api/v1/broker-connector/public-data/get-funding-rate?instId=\(instId)"
                
            case .getLeverage(let instId, let mngMode):
                return "api/v1/account/get-leverage?instId=\(instId)&mgnMode=\(mngMode)"
                
            case .setLeverage:
                return "api/v1/account/set-leverage"
                
            case .getPosition(let instType, let instId, let posId):
                return "api/v1/account/positions?instType=\(instType)&insId=\(instId)&posId=\(posId)"
                
            case .setPositionMode:
                return "api/v1/account/set-position-mode"
                
            case .closeAllPosition:
                return "api/v1/trade/close-position"
                
            case .getAccountAndPosition(let instType):
                return "api/v1/account/acc-position?instType=\(instType)"
                
            case .getAccountConfiguration:
                return "api/v1/account/acc-configuration"
                
            case .getMaxTradableSizeForInst(let instId, let tdMode, let ccy, let px, let leverage, let upSpotOffset):
                return "api/v1/account/maximum-tradable-size-for-instrument?instId=\(instId)&tdMode=\(tdMode)&ccy=\(ccy)&px=\(px)&leverage=\(leverage)&unSpotOffset=\(upSpotOffset)"
                
            case .getMaxTradableAmount(let instId, let tdMode, let ccy, let reduceOnly, let px, let unSpotOffset):
                return "api/v1/account/maximum-available-tradable-amount?instId=\(instId)&tdMode=\(tdMode)&ccy=\(ccy)&reduceOnly=\(reduceOnly)&px=\(px)&unSpotOffset=\(unSpotOffset)"
                
            case .changeMargin:
                return "api/v1/account/increase-decrease-margin"
                
            case .getFeeRates(let instType, let instId, let uly, let instFamily):
                return "api/v1/account/fee-rates?instType=\(instType)&instId=\(instId)&uly=\(uly)&instFamily=\(instFamily)"
                
            case .getInstrument(let instType, let instId,  let uly, let instFamily):
                return "api/v1/broker-connector/public-data/get-instruments?instType=\(instType)&uly=\(uly)&instFamily=\(instFamily)&instId=\(instId)" //&uly=&instFamily=&instId=BTC-USD-SWAP
                
            case .getMarkPrice(let instType, let instId, let uly, let instFamily):
                return "api/v1/broker-connector/public-data/get-mark-price?instType=\(instType)&uly=\(uly)&instFamily=\(instFamily)&instId=\(instId)"
                
            case .cancelOrder:
                return "api/v1/trade/cancel-order"
                
            case .getAlgoOrder(let algoId, let instType, let instId, let ordType):
                return "api/v1/trade/algo-order-list?algoId=\(algoId)&instType=\(instType)&instId=\(instId)&ordType=\(ordType)"
                
            case .getOrderDetails(let instType, let instId, let ordId, let clOrdId):
                return "api/v1/trade/order-details?instType=\(instType)&instId=\(instId)&ordId=\(ordId)&clOrdId=\(clOrdId)"
        
            case .getOrderHistory(let instType, let uly, let instId, let ordType, let instFamily, let state, let category, let after, let before, let limit, let end):
                    return "api/v1/trade/order-history-3months?instType=\(instType)&uly=\(uly)&instId=\(instId)&ordType=\(ordType)&instFamily=\(instFamily)&state=\(state)&category=\(category)&after=\(after)&before=\(before)&limit=\(limit)&end=\(end)"
              
        }
    }
    
    var query: [String : String]? {
        switch self {
            case  .getFundingRate, .getLeverage, .getPosition, .getAccountAndPosition, .getAccountConfiguration, .getMaxTradableSizeForInst, .getMaxTradableAmount,
                .getInstrument, .getMarkPrice, .getAlgoOrder, .getOrderDetails, .getOrderHistory:
                return nil
                
            case .subSetAccountLvl(let setLvl):
                return ["accountLevel": setLvl]
                
            case .setLeverage(let instaId, let mngMode, let lever, let ccy, let posSide):
                return ["instId": instaId, "lever": lever, "mgnMode": mngMode, "ccy":ccy, "posSide":posSide]
                
            case .setPositionMode(let posMode):
                return ["posMode":posMode]
                
            case .closeAllPosition(let orderMode, let instId, let posSide, let mgnMode, let autoCxl):
                return ["orderMode": orderMode, "instId": instId, "posSide": posSide, "mgnMode": mgnMode, "autoCxl": autoCxl]
                
            case .changeMargin(let instId, let posSide, let type, let amt, let loanTrans, let ccy, let auto):
                return ["instId":instId, "posSide":posSide, "type":type, "amt":amt, "loanTrans":loanTrans, "ccy":ccy, "auto":auto]
                
            case .getFeeRates(let instType, let instId, let uly, let instFamily):
                return ["instType":instType, "instId":instId, "uly":uly, "instFamily":instFamily]
                
            case .perpPlaceOrder( let tradeType, let orderType, let instId, let tradeMode, let side, let posSide, let tradeSize, let orderPrice, let tgtCcy, let banAmend, let tpTriggerPx, let tpOrdPx, let slTriggerPx, let slOrdPx, let tpTriggerPxType, let slTriggerPxType, let unit, let clOrdId, let reduceOnly):
                return ["tradeType":tradeType, "orderType":orderType, "instId":instId, "tradeMode":tradeMode, "side":side, "posSide":posSide, "tradeSize":tradeSize, "orderPrice":orderPrice, "tgtCcy":tgtCcy, "banAmend":banAmend, "tpTriggerPx":tpTriggerPx, "tpOrdPx":tpOrdPx, "slTriggerPx":slTriggerPx, "slOrdPx":slOrdPx, "tpTriggerPxType":tpTriggerPxType, "slTriggerPxType":slTriggerPxType, "unit": unit, "clOrdId":clOrdId, "reduceOnly":reduceOnly]

            case .updatePerpOrder(let orderMode, let instId, let ordId, let clOrdId, let newSize, let newPrice, let cancelOnFail):
                return ["orderMode": orderMode, "instId": instId, "ordId": ordId, "clOrdId": clOrdId, "newSize": newSize, "newPrice": newPrice, "cancelOnFail": cancelOnFail]

            case .cancelOrder(let orderMode, let orderCategory, let instId, let ordId, let clOrdId, let algoId):
                return ["orderMode": orderMode, "orderCategory": orderCategory, "instId": instId, "ordId": ordId, "clOrdId": clOrdId, "algoId": algoId]
        }
    }
    
    var encoder: ParameterEncoder {
        switch self{
        case .setLeverage, .setPositionMode, .changeMargin, .subSetAccountLvl, .perpPlaceOrder, .updatePerpOrder, .cancelOrder:
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
