Command Syntax Help
===================

Every command (for example `help <command>` and `commandinfo <command>`) has a syntax help description with either no parameters, required parameters, optional parameters, or a combination of required and optional parameters.

A command that is surrounded with carets (`<command>`) means the parameter is required.
A command that is surrounded with brackets (`[command]`) means the parameter is optional.
A command that has no parameters will not use anything after the command, but still trigger (unless instructed otherwise).

Say we have the command `help <module> [command]`, this command expects at least one parameter, and at maximum two.