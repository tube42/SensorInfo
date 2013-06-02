#include <QDebug>
#include <QSensor>
#include <QSensorReading>

// #include <QMetaObject>
// #include <QMetaProperty>

#include "sensorwrapper.h"


using namespace QtMobility;


// ---------------------------------------
// dummy data when none is available:
static QVariant null_variant(0);
static QString null_string("");
static qreal null_qreal = -1;


// safe list access
// yes, these are here to make the code even less readable ;)

#define GET_CURR_LIST_LENGTH(list) \
    (current_sensor_information ? current_sensor_information->list.length() : 0)

#define GET_CURR_LIST_MEMBER(list, index, member, default_) \
    ((index < 0 || index >= GET_CURR_LIST_LENGTH(list)) ? default_ :  \
        current_sensor_information->list[index].member)

#define GET_CURR_LIST_ENTRY(list, index, default_) \
    ((index < 0 || index >= GET_CURR_LIST_LENGTH(list)) ? default_ :  \
        current_sensor_information->list[index])


// ---------------------------------------


class SensorInformation
{
public:
    QString name, identifier, description;
    QList<qrange> list_datarates;
    QList<qoutputrange> list_output_range;

    QList<QString> list_data_types, list_data_names;
    QList<QVariant> list_data_values;
    QString signature;
    SensorWrapper *parent;

    SensorInformation(SensorWrapper *parent, QString name, QString id, QString desc)
    {
        this->name = name;
        this->identifier = id;
        this->description = desc;
        this->parent = parent;
        examine();
    }
private:
    void examine()
    {
        QByteArray ba_type, ba_identifier;
        ba_type.append(name);
        ba_identifier.append(identifier);

        // get the sensor
        QSensor sensor(ba_type, parent);
        if(ba_identifier.length() > 0) sensor.setIdentifier(ba_identifier);
        // QObject :: connect(sensor, SIGNAL(readingChanged()), parent, SLOT(checkReading()));

        if(sensor.connectToBackend() ) {
            list_datarates = sensor.availableDataRates();
            list_output_range = sensor.outputRanges ();


            list_data_types.clear();
            list_data_names.clear();
            list_data_values.clear();

            QSensorReading *reading = sensor.reading();
            if(reading) {
                for(int i = 0; i < reading->valueCount(); i++) {
                    // stupid name until we replace them with something better
                    QString name = QString("#%1").arg(i + 1);
                    list_data_names.append(name);
                    list_data_types.append(QString(reading->value(i).typeName()));
                    list_data_values.append(reading->value(i));
                }

                // sensor signature;
                signature = identifier + "$$";
                for(int i = 0; i < reading->valueCount(); i++) {
                    if(i != 0) signature.append(".");
                     signature.append(list_data_types[i]);
                }
            }
        }
    }

};

// ---------------------------------------
SensorWrapper::SensorWrapper(QObject *parent) :
    QObject(parent) , current_sensor(0), current_sensor_information(0), index(-1)
{
    qDebug() << "sensor wrapper created" << endl;


    // get list of sensors:
    foreach (const QByteArray &type, QSensor::sensorTypes()) {
        foreach (const QByteArray &identifier, QSensor::sensorsForType(type)) {
            QtMobility :: QSensor sensor(type);
            sensor.setIdentifier(identifier);
            if (!sensor.connectToBackend()) {
                qDebug() << "Couldn't connect to" << identifier;
                continue;
            }


            QString name = QString(type);
            QString iden = QString(identifier);
            QString desc = QString(sensor.description() );
            if(desc == "") desc = "No description found";

            struct SensorInformation *si = new SensorInformation(this, name, iden, desc);
            sensors.append(si);

        }
    }
}



SensorWrapper::~SensorWrapper()
{
    deleteSensor();

    for(int i = 0; i < sensors.length(); i++)
        delete sensors[i];

    qDebug() << "SensorWrapper destructer called" << endl;
}

int SensorWrapper::getSensor() const
{
    return index;
}

void SensorWrapper::createSensor(int index)
{
    deleteSensor();
    try {
        if(index < 0 || index >= getSensorListCount()) {
            error = "bad sensor selected";
            return;
        }
        this->index = index;
        current_sensor_information = sensors[index];
        emit nameChanged();
        emit idChanged();
    } catch(...) {
        // shit happens....
    }
}


void SensorWrapper::deleteSensor()
{
    stopSensor();

    if(current_sensor) {       
        delete current_sensor;
        current_sensor = 0;
        current_sensor_information = 0;
        index = -1;

        emit nameChanged();
        emit idChanged();
    }
}


