
import QtQuick 1.0

Rectangle {
    property alias text : xm.text
    property bool show: false
    property alias font_size: xm.font.pixelSize

    width: 80
    height: 80
    color: "gray"


    Text {
        id: xm;
        anchors.centerIn: parent
        font.pixelSize: 64
        text:  parent.text
        visible: parent.show
    }
}

