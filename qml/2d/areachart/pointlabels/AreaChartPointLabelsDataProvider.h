#pragma once

#include <QObject>
#include <QVariantList>
#include <QtQml/qqml.h>

class AreaChartPointLabelsDataProvider : public QObject
{
    Q_OBJECT
    QML_ELEMENT

public:
    explicit AreaChartPointLabelsDataProvider(QObject *parent = nullptr);

    // Monthly Recurring Revenue (MRR) for 6 months — raw dollar values
    Q_INVOKABLE QVariantList mrrData() const;

    // Human-readable month labels matching mrrData() by index
    Q_INVOKABLE QVariantList monthLabels() const;
};
