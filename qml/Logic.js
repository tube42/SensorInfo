
Qt.include("Constants.js")


// var sensor_database = null;

// --------------------------------

function getSensorDatabase()
{
    if(userData.sensor_database == null) {

        console.log("LOADING DATABASE");

        // setup sensor as a table for fatser access
        var tmp = { }

        for(var i = 0; i < sensor_data_.length; i++) {
            var entry = sensor_data_[i];
            for(var j = 0; j <  entry.signatures.length; j++) {
                tmp[ entry.signatures[j] ] = entry;
            }
        }
        userData.sensor_database = tmp;
    }

    return userData.sensor_database;
}


function getSensorEntryBySignature(sign)
{
    var entry = getSensorDatabase()[ sign];

    if(entry == null) entry = sensor_data_unknown;
    return entry;
}


// --------------------------------

function pushPageFromFile(file) {
    return setPageFile(file, false);
}

function setPageFromFile(file) {
    return setPageFile(file, true);
}

function setPageFile(file, isRoot)
{
    var component = Qt.createComponent(file)
    if (component.status == Component.Ready) {
        if(isRoot) pageStack.clear();
        pageStack.push(component);
        return component;
    } else {
        console.log("Error loading component:", component.errorString());
        return null;
    }
}


// ------------------------------------------

function openSensorInfoPage(index)
{
    sensor.createSensor(index);
    infoPage.initPage();
    pageStack.push(infoPage);
    console.log("Opened sensor info", index);
}

function deleteSensor()
{
    sensor.deleteSensor();
    console.log("deleted sensor");
}


function openSensorDataPage()
{
    sensor.startSensor();
    console.log("started sensor");

    var entry = getSensorEntry();
    var file = entry.filename;
    pushPageFromFile(file);
}

function stopSensor()
{
    sensor.stopSensor();
    console.log("stoped sensor");
}

// --

// a kind of complex way for getting the current entry
// we use C++ sensor instead of a global JS variable
function getSensorEntry()
{
    var index = sensor.getSensor();

    var signature = sensor.getSensorListSignature(index);
    if(signature == "") return null;

    return getSensorEntryBySignature(signature);
}

function getSensorIndex()
{
    return sensor.getSensor();
}
