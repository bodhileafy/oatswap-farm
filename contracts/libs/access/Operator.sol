// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/GSN/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/EnumerableSet.sol";

contract Operator is Context, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private _operators;

    /* =================== Events =================== */
    event OperatorAdded(address indexed operator, bool indexed result);
    event OperatorRemoved(address indexed operator, bool indexed result);

    constructor() internal {
        bool result = _operators.add(_msgSender());
        emit OperatorAdded(_msgSender(), result);
    }

    modifier onlyOperator() {
        require(_operators.contains(msg.sender), "operator: caller is not the operator");
        _;
    }

    function isOperator(address _operator) public view returns (bool) {
        return _operators.contains(_operator);
    }

    function operatorLength() public view returns (uint256) {
        return _operators.length();
    }

    function addOperator(address _operator) external onlyOwner returns (bool) {
        return _addOperator(_operator);
    }

    function _addOperator(address _operator) private returns (bool) {
        require(_operator != address(0), "operator: zero address given");
        require(!_operators.contains(_operator), "operator: operator already exists");

        bool result = _operators.add(_operator);
        emit OperatorAdded(_operator, result);

        return result;
    }

    function removeOperator(address _operator) external onlyOwner returns (bool) {
        return _removeOperator(_operator);
    }

    function _removeOperator(address _operator) private returns (bool) {
        require(_operator != address(0), "operator: zero address given");
        require(_operators.contains(_operator), "operator: the operator does not exist");

        bool result = _operators.remove(_operator);
        emit OperatorRemoved(_operator, result);

        return result;
    }
}
