PROJECT_NAME = ACPCampaign

setup:
	(npm install)
	(cd ios && pod deintegrate || true && pod install)

clean:
	(rm -rf android/build && rm -rf ios/build)
	(cd android && ./gradlew clean)
	(cd ios && xcodebuild clean -workspace RCT${PROJECT_NAME}.xcworkspace -scheme RCT${PROJECT_NAME})

build-android:
	(cd android && ./gradlew build -x lint)

build-ios: setup
	(cd ios && xcodebuild build -workspace RCT${PROJECT_NAME}.xcworkspace -scheme RCT${PROJECT_NAME})

build-sample-android:
	(cd sample/ACP*Sample/android && ./gradlew assembleRelease)

build-sample-ios:
	(cd sample/ACP*Sample/ios && xcodebuild build -project ACPCoreSample.xcodeproj -scheme ACPCoreSample CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED="NO" CODE_SIGNING_ALLOWED="NO")

run-tests:
	jest --testPathIgnorePatterns sample/ node_modules/ --modulePathIgnorePatterns sample/ --runInBand

copy-to-sample:
	cd sample/ACP*Sample/ && sh copy-changes-to-sample.sh

# fetches the latest iOS SDK and put them in the project
update-ios-lib:
	git clone https://github.com/Adobe-Marketing-Cloud/acp-sdks
	cp -a acp-sdks/iOS/${PROJECT_NAME}/ ios/libs/
	rm -rf acp-sdks
