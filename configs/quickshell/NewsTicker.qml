import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: root

    property string apiKey: ""
    property string endpoint: "crypto"
    property string apiQuery: "&coin=xmr,btc,sol&language=en&removeduplicate=1&prioritydomain=top"
    property string additionalEndpoint: "latest"
    property string additionalApiQuery: "&country=my&language=en&removeduplicate=1&prioritydomain=top"
    property string initialMessage: "Loading financial news..."
    property string newsText: initialMessage
    property var newsItems: [
        { title: initialMessage, link: "" }
    ]
    property string newsCachePath: "/tmp/quickshell-news.txt"
    property int pendingRequests: 0
    property var fetchedItems: []
    property var requestErrors: []
    property int topMargin: 34
    anchors.top: true
    anchors.left: true
    anchors.right: true
    WlrLayershell.margins.top: root.topMargin
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.aboveWindows: true
    implicitHeight: 32
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    function cacheNews() {
        cacheProcess.command = [
            "sh",
            "-c",
            "printf '%s\\n' \"$1\" > \"$2\"",
            "quickshell-news",
            root.newsText,
            root.newsCachePath
        ]
        cacheProcess.running = true
    }

    onNewsTextChanged: root.cacheNews()

    function setNewsMessage(message) {
        root.newsItems = [{ title: message, link: "" }]
        root.newsText = message
    }

    function setNewsItems(items) {
        var titles = []

        for (var i = 0; i < items.length; i++)
            titles.push(items[i].title)

        root.newsItems = items
        root.newsText = titles.join("          ")
    }

    Process {
        id: cacheProcess
    }

    // Get NewsData API key from GNOME Keyring
    Process {
        id: apiKeyProcess

        command: [
            "secret-tool",
            "lookup",
            "app",
            "Newsdata"
        ]

        stdout: SplitParser {
            onRead: data => {
                root.apiKey = data.trim()

                if (root.apiKey.length > 0)
                    root.fetchNews()
            }
        }

    }

    function fetchNews() {
        if (root.apiKey.length === 0) {
            console.log("API key is empty")
            root.setNewsMessage("News API key is missing")
            return
        }

        if (fetchProcess.running || additionalFetchProcess.running)
            return

        root.pendingRequests = 2
        root.fetchedItems = []
        root.requestErrors = []
        root.startRequest(fetchProcess, root.endpoint, root.apiQuery)
        root.startRequest(additionalFetchProcess, root.additionalEndpoint, root.additionalApiQuery)
    }

    function startRequest(process, requestEndpoint, requestQuery) {
        process.output = ""
        process.errorOutput = ""
        process.command = [
            "curl",
            "-s",
            "https://newsdata.io/api/1/" + requestEndpoint +
            "?apikey=" + encodeURIComponent(root.apiKey) +
            requestQuery
        ]
        process.running = true
    }

    function handleRequestResponse(output, errorOutput) {
        var responseError = ""

        if (output.length > 0) {
            try {
                var json = JSON.parse(output)

                if (json.results && json.results.length > 0) {
                    for (var i = 0; i < json.results.length; i++) {
                        var title = json.results[i].title || "Untitled article"
                        var link = json.results[i].link || ""
                        var duplicate = false

                        for (var j = 0; j < root.fetchedItems.length; j++) {
                            var existing = root.fetchedItems[j]
                            if ((link.length > 0 && existing.link === link) || existing.title === title) {
                                duplicate = true
                                break
                            }
                        }

                        if (!duplicate)
                            root.fetchedItems.push({ title: "◆  " + title, link: link })
                    }
                } else if (json.status === "error" || json.message) {
                    responseError = json.message || "Unknown NewsData error"
                }
            } catch (e) {
                responseError = "Invalid NewsData response: " + e
            }
        } else if (errorOutput.trim().length > 0) {
            responseError = errorOutput.trim()
        }

        if (responseError.length > 0)
            root.requestErrors.push(responseError)

        root.pendingRequests--
        if (root.pendingRequests === 0) {
            if (root.fetchedItems.length > 0) {
                root.setNewsItems(root.fetchedItems)
            } else if (root.requestErrors.length > 0) {
                console.log("NewsData API errors:", root.requestErrors.join("; "))
                root.setNewsMessage("News API error: " + root.requestErrors[0])
            } else {
                root.setNewsMessage("No news at the moment")
            }
        }
    }

    // Update every 20 minutes
    Timer {
        interval: 20 * 60 * 1000
        running: true
        repeat: true
        triggeredOnStart: false

        onTriggered: root.fetchNews()
    }

    Timer {
        interval: 60 * 1000
        running: root.newsText === "No news at the moment"
        repeat: true
        triggeredOnStart: false

        onTriggered: root.fetchNews()
    }

    Process {
        id: fetchProcess

        property string output: ""
        property string errorOutput: ""

        command: ["true"]

        stdout: SplitParser {
            onRead: data => {
                fetchProcess.output += data
            }
        }

        stderr: SplitParser {
            onRead: data => {
                fetchProcess.errorOutput += data
            }
        }

        onRunningChanged: {
            if (!running) {
                root.handleRequestResponse(output, errorOutput)
                output = ""
                errorOutput = ""
            }
        }
    }

    Process {
        id: additionalFetchProcess

        property string output: ""
        property string errorOutput: ""

        command: ["true"]

        stdout: SplitParser {
            onRead: data => {
                additionalFetchProcess.output += data
            }
        }

        stderr: SplitParser {
            onRead: data => {
                additionalFetchProcess.errorOutput += data
            }
        }

        onRunningChanged: {
            if (!running) {
                root.handleRequestResponse(output, errorOutput)
                output = ""
                errorOutput = ""
            }
        }
    }

    // Retrieve API key immediately when component starts
    Component.onCompleted: {
        apiKeyProcess.running = true
    }

    Component {
        id: headlineDelegate

        Item {
            width: titleText.width + separatorText.width
            height: titleText.height

            Text {
                id: titleText

                text: modelData.title
                color: titleMouse.containsMouse
                    ? "#50fa7b"
                    : "white"
                font.pixelSize: 13
                verticalAlignment: Text.AlignVCenter

                MouseArea {
                    id: titleMouse

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if (modelData.link.length > 0)
                            Qt.openUrlExternally(modelData.link)
                    }
                }
            }

            Text {
                id: separatorText

                anchors.left: titleText.left
                text: "                    "
                color: "white"
                font.pixelSize: 13
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#cc111111"
        clip: true

        Item {
            id: tickerContent

            width: tickerRow.width / 2
            height: parent.height
            x: 0

            Row {
                id: tickerRow

                anchors.verticalCenter: parent.verticalCenter

                Repeater {
                    model: root.newsItems
                    delegate: headlineDelegate
                }

                Repeater {
                    model: root.newsItems
                    delegate: headlineDelegate
                }
            }

            SequentialAnimation {
                id: tickerAnimation

                running: tickerArea.width > 0
                loops: Animation.Infinite

                onRunningChanged: {
                    if (running)
                        tickerContent.x = 0
                }

                NumberAnimation {
                    target: tickerContent
                    property: "x"
                    from: 0
                    to: -tickerContent.width

                    duration: tickerContent.width * 14

                    easing.type: Easing.Linear
                }
            }

            Connections {
                target: root

                function onNewsTextChanged() {
                    tickerAnimation.restart()
                }
            }
        }
    }

    Item {
        id: tickerArea
        anchors.fill: parent
    }
}
