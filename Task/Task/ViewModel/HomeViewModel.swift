//
//  HomeViewModel.swift
//  Task
//
//  Created by apple on 29/06/22.
//

import UIKit

class HomeViewModel: NSObject {
    var dataModel : CanadaDataModel!

    /// Method to get the list of items from service url
    /// - Parameter completion: passing request parameter to common network service calls will recieve success or failure response
    /// - Returns: Passing success or failure response to the HomeViewController
    func getCanadaDetails(completion: @escaping (Result<CanadaDataModel,APIServiceError>) -> ()) {
        
        APIClient().getDataFrom(for: CanadaDataModel.self, url: AppConstants.SERVICE_URL) {[weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.dataModel = data
                    if let data = self?.dataModel {
                        completion(.success(data))
                    }
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
        }
    }
}
