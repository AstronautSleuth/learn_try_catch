pragma solidity ^0.8.0;

contract A {
    uint256 data;
    constructor(uint256 _data) {
        data = _data;
    }
    function getData(uint256 _divisor) public view returns(uint256) {
        if(_divisor == 0) {
            revert();
        } else if (_divisor == 1) {
            assert(false);
        } else if (_divisor >= 10) {
            // require(_divisor < 10, "divisor too yuge!"); // Require(x, msg) is equivalent to if(x) revert(msg);
            revert("divisor too yuge!");
        }
        return data / _divisor;
    }
}

contract B {
    uint256 data;
    constructor(uint256 _data) {
        data = _data;
    }
    function getData() public view returns(uint256) {
        return data;
    }
}

contract C {
    function tryGetData(address _a, uint256 _divisor) public view returns (uint256, string memory) {
        try A(_a).getData(_divisor) returns (uint256 v) {
            return(v, "nil");
        } catch Error(string memory s) {
            return(420, s);
        } catch Panic(uint c) {
            return(c, "panic!");
        } catch (bytes memory) {
            return(1337, "catch all!");
        }
    }
}