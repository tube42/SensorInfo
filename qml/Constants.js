
var APP_VERSION = "0.2.0"
var APP_CODE_URL = "https://projects.developer.nokia.com/sensorinfo"
var APP_HOME_URL = "http://blog.tube42.se"
var APP_ABOUT_TEXT =
    "<b>Sensor Info (alpha release)</b>" +
    "<p>version " + APP_VERSION  +
    "<p>by <a href=\"" + APP_HOME_URL + "\">TUBE42</a> - av@tube42.se" +
    "<p><br>"    +
    "<p>SensorInfo can be used to examine phone sensors. " +
    "It is primarily used by developers, but can also be of use to normal users " +
    "who experience problems with their device or just want to play with phone sensors."+
    "<p><br>"    +
    "<p>SensorInfo is a very simple app written in QML. The source code is available at <a href=\"" + APP_CODE_URL + "\">Nokia Developer Forum</a> under under the GPLv3 license. " +
    "This app is currently under development. If you find any bugs or would like to suggest new features or imporvements, please contact the author via the Nokia Developer Forums";

/*
// -----------------------------------------

var DEFAULT_MARGIN = 18;

// -----------------------------------------

var FONT1 = "Nokia Pure Text"
var FONT2 = "Nokia Pure Text Light"




var LIST_TEXT_FONT = FONT1;
var LIST_TEXT_FONT_SIZE = 32;
var LIST_TEXT_COLOR = "#404080";

var LIST_DESCRIPTION_FONT = FONT1;
var LIST_DESCRIPTION_FONT_SIZE = 22;
var LIST_DESCRIPTION_COLOR = "#000000";


var PAGE_TITLE_FONT = FONT1;
var PAGE_TITLE_FONT_SIZE = 30;
var PAGE_TITLE_COLOR = "#aaaa00";
var PAGE_TITLE_AREA_COLOR = "#56160b";
*/
var ORIENTATION_VALUES = ["Undefined", "Top up", "Top down", "Left up", "Right up", "Face up", "Face down" ];

var AMBIENT_LIGHT_VALUES = [ "Undefined", "Dark", "Twilight", "Light", "Bright", "Sunny"] ;


// -------------------------------
var sensor_data_ = [
    // Orientation Sensor
    {
        "signatures" : [ "generic.orientation$$int", "meego.orientationsensor$$int"],
        "filename" : "SensorOrientationPage.qml",
        "data_names" : ["Orientation"],
        "icon" : "Orientation.svg"
    },

    // Ambient light
    {
        "signatures" : [ "generic.als$$int", "meego.als$$int"],
        "filename" : "SensorAmbientLightPage.qml",
        "data_names" : ["Light level"],
        "icon" : "AmbientLight.svg"
    },
    // Tap sensor light
    {
        "signatures" : [ "meego.tapsensor$$int.bool"],
        "filename" : "SensorTapPage.qml",
        "data_names" : ["Directions", "Double tap"],
        "icon" : "Tap.svg"
    },

    // maggan
    {
        "signatures" : [ "meego.magnetometer$$float.float.float.float"],
        "filename" : "SensorGenericPage.qml", // TODO
        "data_names" : ["X", "Y", "Z", "Calibration Level"],
        "icon" : "Unknown.svg" // TODO
    },
    // accelerometer
    {
        "signatures" : [ "meego.accelerometer$$float.float.float"],
        "filename" : "SensorGenericPage.qml", // TODO
        "data_names" : ["X", "Y", "Z"],
        "icon" : "Unknown.svg" // TODO
    },

    // proximity float
    {
        "signatures" : [ "meego.irproximitysensor$$float"],
        "filename" : "SensorGenericPage.qml", // TODO
        "data_names" : ["Close"],
        "icon" : "Unknown.svg" // TODO
    },

    // proximity bool
    {
        "signatures" : [ "meego.proximitysensor$$bool"],
        "filename" : "SensorGenericPage.qml", // TODO
        "data_names" : ["Close"],
        "icon" : "Unknown.svg" // TODO
    },

    // compass
    {
        "signatures" : [ "meego.compass$$float.float"],
        "filename" : "SensorCompassPage.qml", // TODO
        "data_names" : ["Azimuth", "Calibration level" ],
        "icon" : "Unknown.svg" // TODO
    },
    // rotation
    {
        "signatures" : [ "generic.rotation$$float.float.float", "meego.rotationsensor$$float.float.float" ],
        "filename" : "SensorGenericPage.qml", // TODO
        "data_names" : ["X", "Y", "Z"],
        "icon" : "Unknown.svg" // TODO
    },

    // grue
    {
        "signatures" : [ "grue.gruesensor$$float"],
        "filename" : "SensorGruePage.qml", // TODO
        "data_names" : ["Danger"],
        "icon" : "Unknown.svg" // TODO
    },

];

// default unknown
var sensor_data_unknown =
{
    "signatures" : ["" ],
    "filename" : "SensorGenericPage.qml",
    "data_names" : ["Unknown 1", "Unknown 2", "Unknown 3", "Unknown 4", "Unknown 5", "Unknown 6", "Unknown 7", "Unknown 8", "Unknown 9"],
    "icon" : "Unknown.svg"
};


