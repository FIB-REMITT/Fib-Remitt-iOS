//
//  APIManager.swift
//  FIB
//
//  Created by Ainul Kazi on 29/1/23.
//

import Alamofire
import SwiftyJSON
import Combine


@available(iOS 13.0, *)
class APIManager{
    private init() {}
    static let shared:APIManager = APIManager()
    
    private var subscribers = Set<AnyCancellable>()
    
    static let baseUrl: String = K.IS_DEV_BUILD ? K.BaseURL.FIB.Sandbox : K.BaseURL.FIB.Production
    
    @available(iOS 13.0, *)
    func getData<T:Decodable>(apiUrl: String = baseUrl,  endPoint: Endpoint, resultType: T.Type, showLoader:Bool = false) -> Future<T, Error> {
        
        let path = apiUrl + endPoint.path
        
        return Future <T,Error> {[weak self] promise in
            if Connectivity.isConnectedToInternet {
                print("Network Connected")
                if showLoader {LoaderManager.shared.showHud()}

                let headers = self?.getDefaultHeaders(endpoint: endPoint)
                print("Headers ->\n \(headers ?? HTTPHeaders())")
                print("EndPoint:", path)
                print("Parameters: \(endPoint.query ?? ["":""] )")
                print("Method:\(endPoint.method)")
                
                AF.request(path, method: endPoint.method, parameters: endPoint.query, encoder: endPoint.encoder, headers: headers)
                    .validate(statusCode: 200...299)
                    .publishDecodable(type: T.self)
                    .retry(1)
                    .sink(receiveCompletion: { completion in
                        if showLoader {LoaderManager.shared.hideHud()}
                        switch completion {
                        case .finished :
                            print("Successfully Finished")
                        case .failure(let error):
                            promise(.failure(error.localizedDescription))
                            print(error.localizedDescription)
                        }
                    }, receiveValue: { (response) in
                        if showLoader {LoaderManager.shared.hideHud()}
                        switch response.result{
                        case .success(let model):
                            promise(.success(model))
                        case .failure(let error):
                            print(path, response.response?.statusCode ?? "STAtus COde MIssing")
                            
                            if response.response?.statusCode == 200||response.response?.statusCode == 201{
                                promise(.failure(NetworkError.responseIsEmpty))
                            }else if response.response?.statusCode == 401 && endPoint.headerAuth{
                                self?.updateToken()
                            }else if response.response?.statusCode == 406{
                                promise(.failure(self?.getErrorResponse(data: response.data) ?? error.localizedDescription))
                            }else{
                                if let data = response.data {
                                    do {
                                        let errorResponse = try JSONDecoder().decode(RequestFailed.self, from: data)
                                        promise(.failure(errorResponse.msg ?? ""))
                                       // showAlert(title:"Sorry!", message: errorResponse.errors?.joined(separator: " ") ?? "")
                                    } catch {
                                        promise(.failure(error.localizedDescription))
                                       // showAlert(message: "Failed!")
                                    }
                                }
                            }
                        }
                    }).store(in: &self!.subscribers)
                
            }else {
                print(NetworkError.networkConnection.errorDescription ?? "Network error")
                if showLoader {LoaderManager.shared.hideHud() }
                showToast(message: NetworkError.networkConnection.errorDescription ?? "Network error", font: .systemFont(ofSize: 15))
              //  showAlert(message: NetworkError.networkConnection.errorDescription ?? "Network error")
                return promise(.failure(NetworkError.networkConnection))
                
            }
        }
    }
    
