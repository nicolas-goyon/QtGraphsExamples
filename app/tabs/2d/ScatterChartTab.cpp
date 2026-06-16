#include "tabs/2d/ScatterChartTab.h"
#include "examples/2D/Scatter/BasicScatter/BasicScatterExample.h"
#include "examples/2D/Scatter/BasicScatter/BasicScatterDescription.h"

ScatterChartTab::ScatterChartTab(QWidget *parent)
    : ExampleTab(parent)
{
    addExample({
        "Basic Scatter",
        [](QWidget *p) { return new BasicScatterExample(p); },
        BasicScatterDescription::text(),
        BasicScatterDescription::files()
    });
}
