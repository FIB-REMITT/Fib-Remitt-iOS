//
//  Network.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 25/1/24.
//

import UIKit
import Alamofire



struct K {
    private init(){}
    
    static let IS_DEV_BUILD = true
    
    struct NotificationKey {
        private init(){}
    }
    
    enum BaseURL{
        
        case FIB
        case OKX_SOCKET
        case IQDX_ASSET
        
        var Sandbox: String {
            switch self {
            case .FIB:
                return "http://api.fibremit.com/"
            case .OKX_SOCKET:
                return "wss://ws.okx.com:8443/"
            case .IQDX_ASSET:
                return "https://dev-api.iqd-x.com/"
            }
        }
        
        var Production: String {
            switch self {
            case .FIB:
                return "http://api.fibremit.com/"////http://alb-api-1902201270.eu-west-1.elb.amazonaws.com/    // https://dev-api.iqd-x.com/
            case .OKX_SOCKET:
                return "wss://ws.okx.com:8443/"
            case .IQDX_ASSET:
                return "https://dev-api.iqd-x.com/"//http://34.254.254.65:8080/ ////http://alb-api-1902201270.eu-west-1.elb.amazonaws.com/
            }
        }
    }
    
    struct UserDefaultsKey {
        private init(){}
        
        static let APITokenKey = "api_tokn_key"
        static let AccessTokenKey = "x_access_token_key"
        static let UserLoggedIn = "x_is_user_logged_In"
        static let UserFirstTimeInApp = "x_is_user_first_time_inApp"
        static let RefreshTokenKey = "x_refresh_token_key"
        static let UserMobileNo = "x_user_mobile_number_key"
        static let UserPassword = "x_alskdf34343faw124324"
        static let ActiveLanguageIndex = "dk_ActiveLanguageIndexKey_key"
        static let FCMToken = "x_FCMTokenKey"
        static let BiometricAuthTypeId = "biometricAuthTypeKeyId"
        static let RememberUserKey = "x_rememberUserKey"
        static let TokenExpireTime = "x_TokenExpireTime"
        static let RefreshTokenExpireTime = "x_refreshTokenExpireTime"
        static let FavouriteCurrencyData = "x_FavouriteCurrencyData"
        
        static let PerpetualCoin = "perpetualCoin"
        static let AccountTradingLevel = "accountTradingLevel"
        static let FcmToken = "fcm_token"
    }
    
}

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
