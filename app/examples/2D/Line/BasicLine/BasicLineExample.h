#pragma once

#include <QWidget>

// ---------------------------------------------------------------------------
// BasicLineExample
// A minimal multi-series line chart using Qt Graphs 2D.
//
// Self-contained: no dependency on other files in this project.
// Copy this folder into your project and add the .cpp to your CMake target.
// ---------------------------------------------------------------------------
class BasicLineExample : public QWidget
{
    Q_OBJECT

public:
    explicit BasicLineExample(QWidget *parent = nullptr);
};
