___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_5TQT9",
  "version": 1,
  "displayName": "Variable Coalesce",
  "description": "Checks a list of variables in order and returns the first valid value found (non-undefined, non-null value, non-empty), with optional value skipping and a configurable fallback. No custom JavaScript.",
  "containerContexts": [
    "WEB"
  ],
  "securityGroups": []
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "PARAM_TABLE",
    "name": "VariableTableInput",
    "displayName": "Enter Variables In Each Row",
    "paramTableColumns": [
      {
        "param": {
          "type": "TEXT",
          "name": "variableInputTextRow",
          "displayName": "Variable List",
          "simpleValueType": true,
          "valueValidators": [
            {
              "type": "NON_EMPTY"
            }
          ],
          "valueHint": "e.g. {{var 1}}"
        },
        "isUnique": true
      }
    ],
    "newRowButtonText": "Add New Variable",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Enter a list of variables as rows"
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
const variableTableInput = data.VariableTableInput || []; // Array of row objects: [{variableInputTextRow: "value"}, ...]
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

// Extract the variable values from the table rows, in row order
function parseTableRows(tableInput) {
  if (!tableInput) return [];
  return tableInput.map(function(row) {
    return row.variableInputTextRow;
  }).filter(function(item) {
    return item !== undefined && item !== null;
  });
}

// Parse the input variables and skip values
const variables = parseTableRows(variableTableInput);
const skipValues = skipEnabled ? parseCommaSeparated(skipValuesInput) : [];

// Function to check if a value is valid (non-undefined, non-null, non-empty)
function isValid(value) {
  return value !== undefined && value !== null && makeString(value).trim() !== "";
}

// Main logic: Iterate through the variables and find the first valid value
let result;
for (let i = 0; i < variables.length; i++) {
  const variableValue = makeString(variables[i]); // Directly process the value from the table row
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


