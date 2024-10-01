#!/bin/sh -l
set -e
set -o pipefail

_CLI_COMMAND=$1
_PURGE_TYPE=$2
_PURGE_REF=$3
_PURGE_NETWORK=$4


case ${_PURGE_TYPE} in
  cpcode)
    _CLI_OPT="--cpcode"
  ;;

  tag)
    _CLI_OPT="--tag"
  ;;
  
  url)
    _CLI_OPT=""
  ;;
  
  *)
    echo "Unknown ${_PURGE_TYPE} ... exiting"
    exit 123
  ;;
esac

case ${_PURGE_NETWORK} in
  staging)
    _NETWORK="--staging"
  ;;

  production)
    _NETWORK="--production"
  ;;
  
  both)
    _NETWORK=""
  ;;
  
  *)
    echo "Unkown ${_PURGE_NETWORK} .... exiting"
  ;;
esac

PURGECOMMAND=""
for word in ${_PURGE_REF}
do
	PURGECOMMAND="${PURGECOMMAND} ${_CLI_OPT} '$word'"
done
echo "akamai purge ${_CLI_COMMAND} ${_NETWORK} $PURGECOMMAND"

# Create /root/.edgerc file from env variable
echo -e "${EDGERC}" > /root/.edgerc

# Send purge request
akamai purge \
  --edgerc /root/.edgerc \
  --section ccu \
  ${_CLI_COMMAND} \
  ${_NETWORK} \
  $PURGECOMMAND
