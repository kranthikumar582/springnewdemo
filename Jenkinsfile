pipeline {
    agent any

    environment {
        JOB_NAME = 'springdemo'
	JENKINS_HOME = '/var/lib/jenkins'
        USER = 'kranthikumarv'
	IMAGE_NAME = 'demo'
	TAG = 'springv1'

        
    }
    tools {
        
        maven 'M2_HOME'       
    }
    
    stages {
	
        stage('code checkout') {
            steps {

                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kranthikumar582/springnewdemo.git']]]) 
                
            }
        }
        stage('Code Build') {
            steps {
                 
                sh "mvn clean install"

            }
        }

        stage('Build a docker image & push it to registry') {
            steps {
                script {
                       withCredentials([string(credentialsId: 'docker_login_passwd', variable: 'var1')]) {
                       sh "cd $JENKINS_HOME/workspace/${JOB_NAME}/"
                       sh 'docker login -u=${USER} -p="${var1}"'                  
                       sh 'docker build -t ${USER}/${IMAGE_NAME}:${TAG} .'
                       sh "docker push ${USER}/${IMAGE_NAME}:${TAG}"
                      } 

                   
                }

            }
        
        }
        stage('Deploy to kubernetes cluster') {
            steps {
                 
				 sh 'sudo su - jenkins'
				 sh 'whoami'
				 sh 'pwd'
				 sh 'chmod +x manifest.yml'
                 sh 'kubectl apply -f manifest.yml'

            }
        }
		
     }

}
