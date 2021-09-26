//
//  FetchData.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 31.08.2021.
//

import UIKit



protocol DataManagerDelegate {
    func didFinishUpdating()
}


class DataManager {
    
    var delegate : DataManagerDelegate?
    
//MARK: - API call
    
    func getData(with url: String) {
        if let request = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { Data, response, error in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                } else {
                    if let safeData = Data {
                        let decoder = JSONDecoder()
                        do {
                            let apiResult = try decoder.decode([ApiModel].self, from: safeData)
                            for item in apiResult {
                                ListViewArray.append(ListViewModel(name: item.name, image: item.image))
                            }
                            self.delegate?.didFinishUpdating()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}