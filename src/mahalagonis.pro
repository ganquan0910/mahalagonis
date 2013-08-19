QT += qml quick
TARGET = mahalagonis
qtHaveModule(widgets) {
    QT += widgets
}

#include(src.pri)

SOURCES += \
    source/main.cpp

OTHER_FILES += \
    qml/main.qml

RESOURCES += \
    qml.qrc
