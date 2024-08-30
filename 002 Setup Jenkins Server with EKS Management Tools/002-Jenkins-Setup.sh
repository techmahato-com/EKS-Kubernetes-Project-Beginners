#!/bin/bash

# This script is created by Tech Mahato | Arbind Sir
# Don't forget to subscribe to the YouTube channel: 
# https://www.youtube.com/c/TechMahato?sub_confirmation=1

# Step 1: Update system packages
sudo apt update
sudo apt upgrade -y

# Step 2: Install Java Runtime Environment (JRE)
sudo apt install -y openjdk-17-jre

# Step 3: Add Jenkins repository key and repository
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Step 4: Install Jenkins
sudo apt update
sudo apt install -y fontconfig jenkins

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

# Step 12: Add Jenkins user to sudo group
echo "Adding Jenkins user to sudo group..."
sudo usermod -aG sudo jenkins

# Step 13: Ensure sudo group privileges
echo "Ensure sudo group privileges..."
echo "jenkins ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/90-cloud-init-users

# Step 14: Print confirmation message
echo "Jenkins user added to sudo group with sudo privileges."

# End of script
