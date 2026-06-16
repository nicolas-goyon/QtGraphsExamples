#pragma once
#include <QAbstractListModel>
#include <QtQml/qqmlregistration.h>

// Provides a sin(x)*cos(z) surface as a list model for Surface3D.
// Compatible with ItemModelSurfaceDataProxy (roles: "x", "z", "y").
// Swap the constructor body to load from file, network, etc.
class Surface3DDataProvider : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    struct DataPoint { QString x; QString z; QString y; };

    enum Roles { XRole = Qt::UserRole + 1, ZRole, YRole };

public:
    explicit Surface3DDataProvider(QObject *parent = nullptr);

    int      rowCount(const QModelIndex &parent = {}) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<DataPoint> m_data;
};
