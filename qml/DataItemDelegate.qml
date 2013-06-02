import QtQuick 1.1
import com.nokia.meego 1.0


Item {
    id: listItem
    height: 88
    width: parent.width

    Column {
        // anchors.fill: parent
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        Label {
            id: mainText
            text: model.text
            font.family: theme.listTextFont
            font.pixelSize: theme.listTextFontSize
            color: theme.listTextColor
            font.bold: true;
        }

        Label {
            id: subText
            text: model.desc
            font.family: theme.listDescriptionFont
            font.pixelSize: theme.listDescriptionFontSize
            color: theme.listDescriptionColor
            visible: text != ""

            width: parent.width
            elide: Text.ElideLeft
            maximumLineCount: 4
            wrapMode: Text.Wrap
        }
    }

}
