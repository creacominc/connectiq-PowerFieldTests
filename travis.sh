#!/bin/bash
# travis.sh script to

SDK_URL="https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-win-2.3.4.zip"
SDK_FILE="sdk.zip"
SDK_DIR="sdk"

PEM_FILE="/tmp/developer_key.pem"
DER_FILE="/tmp/developer_key.der"

###

wget -O "${SDK_FILE}" "${SDK_URL}"
unzip "${SDK_FILE}" "bin/*" -d "${SDK_DIR}"

openssl genrsa -out "${PEM_FILE}" 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in "${PEM_FILE}" -out "${DER_FILE}" -nocrypt

export MB_HOME="${SDK_DIR}"
export MB_PRIVATE_KEY="${DER_FILE}"

# mb_runner needs to know where the resource folder is.
#./mb_runner/mb_runner.sh test `pwd` source/connectiq-PowerField/resources

#
# from mb_runner
#

PROJECT_HOME="${PWD}"
RESOURCES_FOLDER="source/connectiq-PowerField/resources"
SOURCE_FOLDER="source"

#CONFIG_FILE="${PROJECT_HOME}/mb_runner.cfg"
APP_NAME="PowerFieldTests"
TARGET_DEVICE="edge_1000"
TARGET_DEVICE="edge_1030"
TARGET_DEVICE="edge820"
TARGET_SDK_VERSION="2.3.0"

MANIFEST_FILE="${PROJECT_HOME}/manifest.xml"


RESOURCES="`cd /; find \"${PROJECT_HOME}/${RESOURCES_FOLDER}\"* -iname '*.xml' | tr '\n' ':'`"
SOURCES="`cd /; find \"${PROJECT_HOME}/${SOURCE_FOLDER}\" -iname '*.mc' | tr '\n' ' '`"

API_DB="${MB_HOME}/bin/api.db"
PROJECT_INFO="${MB_HOME}/bin/projectInfo.xml"
API_DEBUG="${MB_HOME}/bin/api.debug.xml"
DEVICES="${MB_HOME}/bin/devices.xml"

# **********
# processing
# **********

# prepare sdk executables and apply "wine-ification", if not already done so ...

if [ ! -e "${MB_HOME}/bin/monkeydo.bak" ] ; then
    cp -a "${MB_HOME}/bin/monkeydo" "${MB_HOME}/bin/monkeydo.bak"
    dos2unix "${MB_HOME}/bin/monkeydo"
    chmod +x "${MB_HOME}/bin/monkeydo"
    sed -i -e 's/"\$MB_HOME"\/shell/wine "\$MB_HOME"\/shell.exe/g' "${MB_HOME}/bin/monkeydo"
fi

if [ ! -e "${MB_HOME}/bin/monkeyc.bak" ] ; then
    cp -a "${MB_HOME}/bin/monkeyc" "${MB_HOME}/bin/monkeyc.bak"
    chmod +x "${MB_HOME}/bin/monkeyc"
    dos2unix "${MB_HOME}/bin/monkeyc"
fi

function concat_params_for_build
{
    PARAMS+="--apidb \"${API_DB}\" "
    PARAMS+="--device \"${TARGET_DEVICE}\" "
    PARAMS+="--import-dbg \"${API_DEBUG}\" "
    PARAMS+="--manifest \"${MANIFEST_FILE}\" "
    PARAMS+="--output \"${APP_NAME}.prg\" "
    PARAMS+="--project-info \"${PROJECT_INFO}\" "
    PARAMS+="--sdk-version \"${TARGET_SDK_VERSION}\" "
    PARAMS+="--unit-test "
    PARAMS+="--devices \"${DEVICES}\" "
    PARAMS+="--warn "
    PARAMS+="--private-key \"${MB_PRIVATE_KEY}\" "
    PARAMS+="--rez \"${RESOURCES}\" "
}

function run_mb_jar
{
	echo "java -jar \"${MB_HOME}/bin/monkeybrains.jar\" ${PARAMS} ${SOURCES}"
    java -jar "${MB_HOME}/bin/monkeybrains.jar" ${PARAMS} ${SOURCES}
}

function run_tests
{
	echo "\"${MB_HOME}/bin/monkeydo\" \"${PROJECT_HOME}/${APP_NAME}.prg\" -t"
    "${MB_HOME}/bin/monkeydo" "${PROJECT_HOME}/${APP_NAME}.prg" -t
}


cd ${PROJECT_HOME}
concat_params_for_build
run_mb_jar
run_tests




