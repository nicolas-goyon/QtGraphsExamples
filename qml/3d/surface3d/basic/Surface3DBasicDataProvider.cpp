#include "Surface3DBasicDataProvider.h"
#include <QtMath>

Surface3DBasicDataProvider::Surface3DBasicDataProvider(QObject *parent)
    : QAbstractListModel(parent)
{
    constexpr int steps = 30;
    const double range = M_PI;

    m_data.reserve((steps + 1) * (steps + 1));

    for (int iz = 0; iz <= steps; ++iz) {
        const double z = -range + (2.0 * range * iz / steps);
        for (int ix = 0; ix <= steps; ++ix) {
            const double x = -range + (2.0 * range * ix / steps);
            const double y = qSin(x) * qCos(z);
            m_data.append({
                QString::number(x, 'f', 4),
                QString::number(z, 'f', 4),
                QString::number(y, 'f', 6)
            });
        }
    }
}

int Surface3DBasicDataProvider::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return static_cast<int>(m_data.size());
}

QVariant Surface3DBasicDataProvider::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= static_cast<int>(m_data.size()))
        return {};
    const auto &pt = m_data.at(index.row());
    switch (role) {
    case XRole: return pt.x;
    case ZRole: return pt.z;
    case YRole: return pt.y;
    default:    return {};
    }
}

QHash<int, QByteArray> Surface3DBasicDataProvider::roleNames() const
{
    return {
        {XRole, QByteArrayLiteral("x")},
        {ZRole, QByteArrayLiteral("z")},
        {YRole, QByteArrayLiteral("y")},
    };
}
