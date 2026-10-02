# Graduate Mobile Developer
## Take Home Assignment
### Jade Barton

Chosen Task: Build a single page infinitely scrolling app of photos or data from the JWST
API: https://jwstapi.com

#### Features:
- Fetch data from the JWST API using pagination
- Display retrieved images as tiles on an infinitely scrolling user interface
- Display pop-up information about the image on press

#### Built With:
- Flutter
- Dart
- JWST API

#### Tested Platforms
- Android Mobile
- Google Chrome 154.0.8037.58
- Microsoft Windows 10.0.26200.9457

### Getting Started
#### Pre-requisites
- Ensure Flutter is Installed and Configured
- Clone the repositry
- Navigate to the project directory `cd PROJECT_DIR`
- Head to [JWST API](https://jwstapi.com/#) and request an API key
- Run `flutter clean` to clean any cached builds
- Run `flutter pub get` to install dependencies
- Run `flutter run --dart-define=JWST_API_KEY=<your-api-key>` to start the program

### Design
The data is loaded by page, using the API call shown in the JWST API Documentation. This pagination is to reduce the amount of data being requested at a time.
Checks are made to determine whether there is an ongoing API request, to eliminate the possibility of simultaneous requests and reduce network usage.
Infinite scrolling is implemented so that as the user reaches the bottom of the page, another request is made to load the next page of data. 
Flutters `GridView.builder()` handles the generation and destruction of on/off screen tiles allowing for a balanced load.
A final touch after deciding to post to Github was to remove the hard-coded API key, this was done by adding `String.fromEnvironment()` to the script to store information contained within the `--dart-define=....` section of the run command


### Credits/Acknowledgements
JWST API: https://jwstapi.com

This work is based [in part] on observations made with the NASA/ESA/CSA James Webb Space Telescope. The data were obtained from the Mikulski Archive for Space Telescopes at the Space Telescope Science Institute, which is operated by the Association of Universities for Research in Astronomy, Inc., under NASA contract NAS5-03127 for JWST. These observations are associated with program #____.


