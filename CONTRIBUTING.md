# Plugin development

A step-by-step guide:

0. [Install `dzen-dhall`](https://github.com/dzen-dhall/dzen-dhall#installing).

1. Clone this repo.

2. Choose a name for your plugin and run `./new.sh` passing that name as argument. This command will copy the [plugin template](#plugin-template) to a new directory.

3. Run `./check.sh your-plugin-name run` to make sure that everything is OK.

4. Write your implementation, rechecking correctness during the process using [`./check.sh`](./check.sh). You should also update `demo.dhall` every time you change the interface of your plugin (`check.sh` uses this file).

5. Add a section to the plugin catalogue below.

6. Make sure that your plugin satisfies the [requirements](#requirements).

7. Open a pull request.

# Requirements

To be merged into this repo, a plugin must fulfill these requirements:

- It must not contain URL imports in dhall code. We aim to support fully offline use.
- `usage` section of the meta field should contain a complete example that is ready to be copy-pasted by users to their `config.dhall`s.
- Plugin code should be human-readable.
- If a plugin emits events, sets variables or contains automata, it should be wrapped in a separate [`scope`](https://github.com/dzen-dhall/dzen-dhall#scopes). [Exceptions exist](#exposing-the-interface).
- If a plugin calls binaries, it should check if they are present in `PATH` using [assertions](https://github.com/dzen-dhall/dzen-dhall#assertions). If it depends on particular versions of the binaries, it should contain a `SuccessfulExit` assertion where version checks should be performed.
- Plugin directory should contain a `demo.dhall` file with a complete configuration that uses the newly created plugin as described in its `usage` section.
- A new entry to the [catalogue](#catalogue) should be added (preserving alphabetic ordering).

# Recommendations

These are optional, but always good to have.

- A plugin should be fixed-width, i.e. occupy the same area on the screen during runtime. Use [trimming](https://github.com/dzen-dhall/dzen-dhall#trimming-text) and [padding](https://github.com/dzen-dhall/dzen-dhall#padding-text) functions to achieve this.
- Put a `preview.png` of your plugin in its folder (if applicable).

# Advanced plugin development

## Plugins with settings

If you want to provide some settings, add `defaults` field to your plugin, containing a record of option values, and call your plugin with something like `plug (my-plugin.main my-plugin.defaults)` in `demo.dhall`. The user will be able to override any field of the provided defaults using `//`.

## Higher-order plugins

Assigning a function to the `main` field of your plugin is absolutely OK. No limitations at all: you are free to even accept other plugins.

It is possible to create highly customizable plugins that encapsulate some logic, and at the same time allow deep customization by exposing some APIs (variables and events) to accepted `Bar`s. Notable example is [`mpc` plugin](mpc/).

## Exposing the interface

It's OK to expose events and variables via optional `events` and `variables` fields. This way it is possible to create "headless" plugins that implement some logic or are just data sources.

Obviously, you shouldn't wrap your plugin in a separate `scope` when doing so. There is currently no way to separate the interface from the implementation, though, so you either expose everything or nothing.
