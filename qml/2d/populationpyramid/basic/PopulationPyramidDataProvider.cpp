#include "PopulationPyramidDataProvider.h"

PopulationPyramidDataProvider::PopulationPyramidDataProvider(QObject *parent) : QObject(parent) {}

QStringList PopulationPyramidDataProvider::ageGroups() const {
    return {"0-4","5-9","10-14","15-19","20-24","25-29","30-34","35-39",
            "40-44","45-49","50-54","55-59","60-64","65-69","70-74","75+"};
}

QVariantList PopulationPyramidDataProvider::womenValues() const {
    return {2.3, 2.5, 2.8, 3.1, 3.4, 3.6, 3.9, 3.8, 3.5, 3.2, 2.9, 2.4, 2.0, 1.6, 1.2, 1.4};
}

QVariantList PopulationPyramidDataProvider::menValues() const {
    return {2.4,2.6,2.9,3.2,3.5,3.8,4.1,4.0,3.7,3.3,3.0,2.5,2.1,1.5,1.0,0.9};
}
