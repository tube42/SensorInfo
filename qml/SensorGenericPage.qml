import QtQuick 1.0
import com.nokia.meego 1.0

import SensorInfo 1.0

import "Logic.js" as Logic

BaseSensorDataPage  {
    id: page
    title: "";

    
    ListModel { id: data }
    
    ListView {
        id: listView
        anchors.fill: parent.canvas
        anchors.topMargin: theme.defaultMargin
        model: data
        delegate: DataItemDelegate { }
    }
    
    ScrollDecorator {
        flickableItem: listView
    }
    
    
    Connections {
        target: sensor
        onDataUpdated: {            

            var count = Math.min(sensor.getSensorDataCount(), data.count ); // to avoid followup errors
            for(var i = 0; i < count; i++ )
                data.get(i).desc = sensor.getSensorDataValue(i);
        }        
    }
    
    // -------------------------------------
    Component.onCompleted: update();

    function update()
    {
        data.clear();

        var entry = Logic.getSensorEntry();
        var index = Logic.getSensorIndex();

        if(sensor.error != "" || entry == null) {
            data.append({"text" : "ERROR!", "desc" : "" + sensor.error } );
        } else {

            title = sensor.getSensorListName(index);

            for(var i = 0; i < sensor.getSensorDataCount(); i++ ) {
                data.append({ "text" : "" + entry.data_names[i], 
                            "desc" : sensor.getSensorDataValue(i)
                            } );
            }
        }
    }
}
