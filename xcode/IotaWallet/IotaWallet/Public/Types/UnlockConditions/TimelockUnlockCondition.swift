import Foundation

public struct TimelockUnlockCondition: UnlockCondition {
    public var type: Int = 2
    var unixTime: Int
}
