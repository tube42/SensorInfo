#ifndef SENSORWRAPPER_H
#define SENSORWRAPPER_H

#include <QObject>
#include <QVariant>

// forward reference
namespace QtMobility {
    class QSensor;
}

class SensorInformation;

class SensorWrapper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int sensorListCount READ getSensorListCount);
    Q_PROPERTY(QString name READ getName NOTIFY nameChanged)
    Q_PROPERTY(QString id READ getId NOTIFY idChanged)
    Q_PROPERTY(QString error READ getSensorError)


public:
    explicit SensorWrapper(QObject *parent = 0);

    ~SensorWrapper();

public:
    // sensor list
    Q_INVOKABLE QString getSensorListName(int index) const;
    Q_INVOKABLE QString getSensorListIdentifier(int index) const;
    Q_INVOKABLE QString getSensorListDescription(int index) const;
    Q_INVOKABLE QString getSensorListSignature(int index) const;
    int getSensorListCount() const;


    // open sensor  + start/stop
    Q_INVOKABLE void createSensor(int index);
    Q_INVOKABLE void startSensor();
    Q_INVOKABLE void stopSensor();
    Q_INVOKABLE void deleteSensor();
    Q_INVOKABLE int getSensor() const;


    // -----------------------------------------
    // these are only valid for opened sensors (See above)
    // Sensor metadata
    Q_INVOKABLE int getSensorRangeCount() const;
    Q_INVOKABLE qreal getSensorRangeMinimum(int which);
    Q_INVOKABLE qreal getSensorRangeMaximum(int which);
    Q_INVOKABLE qreal getSensorRangeAccuracy(int which);

    Q_INVOKABLE int getSensorRateCount() const;
    Q_INVOKABLE qreal getSensorRateMinimum(int which);
    Q_INVOKABLE qreal getSensorRateMaximum(int which);

    Q_INVOKABLE int getSensorDataCount() const;
    Q_INVOKABLE QString getSensorDataType(int which);
    Q_INVOKABLE QString getSensorDataName(int which);
    Q_INVOKABLE QVariant getSensorDataValue(int which);


    QString getName() const;
    QString getId() const;
    QString getSensorError() const;

signals:
    void dataUpdated();
    void nameChanged();
    void idChanged();

public slots:
    void checkReading();

private:
    int index;
    QString error;
    QList<SensorInformation *>sensors;

    SensorInformation *current_sensor_information;
    QtMobility:: QSensor *current_sensor;
};

#endif // SENSORWRAPPER_H
