set -e
mkdir -p www
cp index.html www/
cat > package.json <<'JSON'
{"name":"daftar","version":"1.0.0","private":true}
JSON
cat > capacitor.config.json <<'JSON'
{"appId":"com.daftar.app","appName":"دفتر من","webDir":"www"}
JSON
npm i @capacitor/core@6 @capacitor/cli@6 @capacitor/android@6
npm i @aparajita/capacitor-biometric-auth@9 || echo "biometric plugin install failed"
npx cap add android
npx cap sync android
sed -i -E 's#gradle-[0-9.]+-(bin|all)\.zip#gradle-8.5-bin.zip#' android/gradle/wrapper/gradle-wrapper.properties
cd android
./gradlew assembleDebug
