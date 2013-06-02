
import QtQuick 1.1
import com.nokia.meego 1.0
/*
BasicPage {
    id: page
    title: "Sensor Info"

    hasBack: false
    hasForward: false
    hasUpdate: false

    signal buttonShow();
    signal buttonAbout();

    property int logosize: Math.min(canvas.width, canvas.height) / 2

    Column {
        anchors.centerIn: parent.canvas

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            id: image1
            source: "/images/sensorinfo_big.png"
            smooth: true
            width: logosize
            height: logosize

        }
        Rectangle { width: 1; height:  image1.height / 4 } // Space

        Button {
            text: "Show sensors"
            onClicked: buttonShow();
        }

        Button {
            text: "About this app"
            onClicked: buttonAbout();
        }
    }


}


*/


BasicListPage {
    id: page
    title: "Sensor Info"

    hasBack: false
    hasForward: false
    hasUpdate: false

    signal buttonShow();
    signal buttonAbout();

    onItemSelected: {
        if(index == 0) buttonShow();
        if(index == 1) buttonAbout();
    }
    Component.onCompleted: {

        append( { name : "Show sensors", identifier : "", description : "Show list of available sensors", index : 0 } );
        append( { name : "About", identifier : "", description : "About this app", index : 1 } );
        /*
            "name" : sensor.getSensorListName(i),
            "identifier": sensor.getSensorListIdentifier(i),
            "description": sensor.getSensorListDescription(i),
            "icon" : entry.icon,
//                "entry" : entry,
            "index" : i });
            */
    }
}
