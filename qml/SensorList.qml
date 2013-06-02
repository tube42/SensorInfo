import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Logic.js" as Logic

BasicListPage {
    id: page
    title: "Avaliable sensors"

    signal itemSelected(int index, variant entry);

    onItemSelected: Logic.openSensorInfoPage(index);

    Component.onCompleted: update();


    function update() {

        // get sensor list:
        clear();
        for(var i = 0; i < sensor.sensorListCount; i++) {
            var signature = sensor.getSensorListSignature(i);
            var entry = Logic.getSensorEntryBySignature(signature);

            append( {
                "name" : sensor.getSensorListName(i),
                "identifier": sensor.getSensorListIdentifier(i),
                "description": sensor.getSensorListDescription(i),
                "icon" : entry.icon,
//                "entry" : entry,
                "index" : i });
        }
    }
}
