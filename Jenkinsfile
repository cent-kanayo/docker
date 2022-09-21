pipeline{
    agent any
    
   
    stages {
        
      

        stage("Build"){
            steps{
                echo "running"
                sh '''
                    
                    sudo ssh -i /var/lib/jenkins/centserver.pem -t -o StrictHostKeyChecking=no ubuntu@ec2-52-91-244-28.compute-1.amazonaws.com
                    cd /var/www
                    sudo rm -rf html
                    sudo mkdir html
                    cd html
                    sudo git init
                    sudo git config --global --add safe.directory /var/www/html
                    sudo git remote add origin https://github.com/cent-kanayo/new-test-jenkins.git
                    sudo git pull origin main
                   
                '''
            }
        }
          
        stage('Test') {
            steps {
                echo 'Testing..'
                sh '''
                    sudo apt-get update
                    sudo apt-get install \
                        ca-certificates \
                        curl \
                        gnupg \
                        lsb-release -y
                    sudo mkdir -p /etc/apt/keyrings
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                    echo \
                        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                    sudo apt-get update
                    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
                '''
                
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh '''
                    sudo docker run -d -p 81:80 --name apachehmtl httpd
                '''
            }
        }
    }
}
