#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Provides annual revenue-growth (%) data for five tech companies (2019–2023).
// Each series returns a list of QVariantMap { "x": year-index, "y": growthPct }.
class LineChartLegendDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit LineChartLegendDataProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList appleData()     const;
    Q_INVOKABLE QVariantList googleData()    const;
    Q_INVOKABLE QVariantList microsoftData() const;
    Q_INVOKABLE QVariantList amazonData()    const;
    Q_INVOKABLE QVariantList metaData()      const;

private:
    static QVariantList makePoints(std::initializer_list<double> ys);
};
