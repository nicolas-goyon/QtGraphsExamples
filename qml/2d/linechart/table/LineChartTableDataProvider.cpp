#include "LineChartTableDataProvider.h"
#include <QVariantMap>

LineChartTableDataProvider::LineChartTableDataProvider(QObject *parent)
    : QObject(parent) {}

QVariantList LineChartTableDataProvider::initialData() const
{
    // Monthly unit sales — illustrative figures.
    static const struct { const char *month; double value; } rows[] = {
        {"Jan", 120}, {"Feb", 145}, {"Mar",  98},
        {"Apr", 210}, {"May", 285}, {"Jun", 340},
        {"Jul", 390}, {"Aug", 375}, {"Sep", 290},
        {"Oct", 220}, {"Nov", 180}, {"Dec", 155}
    };

    QVariantList list;
    for (const auto &r : rows) {
        QVariantMap m;
        m["month"] = QString::fromLatin1(r.month);
        m["value"] = r.value;
        list.append(m);
    }
    return list;
}
