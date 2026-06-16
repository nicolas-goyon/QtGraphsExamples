#include <QApplication>
#include "MainWindow.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setApplicationName("Qt Graphs Examples");
    app.setOrganizationName("QtGraphsExamples");

    MainWindow w;
    w.show();
    return app.exec();
}
