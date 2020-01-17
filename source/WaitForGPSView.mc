using Toybox.WatchUi;
using Toybox.Activity;
using Toybox.Attention;
using Toybox.Timer;


class WaitForGPSView extends WatchUi.View {
    hidden var accuracyText;
    hidden var timer;
    hidden var updateCount = 0;
    hidden var accuracyUpdates = 0;
    hidden var accuracy = 0;
    hidden var accelData;

    function initialize(accelData) {
        View.initialize();

        self.accelData = accelData;
        timer = new Timer.Timer();
    }

    function onLayout(dc) {
        accuracyText = new WatchUi.Text({
            :text => getQualityStringText(accuracy),
            :color => Graphics.COLOR_WHITE,
            :locX => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY => WatchUi.LAYOUT_VALIGN_CENTER,
            :justification => Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER,
        });
        setLayout([ accuracyText ]);
    }

    function onShow() {
        timer.start(method(:updateQuality), 1000, true);
    }

    function updateQuality() {
        var newAccuracy = accelData.getAccuracy();
        if (newAccuracy != null) {
            if (newAccuracy == Position.QUALITY_GOOD &&
                accuracy != Position.QUALITY_GOOD) {
                    Attention.vibrate([new Attention.VibeProfile(100, 2000)]);
            }

            accuracy = newAccuracy;
            accuracyUpdates++;
        }
        updateCount++;
        WatchUi.requestUpdate();
    }

    function onUpdate(dc) {
        View.onUpdate(dc);

        accuracyText.setText(getQualityStringText((accuracy)));
    }

    function onHide() {
        timer.stop();
    }

    function getQualityStringText(accuracy) {
        return "Accuracy: " + getQualityString(accuracy);
    }

    function getQualityString(accuracy) {
      switch (accuracy) {
        case Position.QUALITY_GOOD:
          return "Good";
          break;
        case Position.QUALITY_USABLE:
          return "Usable";
          break;
        default:
          return "Poor";
          break;
      }
    }
}
