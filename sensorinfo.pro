# Add more folders to ship with the application, here

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

QT+= declarative
symbian:TARGET.UID3 = 0xE6B37CB0

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
symbian:TARGET.CAPABILITY += NetworkServices

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += sensors

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += \
    cpp/sensorwrapper.cpp \
    cpp/main.cpp


OTHER_FILES += \
    qml/main.qml \
    sensorinfo.desktop \
    sensorinfo.svg \
    sensorinfo.png \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qml/SensorList.qml \
    qml/main.qml \
    qml/Logic.js \
    qml/Constants.js \
    qml/BasicPage.qml \
    qml/BasicListPage.qml \
    qml/SensorInfoPage.qml \
    qml/DataItemDelegate.qml \
    qml/SensorGenericPage.qml \
    qml/SensorOrientationPage.qml \
    qml/SensorAmbientLightPage.qml \
    qml/SensorTapPage.qml \
    qml/TextBox.qml \
    qml/SensorGruePage.qml \
    qml/BaseSensorDataPage.qml \
    qml/harmattan/UserTheme.qml \
    qml/SensorCompassPage.qml \
    qml/About.qml \
    qml/MainPage.qml

RESOURCES += \
    res.qrc

# Please do not modify the following two lines. Required for deployment.
include(deployment.pri)
qtcAddDeployment()

# enable booster
CONFIG += qdeclarative-boostable
QMAKE_CXXFLAGS += -fPIC -fvisibility=hidden -fvisibility-inlines-hidden
QMAKE_LFLAGS += -pie -rdynamic

HEADERS += \
    cpp/sensorwrapper.h


splash.path = /opt/sensorinfo
splash.files = images/splash.png
INSTALLS += splash

