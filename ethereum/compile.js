const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');


const buildPath = path.resolve(__dirname,'build');
fs.removeSync(buildPath);

const pathA = path.resolve(__dirname,'contract', 'RegisterAsVoter.sol');
//to find the path of A.sol inside the folder 'contract' in your project
const pathB = path.resolve(__dirname,'contract', 'Voting.sol');
const solA = fs.readFileSync(pathA, 'utf8');
const solB = fs.readFileSync(pathB, 'utf8');

const input = {
  sources: {
    'RegisterAsVoter.sol': solA,
    'Voting.sol': solB
  }
};
const output = solc.compile(input, 1).contracts;

fs.ensureDirSync(buildPath);

for (let c in output) {
    fs.outputJSONSync(
        path.resolve(buildPath, c.replace(':','') + '.json' ),
        output[c]
    );
}