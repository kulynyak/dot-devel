#!/usr/bin/env bash

pkg.install() {
    case $(os.platform) in
		osx)
			osx
			;;
		linux)
			linux
			;;
	esac
}

##############################################################################

osx() {
	brew cask install java
	brew cask install meld
	brew cask install sourcetree
	brew install maven
	brew install jq
	brew install markdown
	brew install node
	brew install watchman
	brew install protobuf
}

##############################################################################

linux() {
	ORA_VER="7"

	sudo apt-get install -y python-software-properties
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo apt-get update

	# Enable silent install
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

	sudo apt-get install -y oracle-java${ORA_VER}-installer

	# Not always necessary, but just in case...
	sudo update-java-alternatives -s java-${ORA_VER}-oracle

	# Setting Java environment variables
	sudo apt-get install -y oracle-java${ORA_VER}-set-default

	sudo apt-get install maven

	sudo add-apt-repository -y ppa:eugenesan/ppa
	sudo apt-get update
	sudo apt-get install -y smartgit
}

##############################################################################

pkg.link() {
	fs.link_files git
	fs.link_file bin $ELLIPSIS_HOME/bin
}
