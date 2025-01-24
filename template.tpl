___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Variable Coalesce",
  "description": "Returns the first non-undefined, non-null value from a list of variables. If no valid value is found, a fallback value is returned.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "variableInputs",
    "displayName": "Input Variables (Comma-Separated)",
    "simpleValueType": true,
    "valueHint": "{{var1}},{{var2}},{{var3}},{{var4}}",
    "help": "Enter a list of variables separated by commas."
  },
  {
    "type": "TEXT",
    "name": "fallbackVariable",
    "displayName": "Fallback Variable",
    "simpleValueType": true,
    "valueHint": "e.g., {{fallback_var}}",
    "help": "Specify a fallback variable that will be used if all listed variables are empty or undefined."
  },
  {
    "type": "CHECKBOX",
    "name": "skipVariableCheckBox",
    "checkboxText": "Enable skipping specific values during variable checks.",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "skipVariableInput",
    "displayName": "Values to Skip (Comma-Separated)",
    "simpleValueType": true,
    "valueHint": "e.g., abc,xyz,true,false",
    "help": "Enter the values to skip when checking the list of variables. Separate them with commas.",
    "enablingConditions": [
      {
        "paramName": "skipVariableCheckBox",
        "paramValue": true,
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Define the template API
const makeString = require('makeString');

// Input fields
const variableInputs = data.variableInputs || ""; // Comma-separated list of variables
const fallbackVariable = data.fallbackVariable || ""; // Fallback value
const skipEnabled = data.skipVariableCheckBox === true; // Whether skipping is enabled
const skipValuesInput = data.skipVariableInput || ""; // Comma-separated skip values

// Helper function to split and trim a comma-separated string
function parseCommaSeparated(input) {
  if (!input) return [];
  return input.split(',').map(function(item) {
    return item.trim();
  }).filter(function(item) {
    return item.length > 0;
  });
}

// Parse the input variables and skip values
const variables = parseCommaSeparated(variableInputs);
const skipValues = skipEnabled ? parseCommaSeparated(skipValuesInput) : [];

// Function to check if a value is valid (non-undefined, non-null, non-empty)
function isValid(value) {
  return value !== undefined && value !== null && makeString(value).trim() !== "";
}

// Main logic: Iterate through the variables and find the first valid value
let result;
for (let i = 0; i < variables.length; i++) {
  const variableValue = makeString(variables[i]); // Directly process the value from the input list

  if (isValid(variableValue)) {
    // If skipping is enabled, ensure the value is not in the skip list
    if (!skipEnabled || skipValues.indexOf(variableValue) === -1) {
      result = variableValue;
      break;
    }
  }
}

// Use the fallback value if no valid variable was found
if (!isValid(result)) {
  result = isValid(fallbackVariable) ? makeString(fallbackVariable) : undefined;
}

return result;


___TESTS___

scenarios: []


___NOTES___

Created on 1/24/2025, 9:32:01 AM