void SensorWrapper::startSensor()
{
    if(!current_sensor) {
        // 1. open it
        QByteArray ba_type, ba_identifier;
        ba_type.append(current_sensor_information->name);
        ba_identifier.append(current_sensor_information->identifier);

        current_sensor = new QSensor(ba_type, this);
        if(!current_sensor) {
            error = "Unable to allocate sensor";
            return;
        }

        if(ba_identifier.length() > 0) current_sensor->setIdentifier(ba_identifier);

        if(current_sensor->connectToBackend() ) {
            QObject :: connect(current_sensor, SIGNAL(readingChanged()), this, SLOT(checkReading()));
        } else {
            error = "could not connect to sensor backend";
            return;
        }
    }


    // 2. start it
    for(int i = 0; i < 10; i++) {
        current_sensor->start();
        if(!current_sensor->isBusy()) break;
    }

    if(current_sensor->isActive()) {
        qDebug() << "Sensor started without errors";
        return;
    } else error = "Could not start sensor";
}


void SensorWrapper::stopSensor()
{
    if(current_sensor) current_sensor->stop();
}

// -----------------------------------------------------


// sensor list
QString SensorWrapper::getSensorListName(int index) const
{
    if(index < 0 || index >= getSensorListCount()) return null_string;
    return sensors[index]->name;
}
QString SensorWrapper::getSensorListIdentifier(int index) const
{
    if(index < 0 || index >= getSensorListCount()) return null_string;
    return sensors[index]->identifier;
}
QString SensorWrapper::getSensorListDescription(int index) const
{
    if(index < 0 || index >= getSensorListCount()) return null_string;
    return sensors[index]->description;
}
QString SensorWrapper::getSensorListSignature(int index) const
{
    if(index < 0 || index >= getSensorListCount()) return null_string;
    return sensors[index]->signature;
}

int SensorWrapper::getSensorListCount() const
{
    return sensors.length();
}

// -----------------------------------------------------


int SensorWrapper::getSensorRangeCount() const
{
    return GET_CURR_LIST_LENGTH(list_output_range);
}
qreal SensorWrapper::getSensorRangeMinimum(int index)
{
    return GET_CURR_LIST_MEMBER(list_output_range, index, minimum, null_qreal);
}

qreal SensorWrapper::getSensorRangeMaximum(int index)
{
    return GET_CURR_LIST_MEMBER(list_output_range, index, maximum, null_qreal);
}

qreal SensorWrapper::getSensorRangeAccuracy(int index)
{
    return GET_CURR_LIST_MEMBER(list_output_range, index, accuracy, null_qreal);
}

// --

int SensorWrapper::getSensorRateCount() const
{
    return GET_CURR_LIST_LENGTH(list_datarates);
}

qreal SensorWrapper::getSensorRateMinimum(int index)
{
    return GET_CURR_LIST_MEMBER(list_datarates, index, first, 0);
}

qreal SensorWrapper::getSensorRateMaximum(int index)
{
    return GET_CURR_LIST_MEMBER(list_datarates, index, second, 0);
}


// -----------------------------------------------------

int SensorWrapper::getSensorDataCount() const
{
    return GET_CURR_LIST_LENGTH(list_data_types);
}


QString SensorWrapper::getSensorDataName(int index)
{
    return GET_CURR_LIST_ENTRY(list_data_names, index, null_string);
}
QString SensorWrapper::getSensorDataType(int index)
{
    return GET_CURR_LIST_ENTRY(list_data_types, index, null_string);
}


// this one is for the current (opened) sensor only
QVariant SensorWrapper::getSensorDataValue(int which)
{
    int size = current_sensor_information->list_data_values.length();

    if(which < 0 || which >= size) return null_variant;
    return current_sensor_information->list_data_values[which];
}


// -----------------------------------------------------

QString SensorWrapper::getName() const
{
    return current_sensor_information ? current_sensor_information->name: "";
}


QString SensorWrapper::getId() const
{
    return current_sensor_information ? current_sensor_information->identifier : "";
}

QString SensorWrapper :: getSensorError() const
{
    return error;
}


void SensorWrapper :: checkReading()
{
    SensorInformation *info = this->current_sensor_information;
    if(!info) return;

    QSensor *sensor = this->current_sensor;
    if(!sensor) return;


    QSensorReading *reading = sensor->reading();
    if(reading == 0) return;


    for(int i = 0; i < reading->valueCount(); i++)
        info->list_data_values[i] = reading->value(i);


    emit dataUpdated();
}


