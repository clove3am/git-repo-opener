# Function to check if Git is installed
def check_git_installed [] {
    if ((git --version | is-empty)) {
        print "Git is not installed. Please install Git before running this script."
        exit 1
    }
}

# Function to get the remote URL
def get_remote_url [path: string] {
    git -C $path config --get remote.origin.url
}

# Function to convert SSH URL to HTTPS and clean up URL
def clean_url [url: string] {
    if ($url =~ '^git@([^:]+):(.+)\.git$') {
        let parsed = $url | parse --regex '(?s)git@(?P<domain>[^:]+):(?P<path>.+)\.git'
        if ($parsed | is-empty) {
            print $"Unable to parse SSH URL: ($url)"
            exit 1
        }
        return $"https://($parsed.domain.0)/($parsed.path.0)"
    } else if ($url =~ '^git://') {
        return $url | str replace 'git:' 'https:' | str replace '.git' ''
    } else if ($url =~ '^https?://') {
        return $url | str replace '.git' ''
    } else {
        print $"Unrecognized URL format: ($url)"
        exit 1
    }
}

# This script opens the remote Git repository URL in your default web browser.
def main [
    --print (-p) # Only print the URL, don't open in browser
    --directory (-d) = "." # Specify the Git repository directory
] {
    check_git_installed

    if (not ($directory | path exists)) {
        print $"The specified directory does not exist: ($directory)"
        exit 1
    }

    let remote_url: string = get_remote_url $directory

    if (not ($remote_url | is-not-empty)) {
        print $"No remote URL found in the Git repository: ($directory)"
        exit 1
    }
    
    let cleaned_url: string = clean_url $remote_url

    if ($print) { # print only
        echo $cleaned_url
    } else {
        # Open the URL in the default browser
        start $cleaned_url
        echo $"Opening URL: ($cleaned_url)"
    }
}