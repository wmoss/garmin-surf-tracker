using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Timer;


class SurfTrackerView extends WatchUi.View {
    hidden var accelData;
    hidden var currentTimeLabel;
    hidden var elapsedTimeLabel;
    hidden var timer;

    function initialize(accelData) {
        View.initialize();
        self.accelData = accelData;

        timer = new Timer.Timer();
    }

    function onLayout(dc) {
        var height = dc.getHeight();

        currentTimeLabel = new WatchUi.Text({
            :color => Graphics.COLOR_WHITE,
            :font => Graphics.FONT_MEDIUM,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => 0,
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
        });

        var surferBitmap = new WatchUi.Bitmap({
            :rezId => Rez.Drawables.Surfer,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
        });

        elapsedTimeLabel = new WatchUi.Text({
            :color => Graphics.COLOR_WHITE,
            :font => Graphics.FONT_MEDIUM,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => height * 0.8,
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
        });

        setLayout([currentTimeLabel, surferBitmap, elapsedTimeLabel]);
    }

    function onShow() {
        accelData.start();
        timer.start(method(:requestUpdate), 1000, true);
    }

    function requestUpdate() {
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);

        var elapsed = Time.today().add(new Time.Duration(Activity.getActivityInfo().timerTime / 1000));
        currentTimeLabel.setText(formatTime(Gregorian.info(Time.now(), Time.FORMAT_SHORT)));
        elapsedTimeLabel.setText(formatTime(Gregorian.info(elapsed, Time.FORMAT_SHORT)));
    }

    function formatTime(time) {
        return Lang.format(
            "$1$:$2$:$3$",
            [ time.hour.format("%02i"), time.min.format("%02i"), time.sec.format("%02i")]
        );
    }

    function onHide() {
        accelData.stop();
    }

}
