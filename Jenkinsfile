pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "smdotcom/sample-app"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Load Env File') {
            steps {
                echo 'Loading environment variables...'
                script {
                    def envFile = readFile '.env'
                    envFile.eachLine { line ->
                        def (key, value) = line.split('=')
                        env[key] = value
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo 'Pushing Docker image to DockerHub...'
                sh """
                echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
                docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                """
            }
        }
    }
}
