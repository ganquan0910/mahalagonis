#include <QGuiApplication>
#include <QUrl>
#include <QQmlApplicationEngine>
#include <QQmlComponent>

#include <communi/IrcCore/IrcCore>
#include <communi/IrcUtil/IrcCommandParser>
#include <communi/IrcUtil/IrcTextFormat>

Q_DECLARE_METATYPE(Irc::Code)
Q_DECLARE_METATYPE(IrcMessage::Type)
Q_DECLARE_METATYPE(IrcCommand::Type)

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Make types available in QML
    qRegisterMetaType<Irc::Code>();
    qRegisterMetaType<IrcMessage::Type>();
    qRegisterMetaType<IrcCommand::Type>();

    qmlRegisterType<Irc>("Communi", 3, 0, "Irc");
    qmlRegisterType<IrcConnection>("Communi", 3, 0, "IrcConnection");
    qmlRegisterType<IrcCommand>("Communi", 3, 0, "IrcCommand");
    qmlRegisterUncreatableType<IrcMessage>("Communi", 3, 0, "IrcMessage",
                                           "Cannot create an instance of IrcMessage. Use IrcConnection::messageReceived() signal instead.");
    qmlRegisterUncreatableType<IrcNetwork>("Communi", 3, 0, "IrcNetwork",
                                           "Cannot create an instance of IrcNetwork. Use IrcConnection::network property instead.");

    qmlRegisterType<IrcCommandParser>("Communi", 3, 0, "IrcCommandParser");
    qmlRegisterType<IrcTextFormat>("Communi", 3, 0, "IrcTextFormat");


    // Load QML view
    QQmlApplicationEngine engine(QUrl("qrc:///qml/main.qml"));

    return app.exec();
}
