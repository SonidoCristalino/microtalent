# Use an official Ubuntu 22.04 image as the base
FROM ubuntu:22.04

# Set environment variable to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update repositories and install the main dependencies in a single layer:
# Git, Maven (for Java), OpenJDK (to compile and run Java),
# PostgreSQL Client, Apache2, and helper tools.
RUN apt-get update && apt-get install -y \
    git \
    maven \
    openjdk-17-jdk \
    postgresql-client \
    apache2 \
    wget \
    gnupg \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# === Install .NET SDK 6.0 (to build .NET Core projects) ===
# Download the Microsoft repository package
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
# Install the package
RUN dpkg -i packages-microsoft-prod.deb
# Clean up the downloaded file
RUN rm packages-microsoft-prod.deb
# Update repositories and install the SDK
RUN apt-get update && apt-get install -y apt-transport-https && apt-get install -y dotnet-sdk-6.0

# === Install Visual Studio Code ===
# VS Code is a desktop app; this step installs the binary into the system
# Download the latest stable version for Debian/Ubuntu (.deb)
RUN wget -O vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
# Install the package and its dependencies
RUN apt-get install -f -y ./vscode.deb
# Clean up the downloaded file
RUN rm vscode.deb

# === Configure Apache Server ===
# Copy the local 'index.html' file to the Apache web directory in the container
COPY index.html /var/www/html/

# Expose port 80 to allow access to Apache
EXPOSE 80

# Command that will be executed when the container starts.
# This starts Apache in the foreground to keep the container alive.
CMD ["apache2ctl", "-D", "FOREGROUND"]
