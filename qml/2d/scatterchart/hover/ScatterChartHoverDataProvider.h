#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class ScatterChartHoverDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScatterChartHoverDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList processData() const;  // {cpu, mem, name}
private:
    static QVariantMap proc(double cpu, double mem, const QString &name);
};
