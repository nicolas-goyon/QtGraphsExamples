#pragma once

#include <QMainWindow>
#include <QString>

// ---------------------------------------------------------------------------
// DemoWindow
// Lightweight base class for all example main windows.
// Sets a consistent title and minimum size without requiring Q_OBJECT
// (no signals or slots defined here — inherited from QMainWindow).
// ---------------------------------------------------------------------------
class DemoWindow : public QMainWindow
{
public:
    explicit DemoWindow(const QString &title,
                        int           width  = 900,
                        int           height = 600,
                        QWidget      *parent = nullptr)
        : QMainWindow(parent)
    {
        setWindowTitle(title);
        resize(width, height);
        setMinimumSize(480, 320);
    }
};
