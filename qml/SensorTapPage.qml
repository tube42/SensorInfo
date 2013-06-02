import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Logic.js" as Logic

BaseSensorDataPage  {

    id: page
    title: sensor.name;
    onLeavingPage: Logic.stopSensor();

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Grid {
            id: grid;
            rows: 3; columns:  3; spacing : 10;
            anchors.horizontalCenter: parent.horizontalCenter

            TextBox { id: xm; text : "-" }
            TextBox { id: xx; text : "X" }
            TextBox { id: xp; text : "+" }

            TextBox { id: ym; text : "-" }
            TextBox { id: yy; text : "Y" }
            TextBox { id: yp; text : "+" }

            TextBox { id: zm; text : "-" }
            TextBox { id: zz; text : "Z" }
            TextBox { id: zp; text : "+" }
        }

        Rectangle { width: 1; height: 64; } // space
        Text {
            id: doubleText;
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 64
            text:  "No data";
        }
    }

    Connections {
        target: sensor

        onDataUpdated: {
            var tap = sensor.getSensorDataValue(0);
            var tap2 = sensor.getSensorDataValue(1);
            doubleText.text = tap2 ? "Double" : "Single";

            xp.show = tap & 0x010;
            yp.show = tap & 0x020;
            zp.show = tap & 0x040;

            xx.show = tap & 0x001;
            yy.show = tap & 0x002;
            zz.show = tap & 0x004;

            xm.show = tap & 0x100;
            ym.show = tap & 0x200;
            zm.show = tap & 0x400;


        }
    }

    // -------------------------------------
    Component.onCompleted: {
    }

}
