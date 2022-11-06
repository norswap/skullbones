// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

contract DeployLocal is Script {
    function run() external {
        vm.startBroadcast();

//        Contract myContract = new Contract();
//        console2.log("Contract address", address(myContract));

        vm.stopBroadcast();
    }
}

contract DeployPublic is Script {
    bytes32 private constant salt = bytes32(uint256(4269));

    function run() external {
        vm.startBroadcast();

        // Using CREATE2 (specifying salt) makes deployment address predictable no matter the chain,
        // if the bytecode does not change. (Note that Foundry omits the matadata hash by default:
        // https://github.com/foundry-rs/foundry/pull/1180)

        // Not used for local deployments because it needs the CREATE2 deployer deployed at
        // 0x4e59b44847b379578588920ca78fbf26c0b4956c and that's not the case on the Anvil chain.

//        Contract myContract = new Contract{salt: salt}();
//        console2.log("Contract address", address(myContract));

        vm.stopBroadcast();
    }
}
