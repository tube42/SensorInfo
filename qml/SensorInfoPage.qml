import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Logic.js" as Logic


BasicPage  {
    id: page
    title: "";
    hasForward: true    

    onLeavingPage: Logic.deleteSensor();
    onRequestForward: if(sensor.error == "") Logic.openSensorDataPage();


    ListModel { id: data }

    ListView {
        id: listView
        anchors.fill: parent.canvas
        anchors.topMargin: theme.defaultMargin
        model: data
        delegate: DataItemDelegate { }

        section.property: "type"
        section.criteria: ViewSection.FullString
        section.delegate: sectionDelegate
    }

    ScrollDecorator {
        flickableItem: listView
    }

    // --------------------------------------
    // section header
    Component {
        id: sectionDelegate
        Item {
            height: theme.sectionFontSize + 3 * theme.defaultMargin
            width: parent.width

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: theme.defaultMargin
                anchors.bottomMargin: theme.defaultMargin

                color: theme.sectionAreaColor

                Text {
                    anchors.centerIn:  parent
                    font.family: theme.sectionFontFamily
                    font.pixelSize: theme.sectionFontSize
                    font.bold: true
                    color: theme.sectionFontColor
                    text: section
                }
            }
        }
    }

    // --------------------------------------

    function initPage()
    {
        data.clear();

        var entry = Logic.getSensorEntry();
        var index = Logic.getSensorIndex();

        if(entry == null) {
            title = "Error"
            return;
        }

        title = sensor.getSensorListName(index);

        data.append({type: "Sensor", text : "Identifier", desc : sensor.getSensorListIdentifier(index)} );
        data.append({type: "Sensor", text : "Signature", desc :sensor.getSensorListSignature(index) } );

        // data data
        for(var i = 0; i < sensor.getSensorDataCount(); i++ ) {
            data.append({ type : "Data",
                            text : "" + entry.data_names[i],
                            desc : "Type " + sensor.getSensorDataType(i)});
        }

        // add data rates
        var data_rates = "";
        for(var i = 0; i < sensor.getSensorRateCount(); i++ ) {
            var min = sensor.getSensorRateMinimum(i);
            var max = sensor.getSensorRateMaximum(i);

            // var text = "Data rate #" + (i + 1);
            var desc = (min == max) ? ("" + min) : ("" + min + " - " + max);

            if(i != 0) data_rates += ", ";
            data_rates += desc;
        }
        if(data_rates == "") data_rates = "Undefined";
        else data_rates += " Hz";

        data.append({type: "Configuration", text : "Available data rates", desc : data_rates, } );


        // add data ranges
        for(var i = 0; i < sensor.getSensorRangeCount(); i++ ) {
            var min = sensor.getSensorRangeMinimum(i);
            var max = sensor.getSensorRangeMaximum(i);
            var acc = sensor.getSensorRangeAccuracy( i);

            var text = "Range #" + (i + 1);
            var desc = "" + min + " - " + max;
            if(acc < 0.3) desc += " at 1/" + Math.round(1/acc) + " steps";
            else if(acc != 1) desc += " at " + acc + " steps";
            data.append({type: "Configuration", text : text, desc : desc } );
        }

    }
}
