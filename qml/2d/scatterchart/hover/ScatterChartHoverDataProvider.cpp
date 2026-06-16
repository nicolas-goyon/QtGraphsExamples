#include "ScatterChartHoverDataProvider.h"
#include <QVariantMap>
ScatterChartHoverDataProvider::ScatterChartHoverDataProvider(QObject *parent) : QObject(parent) {}
QVariantMap ScatterChartHoverDataProvider::proc(double cpu, double mem, const QString &name) {
    QVariantMap m; m["cpu"]=cpu; m["mem"]=mem; m["name"]=name; return m;
}
QVariantList ScatterChartHoverDataProvider::processData() const {
    return {
        proc(2.1, 120, "browser"),    proc(8.5, 850, "IDE"),
        proc(0.5, 45,  "terminal"),   proc(15.2,1200,"compiler"),
        proc(3.8, 320, "server"),     proc(1.2, 80,  "editor"),
        proc(22.0,2400,"game"),       proc(0.3, 30,  "clock"),
        proc(6.4, 560, "database"),   proc(11.5,980, "renderer"),
        proc(4.2, 410, "downloader"), proc(0.8, 65,  "daemon"),
    };
}
