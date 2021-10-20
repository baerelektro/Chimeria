pragma ton-solidity >= 0.50.0;
pragma AbiHeader expire;

contract Chimeria {

    event NewChimera(uint chimeraId, string name, uint typ);

    uint _typDigits = 16;
    uint _typModulus = 10 ** _typDigits;
    
    struct Chimera {
        string name;
        uint typ;
    }

    Chimera[] public _chimeras;

    function _createChimera (string name, uint typ) private {
        _chimeras.push(Chimera(name, typ));
        uint id = _chimeras.length - 1;
        emit NewChimera(id, name, typ);
    }

    function createChimera(string name) public returns (uint)
    {
        tvm.accept();
        uint randTyp = _generateTyp(name);
        _createChimera(name, randTyp);
        return _chimeras.length - 1;
    }

    function _generateTyp(string name) private view returns (uint)
    {
        uint hash = tvm.hash(name);
        return hash % _typModulus;
    }

    function getChimeraTyp(uint id) public view returns (uint)
    {
        return _chimeras[id].typ;
    }

    function getChimeraName(uint id) public view returns (string)
    {
        return _chimeras[id].name;
    }

    function ChimeraCount() public view returns (uint)
    {
        return _chimeras.length;
    }
}