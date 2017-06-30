#!/usr/bin/env bash

VERSION=$(cat VERSION)
BASE_DIR="entrada-$VERSION"
echo "Create ENTRADA installation package for version $VERSION"

cd dnslib4java
mvn install
cd ../pcaplib4java
mvn install
cd ../pcap-to-parquet
mvn install -DskipTests
cd ..

mkdir $BASE_DIR
cp pcap-to-parquet/target/pcap-to-parquet-$VERSION-jar-with-dependencies.jar $BASE_DIR
cp -R scripts $BASE_DIR
cp -R grafana-dashboard $BASE_DIR
cp VERSION $BASE_DIR
cp UPGRADE $BASE_DIR
cd $BASE_DIR
ln -s pcap-to-parquet-$VERSION-jar-with-dependencies.jar entrada-latest.jar
cd ..

tar -zcvf "$BASE_DIR.tar.gz" $BASE_DIR
rm -rf $BASE_DIR
