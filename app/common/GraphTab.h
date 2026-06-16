#pragma once

#include <QWidget>
#include <QString>

class QSplitter;

// ---------------------------------------------------------------------------
// GraphTab
// Base tab widget that holds two side-by-side graph instances.
//
// Layout:
//   +--------------------+--------------------+
//   |   instance 0       |   instance 1       |
//   +--------------------+--------------------+
//
// Usage: subclasses call setGraphWidget(0, ...) and setGraphWidget(1, ...)
// to replace the placeholder labels with real graph widgets.
// ---------------------------------------------------------------------------
class GraphTab : public QWidget
{
    Q_OBJECT

public:
    explicit GraphTab(const QString &graphTypeName, QWidget *parent = nullptr);

protected:
    // Replace slot index (0 or 1) with a real graph widget.
    // The previous widget at that slot is deleted.
    void setGraphWidget(int index, QWidget *widget);

private:
    QSplitter *m_splitter;

    QWidget *makePlaceholder(const QString &label);
};
