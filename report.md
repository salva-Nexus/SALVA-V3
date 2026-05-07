'forge clean' running (wd: /home/cboi/Blockchain-Projects/SALVA-V3)
'forge config --json' running
'forge build --build-info --skip ./test/** ./script/** --force' running (wd: /home/cboi/Blockchain-Projects/SALVA-V3)
INFO:Detectors:
Detector: unused-return
ERC1967Utils.upgradeToAndCall(address,bytes) (lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#67-76) ignores return value by Address.functionDelegateCall(newImplementation,data) (lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#72)
ERC1967Utils.upgradeBeaconToAndCall(address,bytes) (lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#157-166) ignores return value by Address.functionDelegateCall(IBeacon(newBeacon).implementation(),data) (lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#162)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-return
INFO:Detectors:
Detector: missing-zero-check
PoolFactory.updateImplementation(address).newImpl (src/Core/Factory/PoolFactory.sol#98) lacks a zero-check on :
		- _implementation = newImpl (src/Core/Factory/PoolFactory.sol#100)
SalvaPool.initialize(address).deployer (src/Core/SalvaPool.sol#11) lacks a zero-check on :
		- DEPLOYER = deployer (src/Core/SalvaPool.sol#12)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation
INFO:Detectors:
Detector: reentrancy-events
Reentrancy in PoolFactory.deployPool() (src/Core/Factory/PoolFactory.sol#84-88):
	External calls:
	- ISalvaPool(pool).initialize(_msgSender()) (src/Core/Factory/PoolFactory.sol#86)
	Event emitted after the call(s):
	- PoolDeployed(_msgSender(),pool) (src/Core/Factory/PoolFactory.sol#87)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-4
INFO:Detectors:
Detector: assembly
Clones.clone(address,uint256) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#47-62) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#51-58)
Clones.cloneDeterministic(address,bytes32,uint256) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#90-109) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#98-105)
Clones.predictDeterministicAddress(address,bytes32,address) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#114-129) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#119-128)
Clones.cloneWithImmutableArgs(address,bytes,uint256) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#167-182) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#176-178)
Clones.fetchCloneArgs(address) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#261-267) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#263-265)
Initializable._getInitializableStorage() (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#232-237) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#234-236)
SafeERC20._safeTransfer(IERC20,address,uint256,bool) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#176-200) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#179-199)
SafeERC20._safeTransferFrom(IERC20,address,address,uint256,bool) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#212-244) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#221-243)
SafeERC20._safeApprove(IERC20,address,uint256,bool) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#255-279) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#258-278)
Create2.deploy(uint256,bytes32,bytes) (lib/openzeppelin-contracts/contracts/utils/Create2.sol#38-55) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Create2.sol#45-47)
Create2.computeAddress(bytes32,bytes32,address) (lib/openzeppelin-contracts/contracts/utils/Create2.sol#69-90) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Create2.sol#70-89)
LowLevelCall.callNoReturn(address,uint256,bytes) (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#19-23) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#20-22)
LowLevelCall.callReturn64Bytes(address,uint256,bytes) (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#38-48) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#43-47)
LowLevelCall.staticcallNoReturn(address,bytes) (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#51-55) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#52-54)
LowLevelCall.staticcallReturn64Bytes(address,bytes) (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#62-71) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#66-70)
LowLevelCall.delegatecallNoReturn(address,bytes) (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#74-78) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#75-77)
LowLevelCall.delegatecallReturn64Bytes(address,bytes) (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#85-94) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#89-93)
LowLevelCall.returnDataSize() (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#97-101) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#98-100)
LowLevelCall.returnData() (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#104-111) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#105-110)
LowLevelCall.bubbleRevert() (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#114-120) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#115-119)
LowLevelCall.bubbleRevert(bytes) (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#122-126) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#123-125)
StorageSlot.getAddressSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#66-70) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#67-69)
StorageSlot.getBooleanSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#75-79) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#76-78)
StorageSlot.getBytes32Slot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#84-88) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#85-87)
StorageSlot.getUint256Slot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#93-97) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#94-96)
StorageSlot.getInt256Slot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#102-106) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#103-105)
StorageSlot.getStringSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#111-115) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#112-114)
StorageSlot.getStringSlot(string) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#120-124) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#121-123)
StorageSlot.getBytesSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#129-133) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#130-132)
StorageSlot.getBytesSlot(bytes) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#138-142) uses assembly
	- INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#139-141)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
Detector: pragma
7 different versions of Solidity are used:
	- Version constraint >=0.6.2 is used by:
		->=0.6.2 (lib/openzeppelin-contracts/contracts/interfaces/IERC1363.sol#4)
		->=0.6.2 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
	- Version constraint >=0.4.16 is used by:
		->=0.4.16 (lib/openzeppelin-contracts/contracts/interfaces/IERC165.sol#4)
		->=0.4.16 (lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol#4)
		->=0.4.16 (lib/openzeppelin-contracts/contracts/interfaces/draft-IERC1822.sol#4)
		->=0.4.16 (lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#4)
		->=0.4.16 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
		->=0.4.16 (lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4)
	- Version constraint >=0.4.11 is used by:
		->=0.4.11 (lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#4)
	- Version constraint ^0.8.20 is used by:
		-^0.8.20 (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#4)
		-^0.8.20 (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#4)
		-^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4)
		-^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4)
		-^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Create2.sol#4)
		-^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Errors.sol#4)
		-^0.8.20 (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#4)
		-^0.8.20 (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#5)
	- Version constraint ^0.8.21 is used by:
		-^0.8.21 (lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#4)
	- Version constraint ^0.8.22 is used by:
		-^0.8.22 (lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#4)
	- Version constraint ^0.8.30 is used by:
		-^0.8.30 (src/Core/Factory/PoolFactory.sol#2)
		-^0.8.30 (src/Core/PoolStorage.sol#2)
		-^0.8.30 (src/Core/SalvaOracle.sol#2)
		-^0.8.30 (src/Core/SalvaPool.sol#2)
		-^0.8.30 (src/Core/SwapEngine.sol#2)
		-^0.8.30 (src/Interfaces/ISalvaPool.sol#2)
		-^0.8.30 (src/Library/Context.sol#2)
		-^0.8.30 (src/Library/Errors.sol#2)
		-^0.8.30 (src/Library/Modifier.sol#2)
		-^0.8.30 (src/Library/PoolHelper.sol#2)
		-^0.8.30 (src/Library/SalvaMath.sol#2)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Detector: solc-version
Version constraint >=0.6.2 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- NestedCalldataArrayAbiReencodingSizeValidation
	- ABIDecodeTwoDimensionalArrayMemory
	- KeccakCaching
	- EmptyByteArrayCopy
	- DynamicArrayCleanup
	- MissingEscapingInFormatting
	- ArraySliceDynamicallyEncodedBaseType
	- ImplicitConstructorCallvalueCheck
	- TupleAssignmentMultiStackSlotComponents
	- MemoryArrayCreationOverflow.
It is used by:
	- >=0.6.2 (lib/openzeppelin-contracts/contracts/interfaces/IERC1363.sol#4)
	- >=0.6.2 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
Version constraint >=0.4.16 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- DirtyBytesArrayToStorage
	- ABIDecodeTwoDimensionalArrayMemory
	- KeccakCaching
	- EmptyByteArrayCopy
	- DynamicArrayCleanup
	- ImplicitConstructorCallvalueCheck
	- TupleAssignmentMultiStackSlotComponents
	- MemoryArrayCreationOverflow
	- privateCanBeOverridden
	- SignedArrayStorageCopy
	- ABIEncoderV2StorageArrayWithMultiSlotElement
	- DynamicConstructorArgumentsClippedABIV2
	- UninitializedFunctionPointerInConstructor_0.4.x
	- IncorrectEventSignatureInLibraries_0.4.x
	- ExpExponentCleanup
	- NestedArrayFunctionCallDecoder
	- ZeroFunctionSelector.
It is used by:
	- >=0.4.16 (lib/openzeppelin-contracts/contracts/interfaces/IERC165.sol#4)
	- >=0.4.16 (lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol#4)
	- >=0.4.16 (lib/openzeppelin-contracts/contracts/interfaces/draft-IERC1822.sol#4)
	- >=0.4.16 (lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#4)
	- >=0.4.16 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
	- >=0.4.16 (lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#4)
Version constraint >=0.4.11 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- DirtyBytesArrayToStorage
	- KeccakCaching
	- EmptyByteArrayCopy
	- DynamicArrayCleanup
	- ImplicitConstructorCallvalueCheck
	- TupleAssignmentMultiStackSlotComponents
	- MemoryArrayCreationOverflow
	- privateCanBeOverridden
	- SignedArrayStorageCopy
	- UninitializedFunctionPointerInConstructor_0.4.x
	- IncorrectEventSignatureInLibraries_0.4.x
	- ExpExponentCleanup
	- NestedArrayFunctionCallDecoder
	- ZeroFunctionSelector
	- DelegateCallReturnValue
	- ECRecoverMalformedInput
	- SkipEmptyStringLiteral.
It is used by:
	- >=0.4.11 (lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#4)
Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
It is used by:
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#4)
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#4)
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4)
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4)
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Create2.sol#4)
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Errors.sol#4)
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#4)
	- ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#5)
Version constraint ^0.8.21 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication.
It is used by:
	- ^0.8.21 (lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#4)
Version constraint ^0.8.22 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication.
It is used by:
	- ^0.8.22 (lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#4)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Detector: naming-convention
Variable UUPSUpgradeable.__self (lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#23) is not in mixedCase
Variable PoolFactory.__gap (src/Core/Factory/PoolFactory.sol#47) is not in mixedCase
Variable PoolStorage.MULTISIG (src/Core/PoolStorage.sol#7) is not in mixedCase
Variable PoolStorage.DEPLOYER (src/Core/PoolStorage.sol#8) is not in mixedCase
Variable PoolStorage.PAUSED (src/Core/PoolStorage.sol#9) is not in mixedCase
Parameter SalvaOracle.updateBuyRate(uint256)._exRate (src/Core/SalvaOracle.sol#8) is not in mixedCase
Parameter SalvaOracle.updateSellRate(uint256)._exRate (src/Core/SalvaOracle.sol#16) is not in mixedCase
Function SalvaOracle._getBuyRate() (src/Core/SalvaOracle.sol#24-26) is not in mixedCase
Function SalvaOracle._getSellRate() (src/Core/SalvaOracle.sol#28-30) is not in mixedCase
Parameter SwapEngine.swapExactAmountToToken(address,address,address,uint256)._receiver (src/Core/SwapEngine.sol#30) is not in mixedCase
Parameter SwapEngine.swapExactAmountToToken(address,address,address,uint256)._swapTokenOut (src/Core/SwapEngine.sol#31) is not in mixedCase
Parameter SwapEngine.swapExactAmountToToken(address,address,address,uint256)._ngnsToken (src/Core/SwapEngine.sol#32) is not in mixedCase
Parameter SwapEngine.swapExactAmountToToken(address,address,address,uint256)._ngnsAmountIn (src/Core/SwapEngine.sol#33) is not in mixedCase
Parameter SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._receiver (src/Core/SwapEngine.sol#46) is not in mixedCase
Parameter SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._swapTokenIn (src/Core/SwapEngine.sol#47) is not in mixedCase
Parameter SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._ngnsTokenOut (src/Core/SwapEngine.sol#48) is not in mixedCase
Parameter SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._tokenAmountIn (src/Core/SwapEngine.sol#49) is not in mixedCase
Parameter SalvaMath.calculateTokenAmountOut(uint256,uint256,uint256)._amountIn (src/Library/SalvaMath.sol#5) is not in mixedCase
Parameter SalvaMath.calculateTokenAmountOut(uint256,uint256,uint256)._exRate (src/Library/SalvaMath.sol#5) is not in mixedCase
Parameter SalvaMath.calculateTokenAmountOut(uint256,uint256,uint256)._factor (src/Library/SalvaMath.sol#5) is not in mixedCase
Parameter SalvaMath.calculateNGNsAmountOut(uint256,uint256,uint256)._amountIn (src/Library/SalvaMath.sol#13) is not in mixedCase
Parameter SalvaMath.calculateNGNsAmountOut(uint256,uint256,uint256)._exRate (src/Library/SalvaMath.sol#13) is not in mixedCase
Parameter SalvaMath.calculateNGNsAmountOut(uint256,uint256,uint256)._factor (src/Library/SalvaMath.sol#13) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
Detector: too-many-digits
Clones.clone(address,uint256) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#47-62) uses literals with too many digits:
	- mstore(uint256,uint256)(0x00,implementation << 96 >> 232 | 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#54)
Clones.cloneDeterministic(address,bytes32,uint256) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#90-109) uses literals with too many digits:
	- mstore(uint256,uint256)(0x00,implementation << 96 >> 232 | 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000) (lib/openzeppelin-contracts/contracts/proxy/Clones.sol#101)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#too-many-digits
INFO:Detectors:
Detector: unindexed-event-address
Event IERC1967.AdminChanged(address,address) (lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#18) has address parameters but no indexed parameters
Event PoolFactory.ImplementationUpdated(address,address) (src/Core/Factory/PoolFactory.sol#34) has address parameters but no indexed parameters
Event PoolFactory.MultiSigUpdated(address,address) (src/Core/Factory/PoolFactory.sol#35) has address parameters but no indexed parameters
Event ISalvaPool.Paused(address) (src/Interfaces/ISalvaPool.sol#24) has address parameters but no indexed parameters
Event ISalvaPool.Unpaused(address) (src/Interfaces/ISalvaPool.sol#25) has address parameters but no indexed parameters
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unindexed-event-address-parameters
INFO:Detectors:
Detector: unused-state
PoolFactory.__gap (src/Core/Factory/PoolFactory.sol#47) is never used in PoolFactory (src/Core/Factory/PoolFactory.sol#19-142)
PoolStorage.MULTISIG (src/Core/PoolStorage.sol#7) is never used in SalvaPool (src/Core/SalvaPool.sol#8-44)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-state-variable
INFO:Detectors:
Detector: constable-states
PoolStorage.MULTISIG (src/Core/PoolStorage.sol#7) should be constant 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-constant
**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [unused-return](#unused-return) (2 results) (Medium)
 - [missing-zero-check](#missing-zero-check) (2 results) (Low)
 - [reentrancy-events](#reentrancy-events) (1 results) (Low)
 - [assembly](#assembly) (30 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [solc-version](#solc-version) (6 results) (Informational)
 - [naming-convention](#naming-convention) (23 results) (Informational)
 - [too-many-digits](#too-many-digits) (2 results) (Informational)
 - [unindexed-event-address](#unindexed-event-address) (5 results) (Informational)
 - [unused-state](#unused-state) (2 results) (Informational)
 - [constable-states](#constable-states) (1 results) (Optimization)
## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-0
[ERC1967Utils.upgradeBeaconToAndCall(address,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L157-L166) ignores return value by [Address.functionDelegateCall(IBeacon(newBeacon).implementation(),data)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L162)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L157-L166


 - [ ] ID-1
[ERC1967Utils.upgradeToAndCall(address,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L67-L76) ignores return value by [Address.functionDelegateCall(newImplementation,data)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L72)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L67-L76


## missing-zero-check
Impact: Low
Confidence: Medium
 - [ ] ID-2
[PoolFactory.updateImplementation(address).newImpl](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L98) lacks a zero-check on :
		- [_implementation = newImpl](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L100)

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L98


 - [ ] ID-3
[SalvaPool.initialize(address).deployer](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaPool.sol#L11) lacks a zero-check on :
		- [DEPLOYER = deployer](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaPool.sol#L12)

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaPool.sol#L11


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-4
Reentrancy in [PoolFactory.deployPool()](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L84-L88):
	External calls:
	- [ISalvaPool(pool).initialize(_msgSender())](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L86)
	Event emitted after the call(s):
	- [PoolDeployed(_msgSender(),pool)](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L87)

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L84-L88


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-5
[Create2.deploy(uint256,bytes32,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L38-L55) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L45-L47)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L38-L55


 - [ ] ID-6
[LowLevelCall.callReturn64Bytes(address,uint256,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L38-L48) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L43-L47)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L38-L48


 - [ ] ID-7
[StorageSlot.getAddressSlot(bytes32)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L66-L70) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L67-L69)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L66-L70


 - [ ] ID-8
[LowLevelCall.callNoReturn(address,uint256,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L19-L23) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L20-L22)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L19-L23


 - [ ] ID-9
[LowLevelCall.bubbleRevert()](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L114-L120) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L115-L119)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L114-L120


 - [ ] ID-10
[StorageSlot.getInt256Slot(bytes32)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L102-L106) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L103-L105)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L102-L106


 - [ ] ID-11
[LowLevelCall.returnData()](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L104-L111) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L105-L110)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L104-L111


 - [ ] ID-12
[SafeERC20._safeTransfer(IERC20,address,uint256,bool)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L176-L200) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L179-L199)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L176-L200


 - [ ] ID-13
[StorageSlot.getBytesSlot(bytes32)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L129-L133) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L130-L132)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L129-L133


 - [ ] ID-14
[LowLevelCall.delegatecallReturn64Bytes(address,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L85-L94) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L89-L93)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L85-L94


 - [ ] ID-15
[LowLevelCall.staticcallReturn64Bytes(address,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L62-L71) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L66-L70)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L62-L71


 - [ ] ID-16
[StorageSlot.getStringSlot(string)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L120-L124) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L121-L123)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L120-L124


 - [ ] ID-17
[StorageSlot.getBytes32Slot(bytes32)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L84-L88) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L85-L87)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L84-L88


 - [ ] ID-18
[StorageSlot.getBytesSlot(bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L138-L142) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L139-L141)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L138-L142


 - [ ] ID-19
[Clones.clone(address,uint256)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L47-L62) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L51-L58)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L47-L62


 - [ ] ID-20
[Clones.cloneWithImmutableArgs(address,bytes,uint256)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L167-L182) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L176-L178)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L167-L182


 - [ ] ID-21
[Clones.predictDeterministicAddress(address,bytes32,address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L114-L129) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L119-L128)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L114-L129


 - [ ] ID-22
[Create2.computeAddress(bytes32,bytes32,address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L69-L90) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L70-L89)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L69-L90


 - [ ] ID-23
[LowLevelCall.staticcallNoReturn(address,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L51-L55) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L52-L54)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L51-L55


 - [ ] ID-24
[LowLevelCall.delegatecallNoReturn(address,bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L74-L78) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L75-L77)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L74-L78


 - [ ] ID-25
[StorageSlot.getBooleanSlot(bytes32)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L75-L79) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L76-L78)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L75-L79


 - [ ] ID-26
[SafeERC20._safeApprove(IERC20,address,uint256,bool)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L255-L279) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L258-L278)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L255-L279


 - [ ] ID-27
[StorageSlot.getStringSlot(bytes32)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L111-L115) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L112-L114)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L111-L115


 - [ ] ID-28
[LowLevelCall.bubbleRevert(bytes)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L122-L126) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L123-L125)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L122-L126


 - [ ] ID-29
[Initializable._getInitializableStorage()](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#L232-L237) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#L234-L236)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#L232-L237


 - [ ] ID-30
[SafeERC20._safeTransferFrom(IERC20,address,address,uint256,bool)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L212-L244) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L221-L243)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L212-L244


 - [ ] ID-31
[LowLevelCall.returnDataSize()](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L97-L101) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L98-L100)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L97-L101


 - [ ] ID-32
[StorageSlot.getUint256Slot(bytes32)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L93-L97) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L94-L96)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L93-L97


 - [ ] ID-33
[Clones.cloneDeterministic(address,bytes32,uint256)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L90-L109) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L98-L105)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L90-L109


 - [ ] ID-34
[Clones.fetchCloneArgs(address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L261-L267) uses assembly
	- [INLINE ASM](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L263-L265)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L261-L267


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-35
7 different versions of Solidity are used:
	- Version constraint >=0.6.2 is used by:
		-[>=0.6.2](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1363.sol#L4)
		-[>=0.6.2](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4)
	- Version constraint >=0.4.16 is used by:
		-[>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC165.sol#L4)
		-[>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol#L4)
		-[>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/draft-IERC1822.sol#L4)
		-[>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#L4)
		-[>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#L4)
		-[>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#L4)
	- Version constraint >=0.4.11 is used by:
		-[>=0.4.11](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L4)
	- Version constraint ^0.8.20 is used by:
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L4)
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#L4)
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L4)
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Address.sol#L4)
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L4)
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Errors.sol#L4)
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L4)
		-[^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L5)
	- Version constraint ^0.8.21 is used by:
		-[^0.8.21](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L4)
	- Version constraint ^0.8.22 is used by:
		-[^0.8.22](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L4)
	- Version constraint ^0.8.30 is used by:
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaPool.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Interfaces/ISalvaPool.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/Context.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/Errors.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/Modifier.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/PoolHelper.sol#L2)
		-[^0.8.30](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L2)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1363.sol#L4


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-36
Version constraint >=0.4.11 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- DirtyBytesArrayToStorage
	- KeccakCaching
	- EmptyByteArrayCopy
	- DynamicArrayCleanup
	- ImplicitConstructorCallvalueCheck
	- TupleAssignmentMultiStackSlotComponents
	- MemoryArrayCreationOverflow
	- privateCanBeOverridden
	- SignedArrayStorageCopy
	- UninitializedFunctionPointerInConstructor_0.4.x
	- IncorrectEventSignatureInLibraries_0.4.x
	- ExpExponentCleanup
	- NestedArrayFunctionCallDecoder
	- ZeroFunctionSelector
	- DelegateCallReturnValue
	- ECRecoverMalformedInput
	- SkipEmptyStringLiteral.
It is used by:
	- [>=0.4.11](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L4)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L4


 - [ ] ID-37
Version constraint >=0.4.16 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- DirtyBytesArrayToStorage
	- ABIDecodeTwoDimensionalArrayMemory
	- KeccakCaching
	- EmptyByteArrayCopy
	- DynamicArrayCleanup
	- ImplicitConstructorCallvalueCheck
	- TupleAssignmentMultiStackSlotComponents
	- MemoryArrayCreationOverflow
	- privateCanBeOverridden
	- SignedArrayStorageCopy
	- ABIEncoderV2StorageArrayWithMultiSlotElement
	- DynamicConstructorArgumentsClippedABIV2
	- UninitializedFunctionPointerInConstructor_0.4.x
	- IncorrectEventSignatureInLibraries_0.4.x
	- ExpExponentCleanup
	- NestedArrayFunctionCallDecoder
	- ZeroFunctionSelector.
It is used by:
	- [>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC165.sol#L4)
	- [>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC20.sol#L4)
	- [>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/draft-IERC1822.sol#L4)
	- [>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol#L4)
	- [>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#L4)
	- [>=0.4.16](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#L4)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC165.sol#L4


 - [ ] ID-38
Version constraint >=0.6.2 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- MissingSideEffectsOnSelectorAccess
	- AbiReencodingHeadOverflowWithStaticArrayCleanup
	- DirtyBytesArrayToStorage
	- NestedCalldataArrayAbiReencodingSizeValidation
	- ABIDecodeTwoDimensionalArrayMemory
	- KeccakCaching
	- EmptyByteArrayCopy
	- DynamicArrayCleanup
	- MissingEscapingInFormatting
	- ArraySliceDynamicallyEncodedBaseType
	- ImplicitConstructorCallvalueCheck
	- TupleAssignmentMultiStackSlotComponents
	- MemoryArrayCreationOverflow.
It is used by:
	- [>=0.6.2](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1363.sol#L4)
	- [>=0.6.2](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#L4)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1363.sol#L4


 - [ ] ID-39
Version constraint ^0.8.21 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication.
It is used by:
	- [^0.8.21](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L4)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Utils.sol#L4


 - [ ] ID-40
Version constraint ^0.8.22 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication.
It is used by:
	- [^0.8.22](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L4)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L4


 - [ ] ID-41
Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
	- VerbatimInvalidDeduplication
	- FullInlinerNonExpressionSplitArgumentEvaluationOrder
	- MissingSideEffectsOnSelectorAccess.
It is used by:
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L4)
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol#L4)
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#L4)
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Address.sol#L4)
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Create2.sol#L4)
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/Errors.sol#L4)
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/LowLevelCall.sol#L4)
	- [^0.8.20](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#L5)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L4


## naming-convention
Impact: Informational
Confidence: High
 - [ ] ID-42
Parameter [SwapEngine.swapExactAmountToToken(address,address,address,uint256)._ngnsAmountIn](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L33) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L33


 - [ ] ID-43
Variable [PoolStorage.PAUSED](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L9) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L9


 - [ ] ID-44
Parameter [SwapEngine.swapExactAmountToToken(address,address,address,uint256)._receiver](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L30) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L30


 - [ ] ID-45
Parameter [SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._tokenAmountIn](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L49) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L49


 - [ ] ID-46
Parameter [SalvaOracle.updateSellRate(uint256)._exRate](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L16) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L16


 - [ ] ID-47
Parameter [SalvaMath.calculateTokenAmountOut(uint256,uint256,uint256)._amountIn](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L5) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L5


 - [ ] ID-48
Parameter [SalvaMath.calculateTokenAmountOut(uint256,uint256,uint256)._exRate](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L5) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L5


 - [ ] ID-49
Variable [PoolStorage.MULTISIG](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L7) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L7


 - [ ] ID-50
Parameter [SwapEngine.swapExactAmountToToken(address,address,address,uint256)._ngnsToken](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L32) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L32


 - [ ] ID-51
Parameter [SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._receiver](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L46) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L46


 - [ ] ID-52
Parameter [SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._ngnsTokenOut](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L48) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L48


 - [ ] ID-53
Parameter [SalvaMath.calculateNGNsAmountOut(uint256,uint256,uint256)._factor](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L13) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L13


 - [ ] ID-54
Parameter [SalvaMath.calculateNGNsAmountOut(uint256,uint256,uint256)._exRate](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L13) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L13


 - [ ] ID-55
Variable [PoolStorage.DEPLOYER](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L8) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L8


 - [ ] ID-56
Parameter [SwapEngine.swapExactAmountToToken(address,address,address,uint256)._swapTokenOut](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L31) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L31


 - [ ] ID-57
Variable [PoolFactory.__gap](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L47) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L47


 - [ ] ID-58
Parameter [SalvaOracle.updateBuyRate(uint256)._exRate](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L8) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L8


 - [ ] ID-59
Function [SalvaOracle._getBuyRate()](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L24-L26) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L24-L26


 - [ ] ID-60
Variable [UUPSUpgradeable.__self](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L23) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol#L23


 - [ ] ID-61
Function [SalvaOracle._getSellRate()](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L28-L30) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaOracle.sol#L28-L30


 - [ ] ID-62
Parameter [SalvaMath.calculateTokenAmountOut(uint256,uint256,uint256)._factor](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L5) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L5


 - [ ] ID-63
Parameter [SalvaMath.calculateNGNsAmountOut(uint256,uint256,uint256)._amountIn](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L13) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Library/SalvaMath.sol#L13


 - [ ] ID-64
Parameter [SwapEngine.swapExactAmountToNGNs(address,address,address,uint256)._swapTokenIn](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L47) is not in mixedCase

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SwapEngine.sol#L47


## too-many-digits
Impact: Informational
Confidence: Medium
 - [ ] ID-65
[Clones.cloneDeterministic(address,bytes32,uint256)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L90-L109) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,implementation << 96 >> 232 | 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L101)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L90-L109INFO:Slither:. analyzed (28 contracts with 101 detectors), 75 result(s) found



 - [ ] ID-66
[Clones.clone(address,uint256)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L47-L62) uses literals with too many digits:
	- [mstore(uint256,uint256)(0x00,implementation << 96 >> 232 | 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L54)

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/proxy/Clones.sol#L47-L62


## unindexed-event-address
Impact: Informational
Confidence: High
 - [ ] ID-67
Event [ISalvaPool.Paused(address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Interfaces/ISalvaPool.sol#L24) has address parameters but no indexed parameters

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Interfaces/ISalvaPool.sol#L24


 - [ ] ID-68
Event [PoolFactory.ImplementationUpdated(address,address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L34) has address parameters but no indexed parameters

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L34


 - [ ] ID-69
Event [ISalvaPool.Unpaused(address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Interfaces/ISalvaPool.sol#L25) has address parameters but no indexed parameters

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Interfaces/ISalvaPool.sol#L25


 - [ ] ID-70
Event [IERC1967.AdminChanged(address,address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L18) has address parameters but no indexed parameters

https://github.com/cboi019/SALVA-NEXUS/blob/main/lib/openzeppelin-contracts/contracts/interfaces/IERC1967.sol#L18


 - [ ] ID-71
Event [PoolFactory.MultiSigUpdated(address,address)](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L35) has address parameters but no indexed parameters

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L35


## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-72
[PoolFactory.__gap](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L47) is never used in [PoolFactory](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L19-L142)

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/Factory/PoolFactory.sol#L47


 - [ ] ID-73
[PoolStorage.MULTISIG](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L7) is never used in [SalvaPool](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/SalvaPool.sol#L8-L44)

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L7


## constable-states
Impact: Optimization
Confidence: High
 - [ ] ID-74
[PoolStorage.MULTISIG](https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L7) should be constant 

https://github.com/cboi019/SALVA-NEXUS/blob/main/src/Core/PoolStorage.sol#L7


