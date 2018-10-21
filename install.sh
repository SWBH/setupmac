#!/bin/bash

ansible-playbook -i ./hosts setup.yml --verbose --ask-become-pass --tags "install"