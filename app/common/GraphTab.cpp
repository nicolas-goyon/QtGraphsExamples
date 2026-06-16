#include "common/GraphTab.h"

#include <QFrame>
#include <QLabel>
#include <QSplitter>
#include <QVBoxLayout>

// ---------------------------------------------------------------------------
// Construction
// ---------------------------------------------------------------------------
GraphTab::GraphTab(const QString &graphTypeName, QWidget *parent)
    : QWidget(parent)
    , m_splitter(new QSplitter(Qt::Horizontal, this))
{
    m_splitter->setChildrenCollapsible(false);
    m_splitter->addWidget(makePlaceholder(graphTypeName + " #1"));
    m_splitter->addWidget(makePlaceholder(graphTypeName + " #2"));
    m_splitter->setSizes({INT_MAX, INT_MAX}); // equal split

    auto *layout = new QVBoxLayout(this);
    layout->setContentsMargins(4, 4, 4, 4);
    layout->addWidget(m_splitter);
}

// ---------------------------------------------------------------------------
// Protected
// ---------------------------------------------------------------------------
void GraphTab::setGraphWidget(int index, QWidget *widget)
{
    Q_ASSERT(index == 0 || index == 1);
    QWidget *old = m_splitter->widget(index);
    // insertWidget replaces at position; remove old manually first
    if (old) {
        old->hide();
        old->deleteLater();
    }
    m_splitter->insertWidget(index, widget);
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------
QWidget *GraphTab::makePlaceholder(const QString &label)
{
    auto *frame = new QFrame();
    frame->setFrameShape(QFrame::StyledPanel);
    frame->setFrameShadow(QFrame::Sunken);

    auto *lbl = new QLabel(label, frame);
    lbl->setAlignment(Qt::AlignCenter);
    lbl->setStyleSheet("color: #888; font-size: 14px;");

    auto *layout = new QVBoxLayout(frame);
    layout->addWidget(lbl);

    return frame;
}
