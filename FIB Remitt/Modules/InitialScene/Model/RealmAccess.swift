
import Foundation

struct RealmAccess: Codable {

  var roles : [String]? = []

  enum CodingKeys: String, CodingKey {

    case roles = "roles"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    roles = try values.decodeIfPresent([String].self , forKey: .roles )
 
  }

  init() {

  }

}