#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class ScatterChartCustomMarkersDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit ScatterChartCustomMarkersDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList blogData()   const;
    Q_INVOKABLE QVariantList socialData() const;
    Q_INVOKABLE QVariantList emailData()  const;
private:
    static QVariantList pts(std::initializer_list<std::pair<double,double>>);
};
