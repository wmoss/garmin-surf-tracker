using Toybox.Sensor;
using Toybox.SensorLogging;
using Toybox.ActivityRecording;
using Toybox.Position;
using Toybox.Time;
using Toybox.FitContributor;



class AccelData
{
    hidden var session = null;
    hidden var accuracy;
    hidden var running = false;
    hidden var surfingTimeStart;
    hidden var waveCount = 0;

    function registerEventListeners() {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPositionData));
        Sensor.registerSensorDataListener(
            method(:onAccelData),
            {
                :period => 1, :sampleRate => Sensor.getMaxSampleRate(), :enableAccelerometer => true,
                :includePower => true, :includePitch => true, :includeRoll => true
            });
    }

    function start() {
        if (session == null) { // Check for existing session first?
            var logger = new SensorLogging.SensorLogger({:enableAccelerometer => true});
            session = ActivityRecording.createSession({
                :name => "SurfTracker",
                :sport => ActivityRecording.SPORT_SURFING,
                :sensorLogger => logger
            });
            surfingTimeStart = Time.now();
        }
        session.start();
        running = true;
    }

    function stop() {
        running = false;
        Sensor.unregisterSensorDataListener();
        return session.stop();
    }

    function save() {
        return session.save();
    }

    function onAccelData(sensorData) {
        // use if(running) for wave tracking

        //sensorData.accelerometerData.x;
        //sensorData.accelerometerData.y;
        //sensorData.accelerometerData.z;
    }

    function onPositionData(info) {
        accuracy = info.accuracy;

        // use if(running) for wave tracking
    }

    function addWave() {
        waveCount += 1;
        session.addLap();
    }

    function getWaveCount() {
        return waveCount;
    }

    function getAccuracy() {
        return accuracy;
    }

    function getSurfingTime() {
        return Time.now().subtract(surfingTimeStart);
    }
}
