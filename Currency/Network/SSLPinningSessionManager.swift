//
//  SSLPinningSessionManager.swift
//  Currency
//
//  Created by Ahmed Mahrous on 17/08/2023.
//

//MARK: - You have to make pod install to get Moya, Alamofire and reopen the project
import Moya
import Alamofire


final class SSLPinningSessionManager: Session {
    
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 15
        
        // Load your pinned public key data
        guard let pinnedCertificatePath = Bundle.main.path(forResource: "sni.cloudflaressl.com", ofType: "cer"),
              let pinnedCertificateData = try? Data(contentsOf: URL(fileURLWithPath: pinnedCertificatePath)) else {
            fatalError("Pinned certificate data not found")
        }
        
        let serverTrustManager = ServerTrustManager(evaluators: [
            "api.apilayer.com": PinnedCertificatesTrustEvaluator(certificates: [SecCertificateCreateWithData(nil, pinnedCertificateData as CFData)!])
        ])
        
        let session = Session(configuration: configuration, serverTrustManager: serverTrustManager)
        
        return session
    }()
}
