import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
	id: root

	// Automatically resolved backlight device name (e.g. "amdgpu_bl0", "amdgpu_bl1", or "intel_backlight")
	property string backlightDevice: ""
	property real maxBrightness: 1
	property real brightness: 0

	// "volume", "mic", or "brightness" — determines which bar/icon the OSD shows
	property string osdType: "volume"
	property bool shouldShowOsd: false
	property bool backlightReady: false

	// --- Dynamic Backlight Device Discovery ---
	// Discovers the first available entry under /sys/class/backlight
	Process {
		id: findBacklight
		command: ["sh", "-c", "ls -1 /sys/class/backlight 2>/dev/null | head -n 1"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				const dev = data.trim();
				if (dev.length > 0) {
					root.backlightDevice = dev;
				}
			}
		}
	}

	// --- Speaker (sink) tracking ---
	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink, Pipewire.defaultAudioSource ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio
		function onVolumeChanged() {
			root.osdType = "volume";
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
		function onMutedChanged() {
			root.osdType = "volume";
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	// --- Mic (source) tracking ---
	Connections {
		target: Pipewire.defaultAudioSource?.audio
		function onVolumeChanged() {
			root.osdType = "mic";
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
		function onMutedChanged() {
			root.osdType = "mic";
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	// --- Brightness tracking ---
	FileView {
		id: maxBrightnessFile
		path: root.backlightDevice !== "" ? ("/sys/class/backlight/" + root.backlightDevice + "/max_brightness") : ""
		onLoaded: {
			const maxVal = parseInt(text());
			if (!isNaN(maxVal) && maxVal > 0) {
				root.maxBrightness = maxVal;
			}
		}
	}

	FileView {
		id: brightnessFile
		path: root.backlightDevice !== "" ? ("/sys/class/backlight/" + root.backlightDevice + "/brightness") : ""
		watchChanges: true
		onFileChanged: reload()
		onLoaded: {
			const current = parseInt(text());
			if (!isNaN(current)) {
				root.brightness = current / root.maxBrightness;
				// Avoid triggering the OSD popup on the initial startup read
				if (root.backlightReady) {
					root.osdType = "brightness";
					root.shouldShowOsd = true;
					hideTimer.restart();
				} else {
					root.backlightReady = true;
				}
			}
		}
	}

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}

	// Picks the right icon name based on osdType, mute state, and level
	function iconForState(): string {
		if (root.osdType === "brightness")
			return "display-brightness-symbolic";

		if (root.osdType === "mic") {
			const muted = Pipewire.defaultAudioSource?.audio.muted ?? false;
			return muted
				? "microphone-sensitivity-muted-symbolic"
				: "microphone-sensitivity-high-symbolic";
		}

		// volume
		const muted = Pipewire.defaultAudioSink?.audio.muted ?? false;
		const vol = Pipewire.defaultAudioSink?.audio.volume ?? 0;
		if (muted || vol === 0) return "audio-volume-muted-symbolic";
		if (vol < 0.5) return "audio-volume-low-symbolic";
		return "audio-volume-high-symbolic";
	}

	// Picks the fill fraction for the bar
	function levelForState(): real {
		if (root.osdType === "brightness") return Math.min(1.0, Math.max(0.0, root.brightness));
		if (root.osdType === "mic")
			return (Pipewire.defaultAudioSource?.audio.muted ?? false)
				? 0
				: Math.min(1.0, Pipewire.defaultAudioSource?.audio.volume ?? 0);
		return (Pipewire.defaultAudioSink?.audio.muted ?? false)
			? 0
			: Math.min(1.0, Pipewire.defaultAudioSink?.audio.volume ?? 0);
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
						source: Quickshell.iconPath(root.iconForState())
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
							implicitWidth: parent.width * root.levelForState()
							radius: parent.radius
						}
					}
				}
			}
		}
	}
}
