#!/bin/bash

# Step 1: Update system packages
sudo apt update
sudo apt upgrade -y

# Step 2: Install Java Development Kit (JDK)
sudo apt install -y openjdk-11-jdk

# Step 3: Add Jenkins repository and key
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Step 4: Install Jenkins
sudo apt update
sudo apt install -y jenkins

# Step 5: Start Jenkins service
sudo systemctl start jenkins

# Step 6: Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Step 7: Check Jenkins status
sudo systemctl status jenkins

# Step 8: Access Jenkins web interface
echo "Access Jenkins web interface at: http://your_server_ip_or_domain:8080"

# Step 9: Find and display Jenkins admin password
jenkins_password=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo "Jenkins admin password: $jenkins_password"

# Step 10: Allow port 8080 to the internet
echo "Don't forget to allow port 8080 to the internet to access Jenkins externally."
echo "For example, if using AWS, configure security groups accordingly."

# Step 11: Follow the setup wizard
echo "Follow the setup wizard to customize your Jenkins installation."

# Add Jenkins user to sudo group
echo "Adding Jenkins user to sudo group..."
sudo usermod -aG sudo jenkins

# Ensure sudo group privileges
echo "Ensure sudo group privileges..."
echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/90-cloud-init-users

# Print confirmation message
echo "Jenkins user added to sudo group with sudo privileges."


#source https://www.coachdevops.com/2024/01/install-jenkins-on-ubuntu-2204-setup.html
# source https://pkg.origin.jenkins.io/debian/

