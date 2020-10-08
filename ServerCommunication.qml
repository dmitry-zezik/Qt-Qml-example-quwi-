import QtQuick 2.12

Item {
    id: server_communication_root

    property alias auth: auth
    property alias bugtracker: bugtracker

    Item {
        id: auth

        signal sigAuthError
        signal sigAuthSuccess

        function loginUser(email, password) {
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                print('xhr: on ready state change: ' + xhr.readyState)
                if(xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        try {
                            let res = JSON.parse(xhr.responseText.toString())
                            console.log("[X] RESPONSE: ", JSON.stringify(res))
                            appVariables.appSettings.accessToken = res['token']
                            sigAuthSuccess()
                        } catch(err) {
                            sigAuthError()
                        }

                    } else {
                        sigAuthError()
                    }
                }
            }
            xhr.open('POST', 'https://api.quwi.com/v2/auth/login');
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.setRequestHeader('Client-Timezone-Offset', '60');
            xhr.setRequestHeader('Client-Language', 'ru-RU');
            xhr.setRequestHeader('Client-Company', 'udimiteam');
            xhr.setRequestHeader('Client-Device', 'desktop');

            let authData = JSON.stringify({'email': email, 'password': password})
            xhr.send(authData)
        }
    }

    Item {
        id: bugtracker

        property alias projects: projects

        Item {
            id: projects

            function getProjects(accessToken) {
                let xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    print('xhr: on ready state change: ' + xhr.readyState)
                    if(xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            try {
                                let res = JSON.parse(xhr.responseText.toString())
                                console.log("[X] RESPONSE: ", JSON.stringify(res))
                                appVariables.appModels.addItemsTo_listModel_Projects(res['projects'])
//                                sigGetProjectSuccess()
                            } catch(err) {
                                console.log("[E] ", err)
//                                sigGetProjectError()
                            }

                        } else {
//                            sigGetProjectError()
                        }
                    }
                }
                xhr.open('GET', 'https://api.quwi.com/v2/projects' + '?access_token=' + accessToken);
                xhr.send()
            }

        }
    }
}
