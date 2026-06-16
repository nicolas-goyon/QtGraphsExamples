#pragma once
#include <QObject>
#include <QVariantList>
#include <QtQml/qqmlregistration.h>

// Provides the initial monthly sales data for the table/chart example.
// Returns a QVariantList of QVariantMap entries, each with:
//   "month" : QString  (e.g. "Jan")
//   "value" : double   (units sold)
// The QML layer loads this once into a ListModel; the table edits the
// ListModel and the chart updates via XYSeries::replace().
class LineChartTableDataProvider : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit LineChartTableDataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList initialData() const;
};
