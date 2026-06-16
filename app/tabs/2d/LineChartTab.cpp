#include "tabs/2d/LineChartTab.h"
#include "examples/2D/Line/BasicLine/BasicLineExample.h"
#include "examples/2D/Line/BasicLine/BasicLineDescription.h"

LineChartTab::LineChartTab(QWidget *parent)
    : ExampleTab(parent)
{
    addExample({
        "Basic Line",
        [](QWidget *p) { return new BasicLineExample(p); },
        BasicLineDescription::text(),
        BasicLineDescription::files()
    });
}
