import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Logic.js" as Logic

BaseSensorDataPage {
    id: page
    title: sensor.name;

    Rectangle {
        id: background;
        anchors.fill:  parent;
        color: "white"

        Behavior on color {
            ColorAnimation { duration: 1000 }
        }

        Text {
            id: text;
            anchors.centerIn: parent
            width: parent.width * 0.75

            horizontalAlignment: Text.AlignHCenter

            font.pixelSize: 32
            wrapMode: Text.WordWrap
            text:  "No data";
            color: "black"
        }

        Behavior on color {
            ColorAnimation { duration: 1000 }
        }

    }

    Connections {
        target: sensor
        onDataUpdated: {
            var a = sensor.getSensorDataValue(0);
            var max = sensor.getSensorRangeMaximum(0);
            if(max == 0) max = 1;
            if(a < 0) a = 0;
            if(a > max) a = max;

            var c = a / max; // [0, 1]
            a = Math.round(a * 100 / max); // [0,100]

            if(a <= 5)  text.text = "You are safe from Grues";
            else if(a >= 95)  text.text = "It is pitch black. You are likely to be eaten by a grue";
            else text.text = "Your chance of being eaten by a Grue is " + a + "%";

            background.color = Qt.rgba(1-c, 1-c, 1-c, 1);
            text.color = Qt.rgba(c, 0, 0, 1);
        }
    }

    // -------------------------------------
    Component.onCompleted: {
    }

}
