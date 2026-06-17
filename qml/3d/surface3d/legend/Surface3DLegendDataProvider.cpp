#include "Surface3DLegendDataProvider.h"
#include <QtMath>

Surface3DLegendDataProvider::Surface3DLegendDataProvider(QObject *parent)
    : QAbstractListModel(parent)
{
    // Two Gaussian peaks at (-1, -1) and (1.5, 1.5)
    constexpr int steps = 40;
    const double range  = 3.0;

    m_data.reserve((steps + 1) * (steps + 1));

    for (int iz = 0; iz <= steps; ++iz) {
        const double z = -range + (2.0 * range * iz / steps);
        for (int ix = 0; ix <= steps; ++ix) {
            const double x = -range + (2.0 * range * ix / steps);
            const double peak1 = qExp(-((x + 1.0) * (x + 1.0) + (z + 1.0) * (z + 1.0)) / 1.2);
            const double peak2 = 0.7 * qExp(-((x - 1.5) * (x - 1.5) + (z - 1.5) * (z - 1.5)) / 0.8);
            m_data.append({x, z, peak1 + peak2});
        }
    }
}

int Surface3DLegendDataProvider::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return static_cast<int>(m_data.size());
}

QVariant Surface3DLegendDataProvider::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= static_cast<int>(m_data.size()))
        return {};
    const auto &pt = m_data.at(index.row());
    switch (role) {
    case XRole: return pt.xPos;
    case ZRole: return pt.zPos;
    case YRole: return pt.yPos;
    default:    return {};
    }
}

QHash<int, QByteArray> Surface3DLegendDataProvider::roleNames() const
{
    return {
        {XRole, QByteArrayLiteral("xPos")},
        {ZRole, QByteArrayLiteral("zPos")},
        {YRole, QByteArrayLiteral("yPos")},
    };
}
