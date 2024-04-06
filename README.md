# Foundry Template Contract

This project was tested by using foundry.
foundry is contract tool for deploy, test by solidity.

foundry use git submodule , submodules don't scale.

1. Slow installation times
2. Switching between branches produces git diffs when the submodules are different
3. Need custom helpers like this "reinit"

So this template uses Node.js packages by yarn.

## What's Project Inside

- [Forge](https://github.com/foundry-rs/foundry/blob/master/forge): compile, test, fuzz, format, and deploy smart
  contracts
- [Forge Std](https://github.com/foundry-rs/forge-std): collection of helpful contracts and cheatcodes for testing
- [DSTest](https://github.com/dapphub/ds-test/blob/master/src/test.sol): Forge Std collection of testing assertions and logging utilities
- [PRBTest](https://github.com/PaulRBerg/prb-test): modern collection of testing assertions and logging utilities
- [Solhint](https://github.com/protofire/solhint): linter for Solidity code
- [OpenzeppelinV4.9.5](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/release-v4.9) : Contract code for develop more easier

### Sensible Defaults

This template comes with a set of sensible default configurations for you to use. These defaults can be found in the
following files:

```text
├── .gitignore
├── .solhint.json
├── foundry.toml
└── remappings.txt
```

### VSCode Integration

This template is IDE agnostic, but for the best user experience, you may want to use it in VSCode alongside Nomic
Foundation's [Solidity extension](https://marketplace.visualstudio.com/items?itemName=NomicFoundation.hardhat-solidity).

For guidance on how to integrate a Foundry project in VSCode, please refer to this
[guide](https://book.getfoundry.sh/config/vscode).

## Installing Dependencies

Foundry typically uses git submodules to manage dependencies, but this template uses Node.js packages because

This is how to install dependencies:

1. Install the dependency using your preferred package manager, e.g. `bun install dependency-name`
   - Use this syntax to install from GitHub: `bun install github:username/repo-name`
2. Add a remapping for the dependency in [remappings.txt](./remappings.txt), e.g.
   `dependency-name=node_modules/dependency-name`

Note that OpenZeppelin Contracts is pre-installed, so you can follow that as an example.

## Usage

This is a list of the most frequently needed commands.

### Build

Build the contracts:

```sh
$ forge build
```

### Clean

Delete the build artifacts and cache directories:

```sh
$ forge clean
```

### Compile

Compile the contracts:

```sh
$ forge build
```

### Coverage

Get a test coverage report:

```sh
$ forge coverage
```

### Deploy

Deploy to Anvil:

```sh
$ forge script script/Deploy.s.sol --broadcast --fork-url http://localhost:8545
```

For this script to work, you need to have a `MNEMONIC` environment variable set to a valid
[BIP39 mnemonic](https://iancoleman.io/bip39/).

For instructions on how to deploy to a testnet or mainnet, check out the
[Solidity Scripting](https://book.getfoundry.sh/tutorials/solidity-scripting.html) tutorial.

### Format

Format the contracts:

```sh
$ forge fmt
```

### Gas Usage

Get a gas report:

```sh
$ forge test --gas-report
```

### Lint

Lint the contracts:

```sh
$ bun run lint
```

### Test

Run the tests:

```sh
$ forge test
```

More Detail(console) test:

```sh
forge test -vv
```

More Detail(console and onChain Event):

```sh
forge test -vvv
```

If you want to test contract in env of mainnet:

```sh
$ bun run test:fork:mainnet
```

Generate test coverage and output result to the terminal:

```sh
$ bun run test:coverage
```

Generate test coverage with lcov report (you'll have to open the `./coverage/index.html` file in your browser, to do so
simply copy paste the path):

```sh
$ bun run test:coverage:report
```
