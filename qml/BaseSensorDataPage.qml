import QtQuick 1.0

import SensorInfo 1.0

import "Logic.js" as Logic

BasicPage  {
    id: page

    // hook on exit messages, for normal operation and force quit from system
    onLeavingPage: Logic.stopSensor();
    Component.onDestruction: Logic.stopSensor();

}
