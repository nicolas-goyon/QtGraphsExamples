#pragma once

#include <QWidget>

// ---------------------------------------------------------------------------
// BasicScatterExample
// A minimal multi-series scatter chart using Qt Graphs 2D.
//
// Self-contained: no dependency on other files in this project.
// Copy this folder into your project and add the .cpp to your CMake target.
// ---------------------------------------------------------------------------
class BasicScatterExample : public QWidget
{
    Q_OBJECT

public:
    explicit BasicScatterExample(QWidget *parent = nullptr);
};
