#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class PieChartBasicDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit PieChartBasicDataProvider(QObject *parent = nullptr);
    // Returns list of QVariantMaps with "label", "value", and "color" keys
    Q_INVOKABLE QVariantList slices() const;
};
