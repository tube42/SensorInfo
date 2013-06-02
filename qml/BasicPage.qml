
import QtQuick 1.1
import com.nokia.meego 1.0


Page {
    id: container

    property bool hasBack: true
    property bool hasForward: false
    property bool hasUpdate: false

    property string title: ""
    property Item canvas : usercanvas

    signal leavingPage
    signal requestForward
    signal requestUpdate

    anchors.margins: 0
    orientationLock: PageOrientation.LockPortrait

    tools: ToolBarLayout {
        id: listpagetoolbar        
        ToolIcon {
            visible: hasBack
            iconId: "toolbar-back";
            onClicked: { leavingPage(); pageStack.pop(); }
        }
        // this is here so back is never to right?
        TabButton { }

        ToolIcon {
            visible: hasUpdate
            iconId: "toolbar-refresh";
            onClicked: requestUpdate();
        }

        ToolIcon {
            visible: hasForward
            iconId: "toolbar-next";
            onClicked: requestForward();
        }

    }


    // place holder for user lists
    Item {
        id: usercanvas
        anchors.margins: theme.defaultMargin
        anchors.left:  parent.left
        anchors.right:  parent.right
        anchors.top:  titleTextBackground.bottom
        anchors.bottom:  parent.bottom
    }

    // top label
    Rectangle {
        id: titleTextBackground
        z: 1        
        width: parent.width
        height : theme.pageTitleAreaHeight
        anchors.top: parent.top
        color: theme.pageTitleAreaColor

        Label {
            id: titletext

            anchors.verticalCenter: parent.verticalCenter
            x: 2 * theme.defaultMargin

            text: container.title
            font.family: theme.pageTitleFont
            font.pixelSize: theme.pageTitleFontSize
            color: theme.pageTitleColor
        }
    }

}


