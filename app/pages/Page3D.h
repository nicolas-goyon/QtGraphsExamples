#pragma once

#include <QWidget>

class QTabWidget;

// ---------------------------------------------------------------------------
// Page3D
// Container for all 3D graph tabs.
// Tabs: Bars 3D | Scatter 3D | Surface 3D
// ---------------------------------------------------------------------------
class Page3D : public QWidget
{
    Q_OBJECT

public:
    explicit Page3D(QWidget *parent = nullptr);

private:
    QTabWidget *m_tabs;
};
