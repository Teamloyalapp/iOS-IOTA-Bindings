# IOTA Wallet Library – Swift binding

IOS IOTA Swift binding is a wrapper of [IOTA Wallet Library](https://github.com/iotaledger/wallet.rs/) that consists of 2 parts. The first part is written in Rust and includes the main methods for interacting with [IOTA Wallet Library](https://github.com/iotaledger/wallet.rs/), namely `iota_initialize`, `iota_destroy`, `iota_send_message`, `iota_listen`, `iota_init_logger`.
The second part of the library is written in Objective-C and Swift. Similar methods are used in the library to interact with native part. Json message and callback are passed as parameters to receive a response from the native part of the library. 
To simplify the usage, you can use IOTA Wallet utility class, which contains all the necessary methods written in Swift. This simplifies the work with the IOTA wallet.

# Documentation

## Prerequisites

`Rust` and `Cargo` are required. Install them [here](https://doc.rust-lang.org/cargo/getting-started/installation.html).

We recommend that you update Rust to the latest stable version [`rustup update stable`](https://github.com/rust-lang/rustup.rs#keeping-rust-up-to-date). Nightly builds should work fine, but there's a risk that some changes might be non-compatible.

### Dependencies

`cmake`, `clang` and `openssl` are required. In order to run the building process successfully using Cargo, you might need to install additional building tools on your system.

`cmake` and `openssl` can be installed with `Homebrew`:

```
brew install cmake openssl@1.1
```
IOTA Wallet Library source code is required for successful building. You can put it in a separate folder. Check its latest version on GitHub:
```
git clone https://github.com/iotaledger/wallet.rs.git
```

## How to compile the native part of the library
Open `Cargo.toml` file in the root of the project and replace iota-wallet path under dependencies section with your own path where [IOTA Wallet Library](https://github.com/iotaledger/wallet.rs/) source code is located.

Build project using `make_universal_framework.sh` script.

## How to compile the swift part of the library
Copy IOTAWalletInternal.xframework from ./target/universal folder to ./xcode/IotaWallet folder
Open Xcode project under Xcode folder and build the project.
Use compiled library in your own project.

# Usage

Add compiled library to the project. 

## Initialization

Stronghold Secret Manager initialization:
```
let manager = StrongholdSecretManager(
	Stronghold: StrongholdSecretOptions(
		password: …,
		timeout: …,
		snapshotPath: …
	)
)
```

IOTA Wallet object initialization:

```
let wallet = IOTAWallet(storagePath: …, backupPath: …, secretManager: manager, coinType: .shimmer, nodeUrl: “https://api.shimmer.network”)
```

Create IOTA Wallet if it doesn’t exist:
```
wallet.createIOTAWallet(alias: …, onResult: { result in
                switch result {
                case .success(_):
                    		// on success
                    } error: { error, message in
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
```

Otherwise, restore the wallet from the backup:
```
wallet.restoreBackup(alias: …, onResult: { result in
	// handle result
})
```

Get the list of account addresses:
```
wallet.getAccountAddress(alias: …, onResult: { result in
                switch result {
                case .success(let data):
                    		// data contains account address
                    } error: { error, message in
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
```

Get the list of account NFT IDs:
```
wallet.getAccountListNftsIds(alias: …, onResult: { result in
                switch result {
                case .success(let data):
                    		// data contains NFT ids list
                    } error: { error, message in
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
```

Send the NFT specified by the ID to a specific receiver's address:
```
wallet.sendNFT(alias: …, address: …, nftId: …, onResult: { result in
                switch result {
                case .success(let data):
                    		// data contains NFT ids list
                    } error: { error, message in
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
```
