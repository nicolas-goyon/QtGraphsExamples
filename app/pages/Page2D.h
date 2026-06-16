#pragma once

#include <QWidget>

class QTabWidget;

// ---------------------------------------------------------------------------
// Page2D
// Container for all 2D chart tabs.
// Tabs: Line Chart | Bar Chart | Scatter Chart
// ---------------------------------------------------------------------------
class Page2D : public QWidget
{
    Q_OBJECT

public:
    explicit Page2D(QWidget *parent = nullptr);

private:
    QTabWidget *m_tabs;
};
