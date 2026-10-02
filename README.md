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

### Challenges
- Parsing the nested JSON result

  This took some time to determine the format which was best to proceed with the display of information, using `.runtimeType` assisted in this as well as printing the result to the terminal to analyse.
- Handling Android Internet usage permissions

  Upon initial release build the following error occurred: `OS Error: No address associated with hostname, errno = 7`. It required me to update the androidManifest.xml to use the Internet and enable communication to the API.
- Handling web image restrictions
  
  Upon building for Chrome, the image information was retrieved but the program was unable to display the images. This was because the image origin: https://jwst-api-cdn.nyc3.cdn.digitaloceanspaces.com/ was different from the program origin resulting in a Cross-Origin Resource Sharing restriction. Changing the image generation from `NetworkImage()` to `Image.Network()` with an additional argument of `webHtmlElementStrategy: WebHtmlElementStrategy.prefer,` appears to have resolved this issue without leading to errors when building for Android or Windows.
- Security

  When uploading to github, the security had to be considered. In this case that relates to the API key. While this task may not require such measures, since the program is published to github it is good practice to remove any hardcoded API keys or similar. This now requires the additional argument of `--dart-define=JWST_API_KEY=<your-api-key>` to be used when running the program.

### Limitations
Image loading speed depends on the source image and network connection meaning some tiles stay blank for an extended duration.

Some API results may not contain usable image data resulting in either an error or a permanently blank tile.

Web builds may be affected by browser Cross-Origin Resource Sharing restrictions depending on how images are hosted by the source, as found during development and discussed in Challenges above. 

### Possible Improvements
- Making the user interface more responsive

  Flutter handles most of this natively in terms of the scale of the gridview items on screen however adjusting the number of tiles shown on screen would be another step forwards. This would be done by loading more and adjusting the crossaxiscount argument given to the Gridview.builder()
- Add/Improve Loading placeholders

  The loading tag exists for the reduction of simultaneous API requests, however this (or another tag) could be used to add loading icons to tiles which do not yet have the image rendered. Adding icons to indicate loading errors would also be an improvement, as many of the results of the request may be missing the location data or the resulting link may not connect. 

### Credits/Acknowledgements
JWST API: https://jwstapi.com

This work is based [in part] on observations made with the NASA/ESA/CSA James Webb Space Telescope. The data were obtained from the Mikulski Archive for Space Telescopes at the Space Telescope Science Institute, which is operated by the Association of Universities for Research in Astronomy, Inc., under NASA contract NAS5-03127 for JWST. These observations are associated with program #____.


