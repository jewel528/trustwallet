// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import BigInt

struct UnconfirmedTransaction {
    let transferType: TransferType
    let value: BigInt
    let address: Address
    let account: Account
    let chainID: Int
    let data: Data?
}
