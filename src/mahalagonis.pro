###############
# Mahalagonis #
###############

QT += quick

TARGET = mahalagonis
qtHaveModule(widgets) {
    QT += widgets
}

lessThan(QT_MAJOR_VERSION, 5)|lessThan(QT_MINOR_VERSION, 1) {
    error(The Qt Quick 2 based example requires Qt 5.1 or newer but Qt $$[QT_VERSION] was detected.)
}

#include(src.pri)

# C++11 enabled
QMAKE_CXXFLAGS += -std=c++11

# communi is used for the irc protocol
CONFIG += communi
COMMUNI += \
    core \
    util

SOURCES += \
    source/main.cpp

#HEADERS +=

OTHER_FILES += \
    qml/main.qml \
    qml/MessageFormatter.qml

RESOURCES += \
    qml.qrc
