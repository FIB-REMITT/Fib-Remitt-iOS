
import Foundation

struct JWTTokenModel: Codable {

  var exp               : Int?            = nil
  var iat               : Int?            = nil
  var jti               : String?         = nil
  var iss               : String?         = nil
  var aud               : String?         = nil
  var sub               : String?         = nil
  var typ               : String?         = nil
  var azp               : String?         = nil
  var sessionState      : String?         = nil
  var acr               : String?         = nil
  var realmAccess       : RealmAccess?    = RealmAccess()
  var resourceAccess    : ResourceAccess? = ResourceAccess()
  var scope             : String?         = nil
  var sid               : String?         = nil
  var emailVerified     : Bool?           = nil
  var name              : String?         = nil
  var preferredUsername : String?         = nil
  var givenName         : String?         = nil
  var familyName        : String?         = nil
  var email             : String?         = nil

  enum CodingKeys: String, CodingKey {

    case exp               = "exp"
    case iat               = "iat"
    case jti               = "jti"
    case iss               = "iss"
    case aud               = "aud"
    case sub               = "sub"
    case typ               = "typ"
    case azp               = "azp"
    case sessionState      = "session_state"
    case acr               = "acr"
    case realmAccess       = "realm_access"
    case resourceAccess    = "resource_access"
    case scope             = "scope"
    case sid               = "sid"
    case emailVerified     = "email_verified"
    case name              = "name"
    case preferredUsername = "preferred_username"
    case givenName         = "given_name"
    case familyName        = "family_name"
    case email             = "email"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    exp               = try values.decodeIfPresent(Int.self            , forKey: .exp               )
    iat               = try values.decodeIfPresent(Int.self            , forKey: .iat               )
    jti               = try values.decodeIfPresent(String.self         , forKey: .jti               )
    iss               = try values.decodeIfPresent(String.self         , forKey: .iss               )
    aud               = try values.decodeIfPresent(String.self         , forKey: .aud               )
    sub               = try values.decodeIfPresent(String.self         , forKey: .sub               )
    typ               = try values.decodeIfPresent(String.self         , forKey: .typ               )
    azp               = try values.decodeIfPresent(String.self         , forKey: .azp               )
    sessionState      = try values.decodeIfPresent(String.self         , forKey: .sessionState      )
    acr               = try values.decodeIfPresent(String.self         , forKey: .acr               )
    realmAccess       = try values.decodeIfPresent(RealmAccess.self    , forKey: .realmAccess       )
    resourceAccess    = try values.decodeIfPresent(ResourceAccess.self , forKey: .resourceAccess    )
    scope             = try values.decodeIfPresent(String.self         , forKey: .scope             )
    sid               = try values.decodeIfPresent(String.self         , forKey: .sid               )
    emailVerified     = try values.decodeIfPresent(Bool.self           , forKey: .emailVerified     )
    name              = try values.decodeIfPresent(String.self         , forKey: .name              )
    preferredUsername = try values.decodeIfPresent(String.self         , forKey: .preferredUsername )
    givenName         = try values.decodeIfPresent(String.self         , forKey: .givenName         )
    familyName        = try values.decodeIfPresent(String.self         , forKey: .familyName        )
    email             = try values.decodeIfPresent(String.self         , forKey: .email             )
 
  }

  init() {

  }

}
