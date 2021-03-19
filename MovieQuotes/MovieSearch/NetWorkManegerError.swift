//
//  NetWorkManegerError.swift
//  DemoV13
//
//  Created by Yotaro Ito on 2021/03/19.
//

import Foundation
enum NetworkManagerError: Error {
  case badResponse(URLResponse?)
  case badLocalUrl
}
