using Toybox.WatchUi;
using Toybox.Time;
using Toybox.System;
using Toybox.Timer;
using Toybox.Attention;


class SurfTrackerDelegate extends WatchUi.BehaviorDelegate {
    hidden const DOUBLE_PRESS_THRESHOLD = 400;
    hidden const TRIPLE_PRESS_THRESHOLD = 2 * DOUBLE_PRESS_THRESHOLD;

    hidden var accelData;

    hidden var penultimateKeyPressMillis;
    hidden var lastKeyPressMillis;
    hidden var keyPressStart;
    hidden var buttonTimer;

    hidden var page;

    function initialize(accelData) {
        BehaviorDelegate.initialize();

        self.accelData = accelData;
        accelData.start();

        buttonTimer = new Timer.Timer();
        lastKeyPressMillis = System.getTimer() - DOUBLE_PRESS_THRESHOLD;
        penultimateKeyPressMillis = System.getTimer() - TRIPLE_PRESS_THRESHOLD;
        page = 0;
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

    /*
     * Single press => Mark wave
     * Double press => Switch page
     * Triple press => Pause
     */
    function onKey(keyEvent) {
        if (keyEvent.getKey() == KEY_ENTER) {
            var now = System.getTimer();
            if ((now - lastKeyPressMillis < DOUBLE_PRESS_THRESHOLD) && (now - penultimateKeyPressMillis < TRIPLE_PRESS_THRESHOLD)) {
                buttonTimer.stop();
                WatchUi.switchToView(new PausedView(), new PausedDelegate(accelData), WatchUi.SLIDE_LEFT);
            } else if (now - lastKeyPressMillis < DOUBLE_PRESS_THRESHOLD) {
                penultimateKeyPressMillis = lastKeyPressMillis;
                buttonTimer.stop();
                buttonTimer.start(method(:changePage), DOUBLE_PRESS_THRESHOLD + 5, false);
            } else {
                buttonTimer.stop();
                buttonTimer.start(method(:markWave), DOUBLE_PRESS_THRESHOLD + 5, false);
            }
            lastKeyPressMillis = now;
        }
        return true;
    }

    function markWave() {
        accelData.addWave();
        Attention.vibrate([new Attention.VibeProfile(100, 1000)]);
        WatchUi.requestUpdate();
    }

    function changePage() {
        page = (page + 1) % 2;
        if (page == 0) {
            WatchUi.switchToView(new SurfTrackerView(accelData), self, WatchUi.SLIDE_DOWN);
        } else if (page == 1) {
            WatchUi.switchToView(new GPSTrackView(accelData), self, WatchUi.SLIDE_DOWN);
        } else {
            // wtfbbq?
        }
    }
}
