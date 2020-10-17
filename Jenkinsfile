pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_HUB = "https://registry-1.docker.io"
        DOCKER_IMAGE = "jenkins/jenkins"
        DOCKER_IMAGE_TAG = "latest"

        DOCKER_REGISTRY_MY = "localhost:5000"
        DOCKER_IMAGE_MY = "bakhuss/jenkins-ssh"
        DOCKER_IMAGE_TAG_MY = "latest"

        TOKEN = sh(script: 'curl "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$DOCKER_IMAGE:pull" | jq .token | tr -d \\"', returnStdout: true).trim();
        TOKEN_MY = sh(script: 'curl "https://auth.docker.io/token?service=registry.docker.io&scope=repository:$DOCKER_IMAGE_MY:pull" | jq .token | tr -d \\"', returnStdout: true).trim();
    }

    stages {
        stage('env') {
            steps {
                sh """
                    printenv
                """
            }
        }
        stage('jenkins-ssh - Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: "$GIT_PROJECT_CREDENTIAL_ID", url: "$GIT_PROJECT_URL"]]])
            }
        }
        stage('jenkins-ssh - docker') {
            environment {
                test="50"
//                LATEST_TAG = sh(script: 'curl -s -H "Authorization: Bearer $TOKEN" $DOCKER_REGISTRY_HUB/v2/$DOCKER_IMAGE/manifests/$DOCKER_IMAGE_TAG | grep -o "ENV JENKINS_VERSION=[0-9]*.[0-9]*"', returnStdout: true).trim();
//                LATEST_TAG = sh(script: 'curl -s -H "Authorization: Bearer $TOKEN" $DOCKER_REGISTRY_HUB/v2/$DOCKER_IMAGE/manifests/$DOCKER_IMAGE_TAG', returnStdout: true).trim();
//                LATEST_TAG_MY = sh(script: 'curl -s -H "Authorization: Bearer $TOKEN_MY" $DOCKER_REGISTRY_HUB/v2/$DOCKER_IMAGE_MY/manifests/$DOCKER_IMAGE_TAG_MY | grep -o "ENV JENKINS_VERSION=[0-9]*.[0-9]*"', returnStdout: true).trim();
            }
            steps {
                sh """
                    echo "curl"
                    curl -s -H "Authorization: Bearer $TOKEN" $DOCKER_REGISTRY_HUB/v2/$DOCKER_IMAGE/manifests/$DOCKER_IMAGE_TAG
                """
            }
        }
    }
}