from maven:3-jdk-11

run apt-get update && \
    apt-get install -y tree vim git

# get the bundle produced by alpha-language/scripts/make-bundle.sh
run mkdir -p /tmp/tmp && \
    cd /tmp/tmp && \
    git clone https://github.com/csu-cs-melange/alpha-language && \
    cd alpha-language && \
    ./scripts/make-bundle.sh linux-x86 && \
    tar -C /opt -xzf eclipse-alpha-language-linux-x86.tar.gz && \
    cd /tmp && \
    rm -rf /tmp/tmp

# get the junit jars
# https://github.com/junit-team/junit4/wiki/Download-and-Install
run cd /opt && \
    wget https://repo1.maven.org/maven2/junit/junit/4.13.2/junit-4.13.2.jar && \
    wget https://repo1.maven.org/maven2/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar

add *.sh /opt/
