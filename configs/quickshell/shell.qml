import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

ShellRoot {
    id: root

    property string currentIcon: "audio-volume-high-symbolic"
    property real currentLevel: 0.0
    property bool shouldShowOsd: false

    // =========================
    // News ticker
    // =========================

    NewsTicker {
        id: newsTicker
    }

    function displayOsd(type: string, level: real, icon: string) {
        root.currentLevel = level;
        root.currentIcon = icon;
        root.shouldShowOsd = true;
        hideTimer.restart();
    }

    // Audio tracking component
    AudioTracker {
        id: audioTracker
        onChanged: (type, level, icon) => root.displayOsd(type, level, icon)
    }

    // Backlight tracking component
    BacklightTracker {
        id: backlightTracker
        onChanged: (type, level, icon) => root.displayOsd(type, level, icon)
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0
            implicitWidth: 400
            implicitHeight: 50
            color: "transparent"
            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"

                RowLayout {
                    anchors {
                        fill: parent
                        leftMargin: 10
                        rightMargin: 15
                    }

                    IconImage {
                        implicitSize: 30
                        source: Quickshell.iconPath(root.currentIcon)
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 20
                        color: "#50ffffff"

                        Rectangle {
                            anchors {
                                left: parent.left
                                top: parent.top
                                bottom: parent.bottom
                            }

                            implicitWidth:
                                parent.width * root.currentLevel

                            radius: parent.radius
                        }
                    }
                }
            }
        }
    }
}
