#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ledcontroller.h"
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    LedController ledController;
    QQuickStyle::setStyle("Material");

    engine.rootContext()->setContextProperty("ledController", &ledController);

    const QUrl url(QStringLiteral("qrc:/caosLock/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
