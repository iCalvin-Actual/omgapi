//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation


class GETServiceInfoAPIRequest: APIRequest<None, ServiceInfoResponse> {
    init() {
        super.init(path: CommonPath.service)
    }
}
