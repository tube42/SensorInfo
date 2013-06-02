#include <QtGui/QApplication>
#include <QtDeclarative>


#include "sensorwrapper.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{       
    QApplication app(argc, argv);
    QDeclarativeView view;

    qmlRegisterType<SensorWrapper>("SensorInfo", 1, 0, "SensorWrapper");
    // qmlRegisterType<SensorHelper>("SensorInfo", 1, 0, "SensorHelper");

    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.showFullScreen();
    return app.exec();
}
