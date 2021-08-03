node {
    stage ('Checkout'){
    sh "rm -rf $WORKSPACE/*"
    sh "git clone https://github.com/Coveros/helloworld"
    }
    stage ('Clean')
    sh "cd $WORKSPACE/helloworld && mvn clean"
	
    stage ('Package')
    sh "cd $WORKSPACE/helloworld && mvn package"
    
    stage ('Execute'){
    sh "cd $WORKSPACE/helloworld && java -cp target/helloworld-1.1.jar com.coveros.demo.helloworld.HelloWorld "
    }
    
    stage ('Notify'){
    emailext body: 'Test Message',
    subject: '$BUILD_DISPLAY_NAME - $currentResult',
    to: 'suman25485@gmail.com'}
}