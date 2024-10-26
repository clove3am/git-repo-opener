# Git Repository URL Opener

This Bash script allows you to quickly open the remote URL of a Git repository in your default web browser. It's useful for developers who frequently need to access the web interface of their Git repositories (e.g., GitHub, GitLab, Bitbucket).

> Built partly with the help of [Claude](https://claude.ai/)

## Features

- Opens the remote URL of a Git repository in your default web browser
- Works with both HTTPS and SSH remote URLs
- Can be run from any directory within a Git repository
- Allows specifying a different Git repository directory
- Option to only print the URL without opening the browser

## Prerequisites

- Git installed and accessible from the command line
- A default web browser (the script uses `xdg-open` on Linux)

## Installation

1. Download the script:
    ```
    sudo curl -o /usr/local/bin/git-repo-opener https://raw.githubusercontent.com/clove3am/git-repo-opener/main/git-repo-opener.sh
    ```
3. Make it executable:
   ```
   chmod +x /usr/local/bin/git-repo-opener
   ```

## Usage

### Basic Usage

Run the script from within a Git repository:

```
git-repo-opener
```

This will open the remote URL of the current Git repository in your default web browser.

### Command-line Options

- `-h` or `--help`: Display the help message
- `-d <path>` or `--directory <path>`: Specify a different Git repository directory
- `-p` or `--print`: Only print the URL, don't open in the browser

### Examples

1. Open the remote URL of the current directory's Git repository:
   ```
   git-repo-opener
   ```

2. Open the remote URL of a specific Git repository:
   ```
   git-repo-opener -d /path/to/your/repo
   ```

3. Only print the remote URL without opening it:
   ```
   git-repo-opener -p
   ```

4. Print the remote URL of a specific repository:
   ```
   git-repo-opener -d /path/to/your/repo -p
   ```

## Contributing

Contributions to improve the script are welcome! Please feel free to submit issues or pull requests on the project's repository.

## License

This script is released under the MIT License. See the [LICENSE](LICENSE) file for details.
