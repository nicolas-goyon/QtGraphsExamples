#include "tabs/3d/Scatter3DTab.h"
#include "examples/3D/Scatter/BasicScatter3D/BasicScatter3DExample.h"
#include "examples/3D/Scatter/BasicScatter3D/BasicScatter3DDescription.h"

Scatter3DTab::Scatter3DTab(QWidget *parent)
    : ExampleTab(parent)
{
    addExample({
        "Basic Scatter 3D",
        [](QWidget *p) { return new BasicScatter3DExample(p); },
        BasicScatter3DDescription::text(),
        BasicScatter3DDescription::files()
    });
}
