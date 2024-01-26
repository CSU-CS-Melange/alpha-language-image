from maven:3-jdk-11

run apt-get update && \
    apt-get install -y tree vim git

# get the bundle produced by alpha-language/scripts/make-bundle.sh
run mkdir -p /opt/tmp && \
    cd /opt/tmp && \
    git clone https://github.com/csu-cs-melange/alpha-language && \
    cd alpha-language && \
    ./scripts/make-bundle.sh linux-x86 && \
    cd /opt && \
    tar -xzf tmp/alpha-language/eclipse-bundle-linux-x86/eclipse-alpha-language-linux-x86.tar.gz && \
    rm -rf /opt/tmp

# get the junit jars
# https://github.com/junit-team/junit4/wiki/Download-and-Install
run cd /opt && \
    wget https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar && \
    wget https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar

add run-junit-tests.sh /usr/local/bin/org.junit.runner.JUnitCore
