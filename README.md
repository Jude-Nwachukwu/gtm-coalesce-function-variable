# GTM Coalesce Function Variable (WEB)

A Google Tag Manager custom variable template that mimics the behavior of a coalesce function commonly used in programming. This variable checks a list of variables, in order, and returns the first valid value it finds — with optional support for skipping specific values and falling back to a default.

**Here is the custom template repository for the [server GTM custom template](https://github.com/Jude-Nwachukwu/sgtm-coalesce-function-variable)**

---

## Overview

Instead of writing a custom JavaScript variable to check `varA || varB || varC || 'default'`, this template gives you a simple table-based interface. Add a row for each variable you want checked, set an optional fallback, and the template returns the first one that actually has a usable value.

This is useful anywhere you're not sure which of several variables will be populated for a given event — for example, checking a user ID that might come from a login variable, a cookie, or a data layer push, depending on how the page fired.

---

## Features

- **Check multiple variables in order** — add as many rows as you need; they're evaluated top to bottom.
- **Returns the first valid value** — skips over anything undefined, null, or empty.
- **Optional skip list** — exclude specific values (like placeholder text or "false") from being treated as valid.
- **Fallback value** — define what should be returned if every variable in the list comes up empty.

---

## Setup Instructions

1. In Google Tag Manager, go to **Variables** and click **New** under User-Defined Variables.
2. Select this template from your library of custom variable templates.
3. Under **Enter Variables In Each Row**, click **Add New Variable** and enter each variable you want checked, one per row, in the order you want them evaluated.
4. In **Fallback Variable**, enter the value or variable to return if none of the rows above produce a valid result.
5. If there are specific values you want to treat as "not valid" (for example, a placeholder like `"n/a"`), check **Enable skipping specific values during variable checks** and list them in **Values to Skip**.
6. Save the variable and use it wherever you'd normally reference a GTM variable.

---

## Field Explanations

### Enter Variables In Each Row

Add one variable per row, in the order they should be checked. The template evaluates them top to bottom and returns the first one that has a real value.

Each row must be filled in — empty rows aren't allowed, and duplicate entries are automatically blocked.

### Fallback Variable

The value returned if none of the variables above are valid. This can be a static value or another GTM variable.

If left blank and every row comes back empty, the variable will return `undefined`.

### Enable skipping specific values during variable checks

Check this box if there are specific values that should be treated as invalid, even though they're technically populated. For example, if a variable sometimes resolves to the literal string `"undefined"` or a placeholder like `"none"`, this lets you exclude those from being accepted as a real value.

Leave this unchecked if every non-empty value should be accepted as-is.

### Values to Skip (Comma-Separated)

Only appears when skipping is enabled. Enter the values you want excluded, separated by commas — for example: `n/a, none, false`.

Matching is exact, so make sure the values here match the actual output of your variables.

---

## Example Use Cases

| **Rows**                              | **Skip Enabled** | **Skip Values** | **Fallback** | **Output**  | **Reason**                                                    |
|----------------------------------------|-------------------|------------------|---------------|-------------|-----------------------------------------------------------------|
| `car`, `bag`, `red`, `blue`            | Yes               | `car, red`       | `hello`       | `bag`       | `bag` is the first valid row value that isn't skipped.          |
| `apple`, `orange`, `carrot`            | No                | –                | `default`     | `apple`     | Skipping is off, so the first valid row wins.                   |
| *(empty)*, `red`, `blue`               | Yes               | `red`            | `fallback`    | `blue`      | `blue` is the first valid row after skipping `red`.              |
| *(all rows empty)*                     | No                | –                | `fallback`    | `fallback`  | No row had a valid value, so the fallback is used.               |
| `car`, `bag`, `car`, `red`             | Yes               | `car`            | `hello`       | `bag`       | Skips `car` and returns the next valid row, `bag`.               |
| `apple`, `carrot`, `banana`            | Yes               | `banana, carrot` | `backup`      | `apple`     | Skips `banana` and `carrot`, returning `apple`.                  |

---

## Testing / Validation

1. Open **Preview Mode** in GTM and load a page where the relevant variables would be populated.
2. Click into the tag or trigger using this variable, and check the **Variables** tab to confirm it resolved to the expected value.
3. Try triggering the event on a page where your first-choice variable is intentionally empty, to confirm it correctly falls through to the next row (or the fallback).
4. If using the skip list, test with a value from that list to confirm it's correctly bypassed.

---

## Troubleshooting

**The variable always returns the fallback, even when a row should have a valid value.**
Double check the rows in **Enter Variables In Each Row** — make sure each one references the correct variable and that the referenced variable is actually populated at the time this variable is evaluated.

**A value I expected to be skipped is still being returned.**
Skip matching is exact. Check for extra spaces, casing differences, or formatting mismatches between what's listed in **Values to Skip** and what the variable actually outputs.

**The variable returns nothing at all.**
This means every row was empty or skipped, and no **Fallback Variable** was set. Add a fallback if you want a guaranteed value.

---

## Notes and Limitations

- Rows are evaluated strictly in the order they appear in the table.
- Duplicate variable entries in the row table aren't allowed.
- The skip list only applies to exact matches — it doesn't support partial matches or wildcards.

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Author

Created by Jude Nwachukwu Onyejekwe.
Suggested by [Elad Levy](https://www.linkedin.com/in/eladlevy)

Created as part of the [Dumbdata.co](https://dumbdata.co) measurement resource hub to provide you with resources that help simplify measurement.
