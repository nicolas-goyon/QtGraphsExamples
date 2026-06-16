#pragma once

#include <QWidget>

// ---------------------------------------------------------------------------
// BasicBarExample
// A minimal clustered bar chart using Qt Graphs 2D.
//
// Self-contained: no dependency on other files in this project.
// Copy this folder into your project and add the .cpp to your CMake target.
// ---------------------------------------------------------------------------
class BasicBarExample : public QWidget
{
    Q_OBJECT

public:
    explicit BasicBarExample(QWidget *parent = nullptr);
};
