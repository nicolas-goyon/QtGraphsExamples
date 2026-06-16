#pragma once

#include <QWidget>

// ---------------------------------------------------------------------------
// BasicSurface3DExample
// A minimal sinc-function surface using Qt Graphs Q3DSurface.
//
// Self-contained: no dependency on other files in this project.
// Copy this folder into your project and add the .cpp to your CMake target.
// ---------------------------------------------------------------------------
class BasicSurface3DExample : public QWidget
{
    Q_OBJECT

public:
    explicit BasicSurface3DExample(QWidget *parent = nullptr);
};
