#include "pages/Page2D.h"

#include <QTabWidget>
#include <QVBoxLayout>

#include "tabs/2d/LineChartTab.h"
#include "tabs/2d/BarChartTab.h"
#include "tabs/2d/ScatterChartTab.h"

Page2D::Page2D(QWidget *parent)
    : QWidget(parent)
    , m_tabs(new QTabWidget(this))
{
    m_tabs->addTab(new LineChartTab(this),    "Line Chart");
    m_tabs->addTab(new BarChartTab(this),     "Bar Chart");
    m_tabs->addTab(new ScatterChartTab(this), "Scatter Chart");

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(0, 0, 0, 0);
    layout->addWidget(m_tabs);
}
