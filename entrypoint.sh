#!/bin/bash -l
set -o errexit
set -o nounset
set -o pipefail

echo "Arg: $1"
echo "PWD: $PWD"

set -o xtrace

ls

PROJECT_PATH='./Developers/Unity Project/Spooksville'

git clean -xnd "$PROJECT_PATH"

/opt/Unity/Editor/Unity -projectPath "$PROJECT_PATH" -batchmode -quit -nographics -logFile - -executeMethod "UnityEditor.SyncVS.SyncSolution"

git clean -xnd "$PROJECT_PATH"

dotnet msbuild "$PROJECT_PATH/Spooksville.sln" /p:RunCodeAnalysis=true

#tail -f /dev/null #Keep container alive

