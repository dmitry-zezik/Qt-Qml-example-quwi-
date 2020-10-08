import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: mainApp_root

    Item {
        id: appNavigation
        anchors.fill: parent

        DropShadow {
            id: background_Rec_shadow
            anchors.fill: background_Rec
            source: background_Rec
            transparentBorder: true
            horizontalOffset: 1
            verticalOffset: 1
            radius: 8.0
            spread: 0.2
            samples: 17
            color: "#50000000"
            opacity: 1
        }

        Rectangle {
            id: background_Rec
            anchors.centerIn: parent
            width: dp(420)
            height: dp(320)
            color: '#f2f2f2'
            radius: dp(5)
        }


        ParallelAnimation {
            id: background_Rec_expandAnim
            NumberAnimation {target: background_Rec; property: "width"; to: mainApp_root.width; easing.type: Easing.InOutCubic; duration: 350}
            NumberAnimation {target: background_Rec; property: "height"; to: mainApp_root.height; easing.type: Easing.InOutCubic; duration: 350}
            NumberAnimation {target: background_Rec; property: "radius"; to: 0; easing.type: Easing.InOutCubic; duration: 350}
            NumberAnimation {target: background_Rec_shadow; property: "opacity"; to: 0; easing.type: Easing.InOutCubic; duration: 250}

        }

        StackView {
            id: appStack
            anchors.fill: parent
            initialItem: loginPage

            pushEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 450
                }
//                PropertyAnimation {
//                    property: "scale"
//                    from: 0.8
//                    to:1
//                    duration: 450
//                    easing.type: Easing.OutCubic
//                }
            }
            pushExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 450
                }
