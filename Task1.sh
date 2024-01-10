#!/bin/bash

# Command version
VERSION="v0.1.0"

# Section A
case "$1" in
    "man")
        # Manual page for internsctl
        echo "Manual page for internsctl"
        # Add detailed documentation here
        ;;
    "--help")
        # Help command
        echo "Help for internsctl"
        # Add examples and use cases here
        ;;
    "--version")
        # Display command version
        echo "internsctl $VERSION"
        ;;
    *)
        # Section B
        case "$1" in
            "cpu")
                case "$2" in
                    "getinfo")
                        # Command to get CPU information
                        lscpu
                        ;;
                    *)
                        echo "Invalid subcommand for cpu"
                        ;;
                esac
                ;;
            "memory")
                case "$2" in
                    "getinfo")
                        # Command to get Memory information
                        free
                        ;;
                    *)
                        echo "Invalid subcommand for memory"
                        ;;
                esac
                ;;
            "user")
                case "$2" in
                    "create")
                        # Command to create a new user
                        if [ -n "$3" ]; then
                            sudo useradd -m "$3"
                            echo "User $3 created successfully."
                        else
                            echo "Usage: internsctl user create <username>"
                        fi
                        ;;
                    "list")
                        # Command to list all users or users with sudo permissions
                        if [ "$3" == "--sudo-only" ]; then
                            getent passwd | grep -E 'sudo|admin'
                        else
                            getent passwd
                        fi
                        ;;
                    *)
                        echo "Invalid subcommand for user"
                        ;;
                esac
                ;;
            "file")
                case "$2" in
                    "getinfo")
                        # Command to get file information
                        filename="$3"
                        if [ -n "$filename" ]; then
                            case "$4" in
                                "--size" | "-s")
                                    stat --printf="%s" "$filename"
                                    ;;
                                "--permissions" | "-p")
                                    stat --printf="%A" "$filename"
                                    ;;
                                "--owner" | "-o")
                                    stat --printf="%U" "$filename"
                                    ;;
                                "--last-modified" | "-m")
                                    stat --printf="%y" "$filename"
                                    ;;
                                *)
                                    # Default output if no options specified
                                    stat --printf="File: %n\nAccess: %A\nSize(B): %s\nOwner: %U\nModify: %y\n" "$filename"
                                    ;;
                            esac
                        else
                            echo "Usage: internsctl file getinfo [options] <file-name>"
                        fi
                        ;;
                    *)
                        echo "Invalid subcommand for file"
                        ;;
                esac
                ;;
            *)
                echo "Invalid command"
                ;;
        esac
        ;;
esac
