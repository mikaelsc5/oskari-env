Oskari-env
==========

Oskari-env contains the ELF Oskari environment configuration files.
The repository is intended to be used with ansible-pull.

The goal is to manage the configuration using a repositry so that all nodes are able to independently update. Also the update process should be repeatable so that the nodes are always in a known state.
In practise the nodes will not have exactly identical states, but should be similar enough that this automation proves to be valuable.

This is experimental and should only be used with caution!
