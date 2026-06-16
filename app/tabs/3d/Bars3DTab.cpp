#include "tabs/3d/Bars3DTab.h"
#include "../../examples/3D/Bars/BasicBars3D/BasicBars3DExample.h"
#include "../../examples/3D/Bars/BasicBars3D/BasicBars3DDescription.h"

Bars3DTab::Bars3DTab(QWidget *parent)
    : ExampleTab(parent)
{
    addExample({
        "Basic Bars 3D",
        [](QWidget *p) { return new BasicBars3DExample(p); },
        BasicBars3DDescription::text(),
        BasicBars3DDescription::files()
    });
}
