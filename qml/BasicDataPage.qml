
import QtQuick 1.1
import com.meego 1.0

import "Constants.js" as Constants

BasicPage {
    id: container

    ListModel { id: data }

    ListView {
        id: listView
        anchors.fill: parent.canvas
        anchors.topMargin: Constants.DEFAULT_MARGIN
        model: data
        delegate: DataItemDelegate { }
    }

    ScrollDecorator {
        flickableItem: listView
    }

    function clear()
    {
        data.clear();
    }

    function append(text, desc)
    {
        if(text == null) text = "";
        if(desc == null) desc = "";

        data.append({"text" : text, "desc" : desc } );
    }
}

