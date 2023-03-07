//
//  NetworkBaseClass.swift
//  MovieAppIOS
//
//  Created by hungdt on 23/02/2023.
//

import Foundation

struct NetWorkBase {
    static let accessToken = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNmRiZGYxMmZkNTc1NGM2YjhlMjhhYTJiNzE2NzFjZSIsImp0aSI6IjU2Mjc2NDEiLCJzY29wZXMiOlsiYXBpX3JlYWQiLCJhcGlfd3JpdGUiXSwidmVyc2lvbiI6MSwic3ViIjoiNjNmNDM4YjU0YTRiZmMwMGIyZmFlM2IzIiwibmJmIjoxNjc3MTM3NjEzfQ.n-U1uyFdDPIVnFfAQE2Q8xfpDONOi8ljVJg2jPlQ8dA"
    
    static let accountId = "63f438b54a4bfc00b2fae3b3"
    
    static let baseUrl = "https://api.themoviedb.org"
    
    static let baseImageUrl = "https://image.tmdb.org/t/p/original"
    
}

func getListMovie(completionHandler: @escaping ([MovieEntity]) -> Void){
    //Khởi tạo HTTP Request với URLSession
    let url = URL(string: "\(NetWorkBase.baseUrl)/4/account/\(NetWorkBase.accountId)/movie/recommendations?page=1")!
    var requestHttps =  URLRequest(url: url)
    requestHttps.httpMethod = "GET"
    requestHttps.setValue(NetWorkBase.accessToken, forHTTPHeaderField: "Authorization")
    let session = URLSession.shared
    //Dùng URLSessionDataTask gửi yêu cầu lấy dữ liệu
    let task = session.dataTask(with: requestHttps, completionHandler: { data, response, error in
        if (error != nil) {
            print(error!)
        } else {
            print(response ?? "")
            do {
                let model = try JSONDecoder().decode(ArrayResponeEntity<MovieEntity>.self, from: data!)
                print(model.results?.count ?? 0)
                completionHandler(model.results ?? [])
            } catch {
                print("getListMovie Error")
                completionHandler([])
            }
        }
    })
    task.resume()
}
