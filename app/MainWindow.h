#pragma once

#include "DemoWindow.h"

class QTabWidget;

// ---------------------------------------------------------------------------
// MainWindow
// Top-level window with two pages: "2D Charts" and "3D Graphs".
// ---------------------------------------------------------------------------
class MainWindow : public DemoWindow
{
public:
    explicit MainWindow(QWidget *parent = nullptr);

private:
    QTabWidget *m_pages;
};
