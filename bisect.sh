#!/bin/bash

# Get package name from arguments
PACKAGE_NAME="$1"
# Check if the package name is provided
if [ -z "$PACKAGE_NAME" ]; then
  echo "Please provide the package name"
  exit 1
fi

# Get the specified test script from arguments
TEST_FILE="$2"
# Check if the test script is provided
if [ -z "$TEST_FILE" ]; then
  echo "Please provide the test file"
  exit 1
fi

# Check if jq is installed
if ! [ -x "$(command -v jq)" ]; then
  echo "Error: jq is not installed." >&2
  exit 1
fi

# Fetch versions and store them in an array
VERSIONS=($(npm view "$PACKAGE_NAME" versions --json | jq -r '.[]'))

# Log how many versions we are going to test
echo "Testing $PACKAGE_NAME with ${#VERSIONS[@]} versions"

# Temporary file to capture stderr output
ERR_LOG_FILE=$(mktemp)

# Get the current terminal width
COLUMNS=$(tput cols)
# Calculate the maximum width for error log
MAX_ERROR_LOG_WIDTH=$((COLUMNS - 20))

# Prepare result logging as a list of version -> status
declare -a VERSION_RESULTS

# Loop through each version of the package
for VERSION in "${VERSIONS[@]}"
do
  echo "Testing $PACKAGE_NAME version: $VERSION"
  
  # Install the specific version of the package
  yarn add $PACKAGE_NAME@$VERSION --silent

  # Check if the install succeeded
  if [ $? -ne 0 ]; then
    echo "Failed to install $PACKAGE_NAME@$VERSION"
    continue
  fi

  # Run the test with node
  TEST_BISECT_VERSION=${VERSION} node "$TEST_FILE" 2> $ERR_LOG_FILE
  TEST_RESULT=$?
  
  if [ $TEST_RESULT -eq 0 ]; then
    echo "$PACKAGE_NAME@$VERSION is good"
    VERSION_RESULTS+=("$VERSION: good")
  else
    echo "$PACKAGE_NAME@$VERSION is bad"
    cat $ERR_LOG_FILE
    # Capture the first 60 characters of stderr, escape newlines
    ERROR_MESSAGE=$(head -c "$MAX_ERROR_LOG_WIDTH" "$ERR_LOG_FILE" | tr '\n' '\\n')
    VERSION_RESULTS+=("$VERSION: bad ($TEST_RESULT): $ERROR_MESSAGE")
  fi
  echo ""

done

# Summary logging
echo "-----------------------------------"
echo "Test Summary for $PACKAGE_NAME (Total: ${#VERSIONS[@]})"
echo "-----------------------------------"
for RESULT in "${VERSION_RESULTS[@]}"; do
  echo "$RESULT"
done
echo "-----------------------------------"