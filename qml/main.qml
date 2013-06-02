import QtQuick 1.1
import com.nokia.meego 1.0
import SensorInfo 1.0
import "Logic.js" as Logic

PageStackWindow {
    id: appWindow
    initialPage: mainPage;

    UserTheme { id: theme }

    SensorWrapper { id: sensor }

    Item {
        id: userData
        property variant sensor_database
    }

    // pre-loaded pages
    SensorList { id: sensorList }
    SensorInfoPage { id: infoPage }

    MainPage {
        id: mainPage
        onButtonShow: pageStack.push(sensorList)
        onButtonAbout: Logic.pushPageFromFile("About.qml")
    }
}
