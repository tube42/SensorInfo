import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Logic.js" as Logic
import "Constants.js" as Constants

// TODO: add some sort of dark/bright color to this

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
            text.text = Constants.AMBIENT_LIGHT_VALUES[a];

        }
    }

    // -------------------------------------
    Component.onCompleted: {
    }

}
