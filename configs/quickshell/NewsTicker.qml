import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: root

    property string apiKey: ""
    property string newsText: "Loading financial news..."
    property var newsItems: [
        { title: "Loading financial news...", link: "" }
    ]
    readonly property string newsCachePath: "/tmp/quickshell-news.txt"
    anchors.top: true
    anchors.left: true
    anchors.right: true
    WlrLayershell.margins.top: 34
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

        fetchProcess.output = ""
        fetchProcess.errorOutput = ""

        fetchProcess.command = [
            "curl",
            "-s",
            "https://newsdata.io/api/1/crypto" +
            "?apikey=" + encodeURIComponent(root.apiKey) +
            "&language=en" +
            "&removeduplicate=1" +
            "&coin=btc,sol,eth,xmr" +
            "&prioritydomain=top" 
        ]

        fetchProcess.running = true
    }

    // Update every 10 minutes
    Timer {
        interval: 10 * 60 * 1000
        running: true
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
            if (!running && output.length > 0) {
                try {
                    var json = JSON.parse(output)

                    if (json.results && json.results.length > 0) {
                        var items = []

                        for (var i = 0; i < json.results.length; i++) {
                            var title = json.results[i].title || "Untitled article"
                            var link = json.results[i].link || ""
                            var displayTitle = "◆  " + title
                            items.push({ title: displayTitle, link: link })
                        }

                        root.setNewsItems(items)

                    } else if (json.status === "error" || json.message) {
                        var apiError = json.message || "Unknown NewsData error"
                        console.log("NewsData API error:", apiError)
                        root.setNewsMessage("News API error: " + apiError)
                    } else {
                        console.log("NewsData returned no articles")
                        root.setNewsMessage("No news at the moment")
                    }

                } catch (e) {
                    console.log("NewsData JSON error:", e)
                    root.setNewsMessage("News response error: " + e)
                }

                output = ""
            } else if (!running) {
                var curlError = errorOutput.trim()
                root.setNewsMessage(
                    curlError.length > 0
                        ? "News request error: " + curlError
                        : "No news at the moment"
                )
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

                    duration: tickerContent.width * 18

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
