using Toybox.WatchUi;
using Toybox.Time;
using Toybox.System;
using Toybox.Timer;
using Toybox.Attention;


class SurfTrackerDelegate extends WatchUi.BehaviorDelegate {
    hidden const DOUBLE_PRESS_THRESHOLD = 400;

    hidden var lastKeyPressMillis;
    hidden var accelData;
    hidden var buttonTimer;

    function initialize(accelData) {
        BehaviorDelegate.initialize();
        self.accelData = accelData;
        buttonTimer = new Timer.Timer();
        lastKeyPressMillis = System.getTimer() - DOUBLE_PRESS_THRESHOLD;
    }

    function onMenu() {
        return true;
    }

    function onPreviousPage() {
        return true;
    }

    function onNextPage() {
        return true;
    }

    function onPreviousMode() {
        return true;
    }

    function onBack() {
        return true;
    }

    function onNextMode() {
        return true;
    }

    function onSelect() {
        return true;
    }

    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            var now = System.getTimer();
            if (now - lastKeyPressMillis < DOUBLE_PRESS_THRESHOLD) {
                buttonTimer.stop();
                WatchUi.switchToView(new PausedView(), new PausedDelegate(accelData), WatchUi.SLIDE_LEFT);
            } else {
                buttonTimer.start(method(:markWave), DOUBLE_PRESS_THRESHOLD + 25, false);
            }
            lastKeyPressMillis = now;
        }
        return true;
    }

    function markWave() {
        lastKeyPressMillis = System.getTimer() - DOUBLE_PRESS_THRESHOLD;
        accelData.addWave();
        Attention.vibrate([new Attention.VibeProfile(100, 1000)]);
    }
}
