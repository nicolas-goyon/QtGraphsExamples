#include "tabs/2d/BarChartTab.h"
#include "examples/2D/Bar/BasicBar/BasicBarExample.h"
#include "examples/2D/Bar/BasicBar/BasicBarDescription.h"

BarChartTab::BarChartTab(QWidget *parent)
    : ExampleTab(parent)
{
    addExample({
        "Basic Bar",
        [](QWidget *p) { return new BasicBarExample(p); },
        BasicBarDescription::text(),
        BasicBarDescription::files()
    });
}
