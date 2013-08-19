import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    ListModel {
        id: userList

        ListElement {
            name: "Test"
        }
        ListElement {
            name: "Test2"
        }
    }

    SplitView {
        id: mainLayout
        anchors.fill: parent
        orientation: Qt.Horizontal

        TableView {
            width: 100
            headerVisible: false
            alternatingRowColors: false
            model: userList
            TableViewColumn{ role: "name" }

        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TextArea{
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            TextField {
                Layout.fillWidth: true
            }
        }

        TableView {
            width: 100
            headerVisible: false
            alternatingRowColors: false
            model: userList
            TableViewColumn{ role: "name" }

        }
    }
}
