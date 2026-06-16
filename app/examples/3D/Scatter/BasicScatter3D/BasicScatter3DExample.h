#pragma once

#include <QWidget>

// ---------------------------------------------------------------------------
// BasicScatter3DExample
// A minimal 3D scatter chart using Qt Graphs Q3DScatter.
//
// Self-contained: no dependency on other files in this project.
// Copy this folder into your project and add the .cpp to your CMake target.
// ---------------------------------------------------------------------------
class BasicScatter3DExample : public QWidget
{
    Q_OBJECT

public:
    explicit BasicScatter3DExample(QWidget *parent = nullptr);
};
