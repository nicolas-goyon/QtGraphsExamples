#pragma once

#include <QWidget>

// ---------------------------------------------------------------------------
// BasicBars3DExample
// A minimal 3D bar chart using Qt Graphs Q3DBars.
//
// Self-contained: no dependency on other files in this project.
// Copy this folder into your project and add the .cpp to your CMake target.
// ---------------------------------------------------------------------------
class BasicBars3DExample : public QWidget
{
    Q_OBJECT

public:
    explicit BasicBars3DExample(QWidget *parent = nullptr);
};
