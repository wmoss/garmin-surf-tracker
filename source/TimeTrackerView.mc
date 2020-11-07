using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;


class TimeTrackerView extends WatchUi.View {
    hidden var currentTimeLabel;
    hidden var elapsedTimeLabel;

    function initialize() {
        View.initialize();
    }

    function createTimeLabels(dc) {
        currentTimeLabel = new WatchUi.Text({
            :color => Graphics.COLOR_WHITE,
            :font => Graphics.FONT_MEDIUM,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => 0,
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
        });
        elapsedTimeLabel = new WatchUi.Text({
            :color => Graphics.COLOR_WHITE,
            :font => Graphics.FONT_MEDIUM,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => dc.getHeight() * 0.84,
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
        });

        return [currentTimeLabel, elapsedTimeLabel];
    }

    function updateTimeLabels() {
        currentTimeLabel.setText(formatTime(Gregorian.info(Time.now(), Time.FORMAT_SHORT)));

        var elapsed = Time.today().add(new Time.Duration(Activity.getActivityInfo().timerTime / 1000));
        elapsedTimeLabel.setText(formatTime(Gregorian.info(elapsed, Time.FORMAT_SHORT)));
    }

    function formatTime(time) {
        return Lang.format(
            "$1$:$2$:$3$",
            [ time.hour.format("%02i"), time.min.format("%02i"), time.sec.format("%02i")]
        );
    }
}