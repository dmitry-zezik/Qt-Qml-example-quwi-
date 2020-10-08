import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root_window

    readonly property real screenDP: Math.ceil(((Screen.pixelDensity * 25.4) / 96) * 10) / 10

    function dp(num) { // function to scale app
        return num * screenDP
    }

    minimumWidth: dp(800)
    minimumHeight: dp(500)
    width: dp(960)
    height: dp(540)

    visible: true
    title: qsTr("Quwi")

    Variables {
        id: appVariables
    }

    ServerCommunication {
        id: appServer
    }

    Loader {
        id: mainApp_loader
        anchors.fill: parent
        source: appVariables.appSettings.isAppLocal ? 'remote/MainApp.qml' : 'some https://REMOTE_UI'
    }
}
