import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Constants.js" as Constants

BaseSensorDataPage  {
    id: page
    title: sensor.name;

    Text {
        id: text;

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 64
        text:  "No data";
    }

    Connections {
        target: sensor
        onDataUpdated: {
            var a = sensor.getSensorDataValue(0);
            text.text = Constants.ORIENTATION_VALUES[a];
            // console.log("orintation", a, text.text) // DEBUG
        }
    }

    // -------------------------------------
    Component.onCompleted: {
    }

}
