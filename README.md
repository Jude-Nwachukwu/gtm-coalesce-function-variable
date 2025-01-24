# GTM Coalesce Function Variable (WEB)

A Google Tag Manager custom variable template that mimics the behavior of a coalesce function commonly used in programming. This variable checks a sequence of variables and returns the first valid value, supporting skip values and a fallback mechanism.

**Here is the custom template repository for the [server GTM custom template](https://github.com/Jude-Nwachukwu/sgtm-coalesce-function-variable)**


## Features

1. **Check Multiple Variables in Order**  
   Evaluate variables listed in the `variableInputs` field (comma-separated) in sequence.

2. **Return First Valid Value**  
   Returns the first non-undefined, non-null, and non-empty string value.

3. **Skip Specific Values**  
   When the `skipVariableCheckBox` is enabled, the variable skips any values listed in the `skipVariableInput` field.

4. **Fallback Value**  
   If no valid variable is found, the template returns the fallback value from the `fallbackVariable` field.

---

## Example Use Cases

| **Input Variables**                | **Skip Enabled** | **Skip Values** | **Fallback** | **Output**          | **Reason**                                                   |
|------------------------------------|------------------|-----------------|--------------|---------------------|-------------------------------------------------------------|
| `car,bag,red,blue`                 | `true`           | `car,red`       | `hello`      | `bag`               | `bag` is the first valid value that isn't skipped.          |
| `apple,orange,carrot`              | `false`          | -               | `default`    | `apple`             | Skipping is disabled, so the first valid value is returned. |
| `null,,red,blue`                   | `true`           | `red`           | `fallback`   | `blue`              | `blue` is the first valid value after skipping `red`.       |
| `null,,,`                          | `false`          | -               | `fallback`   | `fallback`          | All input variables are invalid; fallback is used.          |
| `car,bag,car,red`                  | `true`           | `car`           | `hello`      | `bag`               | Skips `car` and returns the next valid value, `bag`.        |
| `apple,carrot,banana`              | `true`           | `banana,carrot` | `backup`     | `apple`             | Skips `banana` and `carrot`, returning `apple`.             |

---

## Fields Configuration

- **Input Variables (`variableInputs`)**  
  Comma-separated list of variables to evaluate in order.

- **Fallback Variable (`fallbackVariable`)**  
  The fallback value if no valid variable is found.

- **Enable Skipping (`skipVariableCheckBox`)**  
  Checkbox to enable skipping specific values.

- **Values to Skip (`skipVariableInput`)**  
  Comma-separated list of values to skip when checking variables. This field is only active if the skip checkbox is enabled.

---

## Installation

1. Open your Google Tag Manager account.
2. Navigate to **Templates** > **New** > **Variable Template**.
3. Copy and paste the provided code into the GTM template editor.
4. Configure the fields as required and publish the template.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Author
Created by Jude Nwachukwu Onyejekwe.

Suggested by Elad Levy

Created as part of the [Dumbdata.co](https://dumbdata.co) measurement resource hub to provide you with resources that help simplify measurement.
