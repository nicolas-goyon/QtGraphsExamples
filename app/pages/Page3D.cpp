#include "pages/Page3D.h"

#include <QTabWidget>
#include <QVBoxLayout>

#include "tabs/3d/Bars3DTab.h"
#include "tabs/3d/Scatter3DTab.h"
#include "tabs/3d/Surface3DTab.h"

Page3D::Page3D(QWidget *parent)
    : QWidget(parent)
    , m_tabs(new QTabWidget(this))
{
    m_tabs->addTab(new Bars3DTab(this),    "Bars 3D");
    m_tabs->addTab(new Scatter3DTab(this), "Scatter 3D");
    m_tabs->addTab(new Surface3DTab(this), "Surface 3D");

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(m_tabs);
}
