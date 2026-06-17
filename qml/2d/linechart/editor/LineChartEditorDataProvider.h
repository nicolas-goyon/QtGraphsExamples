#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Monthly average temperature data (°C) for three European cities.
// Independent copy for the Live Editor example — no cross-example dependency.
class LineChartEditorDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LineChartEditorDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList londonData()   const;
    Q_INVOKABLE QVariantList madridData()   const;
    Q_INVOKABLE QVariantList helsinkiData() const;

private:
    static QVariantList makePoints(std::initializer_list<std::pair<double, double>> pts);
};