//                PropertyAnimation {
//                    property: "scale"
//                    from: 1
//                    to:0.8
//                    duration: 450
//                    easing.type: Easing.OutCubic
//                }
            }
            popEnter: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 0
                    to:1
                    duration: 450
                }
            }
            popExit: Transition {
                PropertyAnimation {
                    property: "opacity"
                    from: 1
                    to:0
                    duration: 450
                }
            }
        }

        Component {
            id: loginPage

            Item {
//                anchors.fill: parent

                Item {
                    id: loginItem
                    anchors.centerIn: parent
                    width: dp(420)
                    height: dp(320)

                    property bool emailIsValid: true
                    property bool isPasswordReqrd: false

                    Item {
                        anchors.centerIn: parent
                        width: parent.width * 0.7
                        height: parent.height * 0.5

                        Column {
                            anchors.fill: parent

                            Text {
                                id: _loginText
                                text: qsTr('LOGIN')
                                color: appVariables.appStyle.color_Title
                                font.pointSize: appVariables.appStyle.size_Title
                            }

                            Item {
                                width: parent.width
                                height: dp(16)
                            }

                            Rectangle {
                                id: _emailBackground

                                property string placeholderText: "Email"

                                width: parent.width
                                height: dp(32)
                                color: 'white'
                                clip: true
                                border.width: dp(1)
                                border.color: {
                                    if (loginItem.emailIsValid === false) {
                                        return 'red'
                                    } else {
                                        if (_emailBackground_TextInput.focus === true) {
                                            return appVariables.appStyle.appBlue
                                        } else {
                                            return 'gray'
                                        }
                                    }
                                }

                                radius: dp(5)

                                TextInput { // Tab textInput
                                    id: _emailBackground_TextInput
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    leftPadding: dp(8)
                                    antialiasing: true
                                    smooth: true
                                    font.pointSize: dp(10)
                                    color: appVariables.appStyle.color_Title
                                    onAccepted: {
                                        _emailBackground_TextInput.focus = false
                                    }
                                    onFocusChanged: {
                                        console.log('studiesPage_tabs_textInput.focus: ', _emailBackground_TextInput.focus)
                                        if (_emailBackground_TextInput.focus === false) {
                                            validateEmail(_emailBackground_TextInput.text)
                                        }
                                    }
                                    MouseArea {
                                        id: _emailBackground_TextInput_MouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            _emailBackground_TextInput_MouseArea.cursorShape = Qt.IBeamCursor
                                        }
                                        onExited: {
                                            _emailBackground_TextInput_MouseArea.cursorShape = Qt.ArrowCursor
                                        }
                                        onClicked: {
                                            if (!_emailBackground_TextInput.activeFocus) {
                                                _emailBackground_TextInput.forceActiveFocus()
                                            }
                                        }
                                    }
                                }

                                Text { // Placeholder text
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    leftPadding: dp(8)
                                    antialiasing: true
                                    smooth: true
                                    font.pointSize: dp(10)
                                    color: 'gray'
                                    text: _emailBackground.placeholderText
                                    visible: {
                                        if (_emailBackground_TextInput.focus === false && _emailBackground_TextInput.text === '') {
                                            return true
                                        } else {
                                            return false
                                        }
                                    }

                                }

                            }

                            Item {
                                width: parent.width
                                height: dp(8)
                            }

                            Rectangle {
                                id: _passwordBackground

                                property string placeholderText: "Password"

                                width: parent.width
                                height: dp(32)
                                color: 'white'
                                clip: true
                                border.width: dp(1)
                                border.color: {
                                    if (loginItem.isPasswordReqrd === true) {
                                        return 'red'
                                    } else {
                                        if (_passwordBackground_TextInput.focus === true) {
                                            return appVariables.appStyle.appBlue
                                        } else {
                                            return 'gray'
                                        }
                                    }


                                }
                                radius: dp(5)

                                TextInput { // Tab textInput
                                    id: _passwordBackground_TextInput
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    leftPadding: dp(8)
                                    antialiasing: true
                                    smooth: true
                                    font.pointSize: dp(10)
                                    color: appVariables.appStyle.color_Title
                                    onAccepted: {
                                        _passwordBackground_TextInput.focus = false
                                        if (_passwordBackground_TextInput.text !== '')  {
                                            loginItem.isPasswordReqrd = false
                                        }
                                    }
                                    onFocusChanged: {
                                        console.log('studiesPage_tabs_textInput.focus: ', _passwordBackground_TextInput.focus)
                                    }
                                    MouseArea {
                                        id: _passwordBackground_TextInput_MouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: {
                                            _passwordBackground_TextInput_MouseArea.cursorShape = Qt.IBeamCursor
                                        }
                                        onExited: {
                                            _passwordBackground_TextInput_MouseArea.cursorShape = Qt.ArrowCursor
                                        }
                                        onClicked: {
                                            if (!_passwordBackground_TextInput.activeFocus) {
                                                _passwordBackground_TextInput.forceActiveFocus()
                                            }
                                        }
                                    }
                                }

                                Text { // Placeholder text
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    leftPadding: dp(8)
                                    antialiasing: true
                                    smooth: true
                                    font.pointSize: dp(10)
                                    color: 'gray'
                                    text: _passwordBackground.placeholderText
                                    visible: {
                                        if (_passwordBackground_TextInput.focus === false && _passwordBackground_TextInput.text === '') {
                                            return true
                                        } else {
                                            return false
                                        }
                                    }

                                }

                            }

                            Item {
                                width: parent.width
                                height: dp(16)
                            }

                            Button {
                                id: _loginButton

                                property string buttonText: 'LOGIN'
                                property string buttonRadius: dp(5)
                                property color mainColor: appVariables.appStyle.appBlue
                                property color altColor: appVariables.appStyle.darkGray

                                width: dp(96)
                                height: dp(32)
                                onClicked: {
                                    loginButtonPressed()
                                }

                                contentItem: Text {
                                    id: content_item_button_text
                                    anchors.fill: parent
                                    text: _loginButton.buttonText
                                    antialiasing: true
                                    color: 'white'
                                    font.pointSize: appVariables.appStyle.size_Text
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }

                                background: Rectangle {
                                    id: button_rec
                                    width: _loginButton.width
                                    height: _loginButton.height
                                    opacity: enabled ? 1 : 0.3
                                    color: _loginButton.mainColor
                                    radius: _loginButton.buttonRadius
                                }

                                onPressed: {
                                    if (back_to_color.running === true) {
                                        back_to_color.stop()
                                    }

                                    button_rec.color = _loginButton.altColor
                                    content_item_button_text.color = "white"
                                }

                                onReleased: {
                                    back_to_color.restart()
                                    content_item_button_text.color = 'white'
                                }

                                PropertyAnimation {
                                    id: back_to_color
                                    target: button_rec
                                    property: "color"
                                    to: _loginButton.mainColor
                                    duration: 550
                                    easing.type: Easing.OutBack
                                    easing.amplitude: 4.0
                                    easing.period: 1.5
                                }

                                MouseArea {
                                    id: _loginButton_MouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    acceptedButtons: Qt.NoButton
                                    onEntered: {
                                        _loginButton_MouseArea.cursorShape = Qt.PointingHandCursor
                                    }
                                    onExited: {
                                        _loginButton_MouseArea.cursorShape = Qt.ArrowCursor
                                    }
                                }
                            }

                        }
                    }
                }

                Connections {
                    target: appServer.auth
                    onSigAuthSuccess: {
                        appVariables.appSettings.busiIndicatorRunning = false
                        showPopup("You have successfully logged in!", 3500)
                        background_Rec_expandAnim.start()
                        appStack.push(listPage)
                        appServer.bugtracker.projects.getProjects(appVariables.appSettings.accessToken)
                    }

                    onSigAuthError: {
                        appVariables.appSettings.busiIndicatorRunning = false
                        showPopup("Oops... Something went wrong!", 3500)
                    }
                }

                function validateEmail(email) {
                    if (email === '') {
                        loginItem.emailIsValid = false
                        showPopup("You have to enter an email!", 3500)
                        return
                    }

                    let emailFormat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
                    if (email.match(emailFormat)) {
                        loginItem.emailIsValid = true
                    } else {
                        loginItem.emailIsValid = false
                        showPopup("You have entered an invalid email address!", 3500)
                    }
                }

                function loginButtonPressed() {
                    validateEmail(_emailBackground_TextInput.text)
                    if (loginItem.emailIsValid === false) {
                        return
                    }

                    if (_passwordBackground_TextInput.text === '') {
                        loginItem.isPasswordReqrd = true
                        showPopup("You have to enter password!", 3500)
                        return
                    }

                    appVariables.appSettings.busiIndicatorRunning = true

                    // AUTH user data
                    let email = _emailBackground_TextInput.text
                    let password = _passwordBackground_TextInput.text
                    appServer.auth.loginUser(email, password)

//                    showPopup("You have successfully logged in!", 3500)
//                    background_Rec_expandAnim.start()
//                    appStack.push(listPage)


                }
            }
        }

        Component {
            id: listPage

            Item {

                Item {
                    id: listPage_contentItem
                    anchors.top: titleBar.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    ListView {
                        id: projectsListView
                        anchors.fill: parent
                        model: appVariables.appModels.listModel_Projects
                        spacing: dp(16)
                        header: Item {
                            width: parent.width
                            height: dp(28)
                        }
                        footer: Item {
                            width: parent.width
                            height: dp(28)
                        }
                        delegate: projectsListView_comp
                        add: Transition {
                            ParallelAnimation {
                                NumberAnimation {property: "scale"; from: 0; to: 1; easing.type: Easing.OutBack; easing.overshoot: 1; duration: 500}
                                NumberAnimation {property: "opacity"; from: 0; to: 1; easing.type: Easing.InOutQuad; duration: 200}
                            }
                        }
                    }

                    Component {
                        id: projectsListView_comp

                        Rectangle {
                            width: parent.width * 0.6
                            height: dp(86)
                            anchors.horizontalCenter: parent.horizontalCenter
                            color: 'white'
                            radius: dp(5)
                            border.width: dp(1)
                            border.color: 'light gray'

                            Row {
                                anchors.fill: parent

                                Item {
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: parent.height
                                    width: parent.width * 0.2
                                    Rectangle {
                                        anchors.centerIn: parent
                                        height: parent.height * 0.5
                                        width: height
                                        radius: height
                                        color: projectImage.status === Image.Ready ? 'transparent' : 'black'

                                        Image {
                                            id: projectImage
                                            anchors.fill: parent
                                            source: logo_url
                                            mipmap: true
                                            fillMode: Image.PreserveAspectFit
                                        }
                                    }

                                }

                                Item {
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: parent.height * 0.5
                                    width: parent.width * 0.2

                                    Text {
                                        anchors.fill: parent
                                        anchors.leftMargin: dp(8)
                                        horizontalAlignment: Text.AlignLeft
                                        verticalAlignment: Text.AlignVCenter
                                        antialiasing: true
                                        smooth: true
                                        font.pointSize: appVariables.appStyle.size_Text
                                        color: appVariables.appStyle.color_Title
                                        text: name
                                    }

                                }

                                Item {
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: parent.height * 0.5
                                    width: parent.width * 0.2

                                    Text {
                                        anchors.fill: parent
                                        anchors.leftMargin: dp(8)
                                        horizontalAlignment: Text.AlignLeft
                                        verticalAlignment: Text.AlignVCenter
                                        antialiasing: true
                                        smooth: true
                                        font.pointSize: appVariables.appStyle.size_Text
                                        color: {
                                            if (is_active == false) {
                                                return 'gray'
                                            } else {
                                                return 'green'
                                            }
                                        }

                                        text: {
                                            if (is_active == false) {
                                                return 'Inactive'
                                            } else {
                                                return 'Active'
                                            }
                                        }
                                    }

                                }

                                Item {
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: parent.height * 0.8
                                    width: parent.width * 0.2

                                    Column {
                                        anchors.fill: parent

                                        Item {
                                            width: parent.width
                                            height: parent.height / 3

                                            Text {
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignLeft
                                                verticalAlignment: Text.AlignVCenter
                                                antialiasing: true
                                                smooth: true
                                                font.pointSize: appVariables.appStyle.size_Text
                                                color: appVariables.appStyle.color_Title
                                                text: 'time this week'
                                            }
                                        }

                                        Item {
                                            width: parent.width
                                            height: parent.height / 3

                                            Text {
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignLeft
                                                verticalAlignment: Text.AlignVCenter
                                                antialiasing: true
                                                smooth: true
                                                font.pointSize: appVariables.appStyle.size_Text
                                                color: appVariables.appStyle.color_Title
                                                text: 'this month'
                                            }
                                        }

                                        Item {
                                            width: parent.width
                                            height: parent.height / 3

                                            Text {
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignLeft
                                                verticalAlignment: Text.AlignVCenter
                                                antialiasing: true
                                                smooth: true
                                                font.pointSize: appVariables.appStyle.size_Text
                                                color: appVariables.appStyle.color_Title
                                                text: 'total'
                                            }
                                        }
                                    }
                                }

                                Item {
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: parent.height * 0.8
                                    width: parent.width * 0.2

                                    Column {
                                        anchors.fill: parent

                                        Item {
                                            width: parent.width
                                            height: parent.height / 3

                                            Text {
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                antialiasing: true
                                                smooth: true
                                                font.pointSize: appVariables.appStyle.size_Text
                                                color: appVariables.appStyle.color_Title
                                                text: '00:00:00'
                                            }
                                        }

                                        Item {
                                            width: parent.width
                                            height: parent.height / 3

                                            Text {
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                antialiasing: true
                                                smooth: true
                                                font.pointSize: appVariables.appStyle.size_Text
                                                color: appVariables.appStyle.color_Title
                                                text: '00:00:00'
                                            }
                                        }

                                        Item {
                                            width: parent.width
                                            height: parent.height / 3

                                            Text {
                                                anchors.fill: parent
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                antialiasing: true
                                                smooth: true
                                                font.pointSize: appVariables.appStyle.size_Text
                                                color: appVariables.appStyle.color_Title
                                                text: '00:00:00'
                                            }
                                        }
                                    }
                                }

                            }

                            MouseArea {
                                id: projectsListView_comp_mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    projectsListView_comp_mouseArea.cursorShape = Qt.PointingHandCursor
                                }
                                onExited: {
                                    projectsListView_comp_mouseArea.cursorShape = Qt.ArrowCursor
                                }
                                onClicked: {
                                    let thisItem = appVariables.appModels.listModel_Projects.get(index)
                                    projectPopup.modelData = thisItem
                                    projectPopup.open()
                                }
                            }
                        }
                    }
                }

                DropShadow {
                    id: titleBar_shadow
                    anchors.fill: titleBar
                    source: titleBar
                    transparentBorder: true
                    horizontalOffset: 1
                    verticalOffset: 1
                    radius: 8.0
                    spread: 0.2
                    samples: 17
                    color: "#50000000"
                    opacity: 1
                }


                Rectangle {
                    id: titleBar
                    anchors.top: parent.top
                    width: parent.width
                    height: dp(32)
                    color: 'white'
                    Text {
                        id: _loginText
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: dp(8)
                        text: qsTr('Q')
                        color: appVariables.appStyle.color_Title
                        font.pointSize: appVariables.appStyle.size_Title
                    }

                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: dp(16)
                        spacing: dp(16)
                        Text {
                            text: qsTr('PROJECTS')
                            color: 'gray'
                            font.pointSize: appVariables.appStyle.size_Text
                            MouseArea {
                                id: _projectsButton_MouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    _projectsButton_MouseArea.cursorShape = Qt.PointingHandCursor
                                }
                                onExited: {
                                    _projectsButton_MouseArea.cursorShape = Qt.ArrowCursor
                                }
                                onClicked: {
                                    console.log("[X getProjects(.accessToken)] ", appVariables.appSettings.accessToken)
                                    appServer.bugtracker.projects.getProjects(appVariables.appSettings.accessToken)
                                }
                            }
                        }
                        Text {
                            text: qsTr('LOGOUT')
                            color: 'gray'
                            font.pointSize: appVariables.appStyle.size_Text
                            MouseArea {
                                id: _logoutButton_MouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    _logoutButton_MouseArea.cursorShape = Qt.PointingHandCursor
                                }
                                onExited: {
                                    _logoutButton_MouseArea.cursorShape = Qt.ArrowCursor
                                }
                            }
                        }
                    }

                }
            }
        }

        Popup {
            id: projectPopup
            property var modelData

            anchors.centerIn: parent
            width: dp(460)
            height: dp(280)
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

            background: Rectangle {
                color: 'white'
                radius: dp(5)
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: dp(2)
                    verticalOffset: dp(2)
                    radius: dp(5)
                    samples: 17
                    color: "#50000000"
                }
            }

            enter: Transition {
                ParallelAnimation {
                    NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 250; easing.type: Easing.OutCubic}
                    NumberAnimation { property: "scale"; from: 0.8; to: 1.0; duration: 250; easing.type: Easing.OutCubic}
                }
            }

            exit: Transition {
                ParallelAnimation {
                    NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 250; easing.type: Easing.OutCubic}
                    NumberAnimation { property: "scale"; from: 1.0; to: 0.8; duration: 250; easing.type: Easing.OutCubic}
                }
            }


            onModelDataChanged: {
                app_switch.isOn = projectPopup.modelData['is_active']
                _nameBackground_TextInput.text = projectPopup.modelData['name']
            }

            Item {
                anchors.fill: parent
                anchors.margins: dp(16)

                Column {
                    anchors.fill: parent
                    spacing: dp(16)

                    Row {
                        spacing: dp(32)
                        Text {
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: dp(56)
                            leftPadding: dp(8)
                            antialiasing: true
                            smooth: true
                            font.pointSize: appVariables.appStyle.size_Text
                            color: appVariables.appStyle.color_Title
                            text: app_switch.isOn === false ? 'Inactive' : 'Active'
                        }

                        Item {
                            id: app_switch
                            width: dp(36)
                            height: dp(20)
                            anchors.verticalCenter: parent.verticalCenter

                            property bool isOn: projectPopup.modelData['is_active']
                            onIsOnChanged: {
                                let val
                                if (isOn === true) {
                                    val = 1
                                } else {
                                    val = 0
                                }

                                projectPopup.modelData['is_active'] = val
                                console.log("[U]", projectPopup.modelData['is_active'])
                                console.log("[XXX] modelData", projectPopup.modelData, JSON.stringify(projectPopup.modelData))
                                isOnChangeBehavior()
                            }

                            Component.onCompleted: {
                                if(isOn === true) {
                                    on_anim.restart()
                                    on_anim_color.restart()
                                } else {
                                    off_anim.restart()
                                    off_anim_color.restart()
                                }
                            }

                            function isOnChangeBehavior() {
                                if(app_switch.isOn === true) {
                                    on_anim.restart()
                                    on_anim_color.restart()
                                } else {
                                    off_anim.restart()
                                    off_anim_color.restart()
                                }
                            }

                            Rectangle {
                                id: background
                                anchors.fill: parent
                                radius: height
                                color: appVariables.appStyle.appBlue
                                Rectangle {
                                    id: controller
                                    x: dp(1)
                                    y: dp(1)
                                    width: parent.height - dp(2)
                                    height: width
                                    radius: height
                                    color: 'white'
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if(app_switch.isOn === true) {
                                            app_switch.isOn = false
                                            off_anim.restart()
                                            off_anim_color.restart()
                                        } else {
                                            app_switch.isOn = true
                                            on_anim.restart()
                                            on_anim_color.restart()
                                        }
                                    }
                                }
                            }

                            PropertyAnimation {
                                id: on_anim
                                target: controller
                                property: "x"
                                to: app_switch.width - controller.width - dp(1)
                                duration: 200
                                easing.type: Easing.OutCubic
                            }
                            PropertyAnimation {
                                id: on_anim_color
                                target: background
                                property: "color"
                                to: appVariables.appStyle.appBlue
                                duration: 200
                                easing.type: Easing.OutCubic
                            }
                            PropertyAnimation {
                                id: off_anim
                                target: controller
                                property: "x"
                                to: dp(1)
                                duration: 200
                                easing.type: Easing.OutCubic
                            }
                            PropertyAnimation {
                                id: off_anim_color
                                target: background
                                property: "color"
                                to: 'gray'
                                duration: 200
                                easing.type: Easing.OutCubic
                            }

                        }
                    }

                    Row {
                        Text {
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                            leftPadding: dp(8)
                            antialiasing: true
                            smooth: true
                            font.pointSize: appVariables.appStyle.size_Text
                            color: appVariables.appStyle.color_Title
                            text: 'Name'
                        }

                        Item {
                            width: dp(32)
                            height: 1
                        }

                        Rectangle {
                            id: _nameBackground
                            anchors.verticalCenter: parent.verticalCenter
                            width: dp(186)
                            height: dp(32)
                            color: 'transparent'
                            border.width: dp(1)
                            border.color: {
                                if (_nameBackground_TextInput.focus === true) {
                                    return appVariables.appStyle.appBlue
                                } else {
                                    return 'gray'
                                }
                            }

                            radius: dp(5)

                            TextInput {
                                id: _nameBackground_TextInput
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignLeft
                                verticalAlignment: Text.AlignVCenter
                                leftPadding: dp(8)
                                antialiasing: true
                                smooth: true
                                clip: true
                                font.pointSize: dp(10)
                                color: appVariables.appStyle.color_Title
                                onAccepted: {
                                    _nameBackground_TextInput.focus = false
                                }

                                MouseArea {
                                    id: _nameBackground_TextInput_MouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        _nameBackground_TextInput_MouseArea.cursorShape = Qt.IBeamCursor
                                    }
                                    onExited: {
                                        _nameBackground_TextInput_MouseArea.cursorShape = Qt.ArrowCursor
                                    }
                                    onClicked: {
                                        if (!_nameBackground_TextInput.activeFocus) {
                                            _nameBackground_TextInput.forceActiveFocus()
                                        }
                                    }
                                }
                            }
                        }

                        Item {
                            width: dp(8)
                            height: 1
                        }

                        Button {
                            id: _projectNameButton

                            property string buttonText: 'OK'
                            property string buttonRadius: dp(5)
                            property color mainColor: appVariables.appStyle.appBlue
                            property color altColor: appVariables.appStyle.darkGray

                            width: dp(68)
                            height: dp(32)
                            anchors.verticalCenter: parent.verticalCenter
                            onClicked: {
                                projectPopup.okayButtonPressed()
                            }

                            contentItem: Text {
                                id: content_item_button_text
                                anchors.fill: parent
                                text: _projectNameButton.buttonText
                                antialiasing: true
                                color: 'white'
                                font.pointSize: appVariables.appStyle.size_Text
                                wrapMode: Text.WordWrap
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            background: Rectangle {
                                id: button_rec
                                width: _projectNameButton.width
                                height: _projectNameButton.height
                                opacity: enabled ? 1 : 0.3
                                color: _projectNameButton.mainColor
                                radius: _projectNameButton.buttonRadius
                            }

                            onPressed: {
                                if (back_to_color.running === true) {
                                    back_to_color.stop()
                                }

                                button_rec.color = _projectNameButton.altColor
                                content_item_button_text.color = "white"
                            }

                            onReleased: {
                                back_to_color.restart()
                                content_item_button_text.color = 'white'
                            }

                            PropertyAnimation {
                                id: back_to_color
                                target: button_rec
                                property: "color"
                                to: _projectNameButton.mainColor
                                duration: 550
                                easing.type: Easing.OutBack
                                easing.amplitude: 4.0
                                easing.period: 1.5
                            }

                            MouseArea {
                                id: _loginButton_MouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                acceptedButtons: Qt.NoButton
                                onEntered: {
                                    _loginButton_MouseArea.cursorShape = Qt.PointingHandCursor
                                }
                                onExited: {
                                    _loginButton_MouseArea.cursorShape = Qt.ArrowCursor
                                }
                            }
                        }
                    }

                    Row {
                        spacing: dp(32)
                        Text {
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: dp(8)
                            antialiasing: true
                            smooth: true
                            font.pointSize: appVariables.appStyle.size_Text
                            color: appVariables.appStyle.color_Title
                            text: 'Users'
                        }

                    }
                }
            }

            function okayButtonPressed() {
                let newName = _nameBackground_TextInput.text
                modelData['name'] = newName

                let token = appVariables.appSettings.accessToken
                let id = projectPopup.modelData['id']
            }
        }
    }

    BusyIndicator {
        id: busy_indicator
        anchors.centerIn: parent
        running: appVariables.appSettings.busiIndicatorRunning
        scale: 0.75

        contentItem: Item {
                implicitWidth: 64
                implicitHeight: 64

                Item {
                    id: item
                    x: parent.width / 2 - 32
                    y: parent.height / 2 - 32
                    width: 64
                    height: 64
                    opacity: busy_indicator.running ? 1 : 0

                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 250
                        }
                    }

                    RotationAnimator {
                        target: item
                        running: busy_indicator.visible && busy_indicator.running
                        from: 0
                        to: 360
                        loops: Animation.Infinite
                        duration: 1250
                    }

                    Repeater {
                        id: repeater
                        model: 6

                        Rectangle {
                            x: item.width / 2 - width / 2
                            y: item.height / 2 - height / 2
                            implicitWidth: 10
                            implicitHeight: 10
                            radius: 5
                            color: "dark gray"
                            transform: [
                                Translate {
                                    y: -Math.min(item.width, item.height) * 0.5 + 5
                                },
                                Rotation {
                                    angle: index / repeater.count * 360
                                    origin.x: 5
                                    origin.y: 5
                                }
                            ]
                        }
                    }
                }
            }
    }

    Item {
        id: custom_popup_item

        property var custom_popup_text: 'Custom popup'
        property var custom_popup_interval: 5000

        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.8
        height: dp(36)
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height * 0.35
        opacity: 0

        Rectangle {
            id: custom_popup
            anchors.centerIn: custom_popup_item
            width: text_item.contentWidth + dp(18)
            height: text_item.contentHeight + dp(18)
            focus: false
            color: "black"
            opacity: 0.8
            radius: dp(12)
        }

        Text {
            id: text_item
            anchors.centerIn: custom_popup_item
            width: custom_popup_item.width
            text: custom_popup_item.custom_popup_text
            antialiasing: true
            color: 'white'
            font.pointSize: dp(10)
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        ParallelAnimation {
            id: showAnimate
            NumberAnimation {target: custom_popup_item; property: "opacity"; from: 0.0; to: 1.0;
                easing.type: Easing.InOutQuad; duration: 200; easing.overshoot: 1}
            NumberAnimation {target: custom_popup_item; property: "scale"; from: 0.0; to: 1.0;
                easing.type: Easing.OutBack; duration: 200; easing.overshoot: 2}
        }

        ParallelAnimation {
            id: hideAnimate
            NumberAnimation {target: custom_popup_item; property: "opacity"; from: 1.0; to: 0.0;
                easing.type: Easing.InOutQuad; duration: 200; easing.overshoot: 1}
            NumberAnimation {target: custom_popup_item; property: "scale"; from: 1.0; to: 0.0;
                easing.type: Easing.InOutQuad; duration: 200; easing.overshoot: 1}
        }


        function showPopup(textValue, interval) {
            custom_popup_item.custom_popup_text = textValue
            custom_popup_item.custom_popup_interval = interval
            showAnimate.start()
            closingTimer.start()
        }

        Timer {
            id: closingTimer
            running: false
            repeat: false
            interval: custom_popup_item.custom_popup_interval
            onTriggered: {
                hideAnimate.start()
            }
        }
    }

    function showPopup(textValue, interval) {
        custom_popup_item.custom_popup_text = textValue
        custom_popup_item.custom_popup_interval = interval
        showAnimate.start()
        closingTimer.start()
    }
}
