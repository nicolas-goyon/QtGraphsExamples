#include "tabs/3d/Surface3DTab.h"
#include "examples/3D/Surface/BasicSurface3D/BasicSurface3DExample.h"
#include "examples/3D/Surface/BasicSurface3D/BasicSurface3DDescription.h"

Surface3DTab::Surface3DTab(QWidget *parent)
    : ExampleTab(parent)
{
    addExample({
        "Basic Surface 3D",
        [](QWidget *p) { return new BasicSurface3DExample(p); },
        BasicSurface3DDescription::text(),
        BasicSurface3DDescription::files()
    });
}
