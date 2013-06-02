
import QtQuick 1.1
import com.nokia.meego 1.0

BasicPage {
    id: container
    signal itemSelected(int index, variant entry);

    ListModel { id: data }

    ListView {
        id: listView
        anchors.fill: parent.canvas
        anchors.topMargin: theme.defaultMargin
        model: data
        pressDelay: 140

        delegate:  Item {
            id: listItem
            height: 1.3 * (5 + theme.listTextFontSize + (1 + 2) * theme.listDescriptionFontSize)
            width: parent.width

            BorderImage {
                id: background
                anchors.fill: parent
                // Fill page porders
                anchors.leftMargin: -container.anchors.leftMargin
                anchors.rightMargin: -container.anchors.rightMargin
                visible: mouseArea.pressed
                source: theme.listItemBorderImage
            }

            Column {
                id: col
                width: parent.width
                anchors.centerIn: parent

                Label {
                    id: mainText
                    text: model.name
                    font.family: theme.listTextFont
                    font.pixelSize: theme.listTextFontSize
                    color: theme.listTextColor
                    font.bold: true;
                }

                Label {
                    id: subText1
                    text: model.identifier
                    font.family: theme.listDescriptionFont
                    font.pixelSize: theme.listDescriptionFontSize
                    font.italic: true
                    // color: theme.listDescriptionColor
                    color: "gray"
                }

                Label {
                    id: subText2
                    text: model.description
                    font.family: theme.listDescriptionFont
                    font.pixelSize: theme.listDescriptionFontSize
                    color: theme.listDescriptionColor
                    visible: text != ""

                    width: parent.width
                    elide: Text.ElideLeft
                    maximumLineCount: 2
                    wrapMode: Text.Wrap
                }
            }

            Image {
                source: theme.listImageArrow
                anchors.right: parent.right
                anchors.rightMargin: - theme.defaultMargin / 2
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                id: mouseArea
                anchors.fill: background
                onClicked: itemSelected( model.index, model.entry);
            }
        }
    }

    ScrollDecorator {
        flickableItem: listView
    }

    function clear()
    {
        data.clear();
    }

    function append(stuff)
    {
        data.append(stuff);
    }
}

