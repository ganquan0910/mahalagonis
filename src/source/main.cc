#include <QGuiApplication>
#include <QUrl>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
//    QApplication app(argc, argv);
    QGuiApplication app(argc, argv);
//    QQuickView view;
//    view.setSource(QUrl("qrc:///qml/main.qml"));
//    view.show();
    QQmlApplicationEngine engine(QUrl("qrc:///qml/main.qml"));

    return app.exec();
}
