
import Foundation

struct ResourceAccess: Codable {

  var account : Account? = Account()

  enum CodingKeys: String, CodingKey {

    case account = "account"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    account = try values.decodeIfPresent(Account.self , forKey: .account )
 
  }

  init() {

  }

}