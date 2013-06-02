import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Logic.js" as Logic

BaseSensorDataPage {
    id: page
    title: sensor.name;

    property int compassSize : getCompassSize(page.width, canvas.height);
    property int degress: 0
    property int calibration: 100

    Item {
        anchors.top: parent.canvas.top
        anchors.left: parent.canvas.left
        anchors.right: parent.canvas.right
        anchors.bottom: texts.top

        Item {
            anchors.centerIn: parent
            height: compassSize
            width: compassSize

            Image {
                id: compassBackground
                anchors.fill: parent
                source: "/images/compass3.png"
                smooth: true;
            }

            Image {
                id: compassPoint
                anchors.fill: parent
                source: "/images/compassP2.png"
                smooth: true;
                fillMode: Image.PreserveAspectFit
                Behavior on rotation {
                    RotationAnimation {
                        duration: 1000;
                        direction: RotationAnimation.Shortest
                        easing.type: Easing.OutExpo
                    }
                }
            }

            Image {
                id: compassOverlay
                anchors.fill: parent
                source: "/images/compass4.png"
                smooth: true;
            }
        }
    }



    Column {
        id: texts
        anchors.bottom: parent.canvas.bottom
        anchors.bottomMargin: theme.defaultMargin

        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.canvas.width * 0.9

        spacing: theme.defaultMargin

        Text {
            id: degreeText
            text : "No data"
            font.family: theme.listTextFont
            font.pixelSize: theme.listTextFontSize
            color: theme.listTextColor
            font.bold: true;

        }
        Text {
            id: calibrationText
            text : "No data"
            font.family: theme.listTextFont
            font.pixelSize: theme.listTextFontSize            
            font.bold: true;
            color: theme.listTextColor
        }
    }

    Text {
        anchors.centerIn: parent
        width: parent.width * 0.9
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter

        text : "Please calibrate you compass first!"

        font.pixelSize: 48
        font.bold: true;
        color: "red"
        visible: page.calibration < 70
    }



    Connections {
        id: reader
        target: sensor

        onDataUpdated: {
            var degrees = sensor.getSensorDataValue(0);
            var calibration = Math.round( 100 * sensor.getSensorDataValue(1));

            compassPoint.rotation = 360 - degrees;

            degreeText.text = "Azimuth " + degrees
            calibrationText.text = "Calibration level " + calibration + " %"

            // set page global properties
            page.degress = degress
            page.calibration = calibration
        }
    }

    function getCompassSize(w, h)
    {
        var max = Math.min(w, h);
        var want = 1600;
        if(max > 0) while(max < want) want /= 2;
        return want;
    }

}
