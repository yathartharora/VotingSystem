const path= require('path');
const solc = require('solc');
const fs = require('fs-extra');

const buildPath = path.resolve(__dirname,'build');
fs.removeSync(buildPath);

const RegisterAsVoterPath = path.resolve(__dirname,'contract','RegisterAsVoter.sol');


const source = fs.readFileSync(RegisterAsVoterPath,'utf8');

const output = solc.compile(source,1).contracts;

fs.ensureDirSync(buildPath);

for (let c in output) {
    fs.outputJSONSync(
        path.resolve(buildPath, c.replace(':','') + '.json'),
        output[c],
    );
}
