#pragma once
#include <QObject>
#include <QStringList>
#include <QVariantList>
#include <QtQml/qqml.h>

class PopulationPyramidDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit PopulationPyramidDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QStringList  ageGroups()   const;
    Q_INVOKABLE QVariantList womenValues() const;  // NEGATIVE values (extend left)
    Q_INVOKABLE QVariantList menValues()   const;  // POSITIVE values (extend right)
};
