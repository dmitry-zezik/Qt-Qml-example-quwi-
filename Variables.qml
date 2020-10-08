import QtQuick 2.12

Item {
    id: variables_root

    property alias appSettings: appSettings
    property alias appStyle: appStyle
    property alias appModels: appModels

    QtObject {
        id: appSettings // This is the main application UX settings item.

        property bool isAppLocal: true
        property var accessToken
        property bool busiIndicatorRunning: false
    }

    QtObject {
        id: appStyle // This is the main application UI settings item.

        property color color_Title: 'black'
        property real size_Title: dp(14)

        property color color_Text: 'dark gray'
        property real size_Text: dp(10)

        property color appBlue: '#5073b5'
        property color darkGray: '#565e69'
    }

    Item {
        id: appModels

        property alias listModel_Projects: listModel_Projects

        ListModel {
            id: listModel_Projects
        }

        function addItemsTo_listModel_Projects(data) {
            listModel_Projects.clear()

            data.forEach(function(itm) {
                listModel_Projects.append(itm)
              });

            let i
            for (i = 0; i < listModel_Projects.count; i++) {
                console.log('[X]', i, listModel_Projects.get(i), JSON.stringify(listModel_Projects.get(i)))
            }
        }
    }

}
