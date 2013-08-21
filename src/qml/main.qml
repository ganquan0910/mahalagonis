import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import Communi 3.0

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    onClosing: {
        ircConnection.close();
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Connect")
                onTriggered: ircConnection.open()
            }
            MenuItem {
                text: qsTr("Join")
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    MessageFormatter {
        id: formatter
    }

    IrcConnection {
        id: ircConnection
        host: "irc.freenode.org"
        userName: "xevioxTEST"
        nickName: "xevioxTEST"
        realName: "xevioxTEST"

        onConnected: chatView.append("Connected ..")
        onMessageReceived: chatView.append(formatter.formatMessage(message))
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
            focus: true

            TextArea {
                id: chatView
                Layout.fillHeight: true
                Layout.fillWidth: true
                readOnly: true
                textFormat: Qt.RichText
            }

            IrcCommandParser {
                id: ircParser
                channels: "#unitedsoftcoders"

                Component.onCompleted: {
                    addCommand(IrcCommand.Join, "JOIN <#channel> (<key>)")
                    addCommand(IrcCommand.Nick, "NICK <nick>")
                    addCommand(IrcCommand.Part, "PART (<#channel>) (<message...>)")
                }
            }

            TextField {
                id: input

                Layout.fillWidth: true
                onAccepted: {
                    // ircConnection.sendRaw(text)
                    var cmd = ircParser.parse(text)
                    if (cmd) {
                        ircConnection.sendCommand(cmd)
                        if (cmd.type == IrcCommand.Message
                                || cmd.type == IrcCommand.Notice) {

                            var msg = cmd.toMessage(ircConnection.nickName, ircConnection)
                            chatView.append(formatter.formatMessage(msg))
                        }
                    }

                    text = ""
                }
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