    func uploadFormData<T: Decodable>(apiUrl: String = baseUrl, endPoint: Endpoint, resultType: T.Type, showLoader:Bool = false) -> Future<T, Error> {

        let path = apiUrl + endPoint.path
        
        return Future<T, Error> {[weak self] promise in
            if Connectivity.isConnectedToInternet {
                print("Network Connected")
                
                if showLoader {LoaderManager.shared.showHud()}
                let boundary = "Boundary-\(UUID().uuidString)"
                let headers: HTTPHeaders = [
                    HTTPHeaderField.authentication.rawValue: UserSettings.shared.getAccessToken(),
                    HTTPHeaderField.contentType.rawValue: "multipart/form-data; boundary=\(boundary)",
                    HTTPHeaderField.contentType.rawValue: ContentType.urlEncoded.rawValue
                ]

                let multipartData: MultipartFormData = MultipartFormData()
                for (key, value) in endPoint.query! {
                    multipartData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                print("Headers ->\n \(headers)")
                print("EndPoint:", path)
                print("Parameters: \(endPoint.query ?? ["":""] )")
                print("Method:\(endPoint.method)")
            
                AF.upload(multipartFormData: multipartData, to: path, method: endPoint.method, headers: headers)
                .validate(statusCode: 200...299)
                .publishDecodable(type: T.self)
                .sink(receiveCompletion: { completion in
                    if showLoader {LoaderManager.shared.hideHud()}
                    switch completion {
                        case .finished :
                            print(path, "Successfully Uploaded")
                        case .failure(let error):
                            promise(.failure(error.localizedDescription))
                            print(error.localizedDescription)
                    }
                }, receiveValue: { (response) in
                    if showLoader {LoaderManager.shared.hideHud()}
                    switch response.result{
                        case .success(let model):
                            promise(.success(model))
                    case .failure(let error):
                           // print(path, response.response?.statusCode)
                            
                            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                                promise(.failure(NetworkError.responseIsEmpty))
                            }else if response.response?.statusCode == 401 && endPoint.headerAuth{
                                self?.updateToken()
                            }else if response.response?.statusCode == 406{
                                promise(.failure(self?.getErrorResponse(data: response.data) ?? error.localizedDescription))
                            }else{
                                promise(.failure(self?.getErrorResponse(data: response.data) ?? error.localizedDescription))
                            }
                    }
                }).store(in: &self!.subscribers)
                
            }else {
                print(NetworkError.networkConnection.errorDescription ?? "Network error")
                if showLoader {LoaderManager.shared.hideHud()}
                showToast(message: NetworkError.networkConnection.errorDescription ?? "Network error", font: .systemFont(ofSize: 15))
               // showAlert(message: NetworkError.networkConnection.errorDescription ?? "Network error")
                return promise(.failure(NetworkError.networkConnection))
            }
        }
    }
    
