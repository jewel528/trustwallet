// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import BigInt
import JSONRPCKit
import APIKit
import Result
import TrustCore

class TokensBalanceService {

    private let web3: Web3Swift

    init(
        web3: Web3Swift
    ) {
        self.web3 = web3
    }

    func getBalance(
        for address: Address,
        contract: Address,
        completion: @escaping (Result<BigInt, AnyError>) -> Void
    ) {
        let encoded = ERC20Encoder.encodeBalanceOf(address: address)
        let request2 = EtherServiceRequest(
            batch: BatchFactory().create(CallRequest(to: contract.description, data: encoded.hexString))
        )
        Session.send(request2) { result2 in
            switch result2 {
            case .success(let balance):
                let biguint = BigUInt(Data(hex: balance))
                completion(.success(BigInt(sign: .plus, magnitude: biguint)))
            case .failure(let error):
                NSLog("getPrice2 error \(error)")
                completion(.failure(AnyError(error)))
            }
        }
    }

    func getEthBalance(
        for address: Address,
        completion: @escaping (Result<Balance, AnyError>) -> Void
    ) {
        let request = EtherServiceRequest(batch: BatchFactory().create(BalanceRequest(address: address.description)))
        Session.send(request) { result in
            switch result {
            case .success(let balance):
                completion(.success(balance))
            case .failure(let error):
                completion(.failure(AnyError(error)))
            }
        }
    }
}
