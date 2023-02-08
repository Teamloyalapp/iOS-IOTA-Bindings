# IOTA Wallet Library - Swift binding

Swift binding to the IOTA wallet library

## Requirements

Ensure you have first installed the latest stable version of Rust and Cargo.

## Installation

```
make_universal_xcframework.sh
```

Copy target/universal/IOTAWalletInternal.xcframework to xcode folder

Open and `build xcode/IotaWallet/IotaWallet.xcodeproj`. The xcode build product is an Objective-C framework that can be used in Swift.