    func makeAPICallReceivedInBank(isBankbeneficiary:Bool,beneficiaryId:String,fromCurrency:String,amountToTransfer:String,toCurrency:String,paymentMethod:String,collectionPoint:String,purposeId:String, invoice:Data?) -> Future<BankCollectionResponse, Error> {
        let headers: HTTPHeaders = [
            "Authorization": UserSettings.shared.getAccessToken(),
            "Content-Type": "multipart/form-data"
        ]
        let path = isBankbeneficiary ? "api/v1/private/transfer/personal/receive-in-bank" : "api/v1/private/transfer/personal/receive-in-cash"
      
        
        let url = "\(K.IS_DEV_BUILD ? K.BaseURL.FIB.Sandbox : K.BaseURL.FIB.Production)\(path)"
        
        
        var parameters : Parameters = [String: Any]()
      
         parameters = [
            "fromCurrency": fromCurrency,"amountToTransfer": amountToTransfer, "toCurrency" : toCurrency, "paymentMethod": paymentMethod, "collectionPoint": collectionPoint,"purposeId": purposeId
        ]
        if isBankbeneficiary == true{
            parameters["bankBeneficiaryId"] = beneficiaryId
        }else{
            parameters["cashPickupBeneficiaryId"] = beneficiaryId
        }
        
        return Future<BankCollectionResponse, Error> { promise in
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
               
                if let invoiceData = invoice {
                    multipartFormData.append(invoiceData, withName: "invoice", fileName: "invoice.pdf", mimeType: "application/pdf")
                }
            }, to: url, method: .post, headers: headers)
            .validate(statusCode: 200...299)
            .publishDecodable(type: BankCollectionResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    promise(.failure(error))
                }
            }, receiveValue: { response in
                switch response.result{
                case .success(let model):
                    promise(.success(model))
                case .failure(_):
                    if response.response?.statusCode == 200{
                        promise(.failure(NetworkError.responseIsEmpty))
                    }else if response.response?.statusCode == 401{
                        self.updateToken()
                    }else{
                        if let data = response.data {
                            do {
                                let errorResponse = try JSONDecoder().decode(RequestFailed.self, from: data)
                                promise(.failure(errorResponse.errors?.joined(separator: " ") ?? ""))
                                showToast(message: errorResponse.errors?.joined(separator: " ") ?? "")
                            } catch {
                                promise(.failure(error.localizedDescription))
                                showAlert(message: "Failed!")
                            }
                        }
                    }
                }
            }).store(in: &self.subscribers)
        }
    }
    
    func uploadBeneficiaryDocs(fullName:String,nationalityId:String,phoneNumber:String, address:String, invoice:Data?) -> Future<EmptyResponse, Error> {
        let headers: HTTPHeaders = [
            "Authorization": UserSettings.shared.getAccessToken(),
            "Content-Type": "multipart/form-data"
        ]
        let path = "api/v1/private/beneficiary/\("853692f2-3a30-47e5-a9df-cf6b7c9ffed3")/cashpickup"
      
        
        let url = "\(K.IS_DEV_BUILD ? K.BaseURL.FIB.Sandbox : K.BaseURL.FIB.Production)\(path)"
        
        
        var parameters : Parameters = [String: Any]()
      
         parameters = [
            "fullName": fullName,"nationalityId": nationalityId, "phoneNumber" : phoneNumber, "address": address, "typeOfBeneficiary":"Business"
        ]
        
        return Future<EmptyResponse, Error> { promise in
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
               
                if let invoiceData = invoice {
                    multipartFormData.append(invoiceData, withName: "contract", fileName: "invoice.pdf", mimeType: "application/pdf")
                }
            }, to: url, method: .post, headers: headers)
            .validate(statusCode: 200...299)
            .publishDecodable(type: EmptyResponse.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    promise(.failure(error))
                }
            }, receiveValue: { response in
                switch response.result{
                case .success(let model):
                    promise(.success(model))
                case .failure(_):
                    if response.response?.statusCode == 201{
                        promise(.failure(NetworkError.responseIsEmpty))
                    }else if response.response?.statusCode == 401{
                        self.updateToken()
                    }else{
                        if let data = response.data {
                            do {
                                let errorResponse = try JSONDecoder().decode(RequestFailed.self, from: data)
                                promise(.failure(errorResponse.errors?.joined(separator: " ") ?? ""))
                                showToast(message: errorResponse.errors?.joined(separator: " ") ?? "")
                            } catch {
                                promise(.failure(error.localizedDescription))
                                showAlert(message: "Failed!")
                            }
                        }
                    }
                }
            }).store(in: &self.subscribers)
        }
    }
    
    func updateToken() {
        if UserSettings.shared.shouldRefreshTokenCall(){
            LoaderManager.shared.hideHud()
            self.getData(endPoint: AuthEndPoint.refreshToken(refreshToken: UserSettings.shared.refreshToken ?? ""), resultType: SignInResponse.self)
                .sink { completion in
                    switch completion{
                    case .finished:
                        print("Token Update API called")
                    case .failure(let error):
                        if error.localizedDescription == "Error: {\"error\":\"invalid_grant\",\"error_description\":\"Token is not active\"}"{
                            UserSettings.shared.logout()
                        }
                        print(error.localizedDescription)
                    }
                } receiveValue: { result in
                    if let data = result.data{
                        UserSettings.shared.setLoginInfo(loginInfo: data)
                    }
                }.store(in: &subscribers)
        }else{
            UserSettings.shared.logout()
        }
    }
    
    private func getErrorResponse(data : Data?) -> String? {
        if let response = data {
            do {
                let errorRes = try JSONDecoder().decode(RequestFailed.self, from: response)
                return errorRes.msg
            } catch let error{
                return error.localizedDescription
            }
        }
        
        return nil
    }
    
    // Default Headers
    func getDefaultHeaders(endpoint:Endpoint) -> HTTPHeaders{
        var headers: HTTPHeaders?
        
        headers = [
            HTTPHeaderField.authentication.rawValue: endpoint.headerAuth ? UserSettings.shared.getAccessToken() : "",
            HTTPHeaderField.contentType.rawValue: endpoint.contentType,
        ]
        
        return headers!
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case requestId = "App-request-id"
}

enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
    case urlEncoded = "application/x-www-form-urlencoded"
    case formUrlEncoded = "application/x-www-form-urlencoded charset=utf-8"
}

enum NetworkError: Error {
    case networkConnection
    case invalidURL
    case responseError
    case responseIsEmpty
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .networkConnection:
            return NSLocalizedString("Network isn't Connected", comment: "Network isn't Connected")
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .responseIsEmpty:
            return NSLocalizedString("Response is Empty but action succesfully completed", comment: "response is Empty but expected work done!")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}

// MARK: - Error Handling
extension String: Error {}
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

//MARK: - Mapping Error
struct RequestFailed: Codable, CustomStringConvertible,Error {
    var description: String{
        return ""
    }
    
    var code:String?
    var msg:String?
    var errors: [String]?
    
    enum CodingKeys: String, CodingKey {
        case code
        case msg
        case errors
    }
}

