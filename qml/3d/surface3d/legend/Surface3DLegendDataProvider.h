#pragma once
#include <QAbstractListModel>
#include <QtQml/qqmlregistration.h>

// Provides a double-peak Gaussian terrain as a list model for Surface3D.
// Compatible with ItemModelSurfaceDataProxy (roles: "xPos", "zPos", "yPos").
class Surface3DLegendDataProvider : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    struct DataPoint { double xPos; double zPos; double yPos; };
    enum Roles { XRole = Qt::UserRole + 1, ZRole, YRole };

public:
    explicit Surface3DLegendDataProvider(QObject *parent = nullptr);

    int      rowCount(const QModelIndex &parent = {}) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<DataPoint> m_data;
};
