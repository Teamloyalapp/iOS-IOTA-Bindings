# IOTA Wallet Library - Swift binding

IOS IOTA Swift binding is a wrapper [IOTA Wallet Library](https://github.com/iotaledger/wallet.rs/) and consists of 2 parts. The first part is written in Rust and includes the main methods for interacting with the [IOTA Wallet Library](https://github.com/iotaledger/wallet.rs/) - `iota_initialize`, `iota_destroy`, `iota_send_message`, `iota_listen`, `iota_init_logger`.
The second part of the library is written in Objective-C and Swift. To interact with native part, similar methods are used in the library. Json message and callback are passed as parameters to receive a response from the native part of the library. 
To simplify the usage you can use IOTAWallet utility class, which contains all the necessary methods written in the Swift for simple work with the IOTA wallet.

# Documentation:

## Prerequisites

`Rust` and `Cargo` are required. Install them [here](https://doc.rust-lang.org/cargo/getting-started/installation.html).

We recommend you update Rust to the latest stable version [`rustup update stable`](https://github.com/rust-lang/rustup.rs#keeping-rust-up-to-date). Nightly should be fine but there's a chance some changes are not compatible.

### Dependencies

`cmake`, `clang` and `openssl` are required. In order to run the build process successfully using Cargo you might need install additional build tools on your system.

`cmake` and `openssl` can be installed with `Homebrew`:

```
brew install cmake openssl@1.1
```
IOTA Wallet Library source code for successful build is required. You can put it in a separate folder. Check the latest version from github:
```
git clone https://github.com/iotaledger/wallet.rs.git
```

## Compile native part of the library
Open `Cargo.toml` file in the root of the project and replace iota-wallet path under dependencies section to your own path where [IOTA Wallet Library](https://github.com/iotaledger/wallet.rs/) source code is.

Build project using `make_universal_framework.sh` script.

## Compile swift part of the library
Copy IOTAWalletInternal.xframework from ./target/universal folder to ./xcode/IotaWallet folder
Open Xcode project under Xcode folder and build the project.
Use compiled library in your own project.

# Usage

Add compiled library to the project. 

## Initialisation

Init Stronghold Secret Manager:
```
let manager = StrongholdSecretManager(
	Stronghold: StrongholdSecretOptions(
		password: …,
		timeout: …,
		snapshotPath: …
	)
)
```

Init IOTAWallet object:

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

Otherwise restore wallet from backup:
wallet.restoreBackup(alias: …, onResult: { result in
					// handle result
                })

Get Account Addresses:
```
wallet.getAccountAddress(alias: …, onResult: { result in
                switch result {
                case .success(let data):
                    		// data contain account address
                    } error: { error, message in
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
```

Get Account NFT Ids list:
```
wallet.getAccountListNftsIds(alias: …, onResult: { result in
                switch result {
                case .success(let data):
                    		// data contain NFT ids list
                    } error: { error, message in
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
```

Send NFT given by id to a specific receiver's address:
```
wallet.sendNFT(alias: …, address: …, nftId: …, onResult: { result in
                switch result {
                case .success(let data):
                    		// data contain NFT ids list
                    } error: { error, message in
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
```
