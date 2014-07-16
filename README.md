vault-rcp-ui
============

This little project provides a UI to manage vault-rcp tasks and is based on the REST API provided by vault-rcp. It supports the following functionalities:
- create a task
- start a task
- delete a task

Supported are both CRX and Sling based instances which have different DAV endpoints configured.


The vault-rcp-ui utilizes the following front-end frameworks/libraries that are included via CDN for easier setup:
- jQuery (>=1.9.0)
- Handlebars
- Twitter Bootstrap (3.2.0)

It has been developed and tested against a Apache Sling SNAPSHOT instance built from sources. Required vault-core and vault-rcp bundles from the Apache Jackrabbit FileVault project are also part of this project (3.1.7-SNAPSHOT).


Get started
===========

Fork this repository and use the vlt-cli to import the complete jcr_root to a running Sling instance. Login with admin and request /vault-rcp-ui to load the vault-rcp admin UI.