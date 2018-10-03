//
//  ApiRequestDelegate.swift
//  OyeMiRadio
//
//  Created by Patel Yogesh on 20/09/18.
//  Copyright © 2018 mycom. All rights reserved.
//

import Foundation

protocol ApiRequestDelegate {
    func didRequestSuccessfullyWith(_ request:ApiRequest);
    func didRequestFailWith(_ request:ApiRequest, error errorMessage:Error);
}
