import QtQuick
import Quickshell.Io

Item {
    id: root

    signal changed(string type, real level, string icon)

    property string device: ""
    property real maxBrightness: 1
    property real brightness: 0
    property bool ready: false

    Process {
        id: findBacklight
        command: ["sh", "-c", "ls -1 /sys/class/backlight 2>/dev/null | head -n 1"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                const dev = data.trim();
                if (dev.length > 0) {
                    root.device = dev;
                }
            }
        }
    }

    FileView {
        id: maxBrightnessFile
        path: root.device !== "" ? ("/sys/class/backlight/" + root.device + "/max_brightness") : ""
        onLoaded: {
            const maxVal = parseInt(text());
            if (!isNaN(maxVal) && maxVal > 0) {
                root.maxBrightness = maxVal;
            }
        }
    }

    FileView {
        id: brightnessFile
        path: root.device !== "" ? ("/sys/class/backlight/" + root.device + "/brightness") : ""
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            const current = parseInt(text());
            if (!isNaN(current)) {
                root.brightness = current / root.maxBrightness;
                if (root.ready) {
                    const level = Math.min(1.0, Math.max(0.0, root.brightness));
                    root.changed("brightness", level, "display-brightness-symbolic");
                } else {
                    root.ready = true;
                }
            }
        }
    }
}
