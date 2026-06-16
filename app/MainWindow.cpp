#include "MainWindow.h"

#include <QTabWidget>
#include <QVBoxLayout>
#include <QWidget>

#include "pages/Page2D.h"
#include "pages/Page3D.h"

MainWindow::MainWindow(QWidget *parent)
    : DemoWindow("Qt Graphs Examples", 1280, 800, parent)
    , m_pages(new QTabWidget(this))
{
    m_pages->addTab(new Page2D(this), "2D Charts");
    m_pages->addTab(new Page3D(this), "3D Graphs");

    setCentralWidget(m_pages);
}
