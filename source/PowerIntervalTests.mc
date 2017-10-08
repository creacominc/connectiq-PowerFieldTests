// test the PowerInterval class


(:test)  // powerInterval initialize test.
function testPowerIntervalInitialize(logger)
{
    // set the properties for this test
    var properties = {
        "Time0" => 3,
        "Target0" => 923,
        "Time1" => 30,
        "Target1" => 549,
        "Time2" => 60,
        "Target2" => 431,
        "Time3" => 240,
        "Target3" => 283,
        "Time4" => 1200,
        "Target4" => 236,
        "Time5" => 3600,
        "Target5" => 184,
        "Time6" => 7200,
        "Target6" => 152
    };
    var index = 0;
    var greenAt = 0.80;
    // create power interval object
    var powerInterval = new PowerIntervalMock(properties, index, greenAt);
    // confirm that some fields are initialized
    // duration
    var duration = powerInterval.getDuration();
    var expectedDuration = properties.get("Time"+index);
    Toybox.Test.assertEqualMessage(expectedDuration, duration, "Duration (" + duration + ") expected to be " + expectedDuration);
    // full time elapsed
    Toybox.Test.assertEqualMessage(false, powerInterval.getFullTimeElapsed(), "Full Time Elapsed expected to be false.");
    // target
    var target = powerInterval.getTarget();
    var expectedTarget = properties.get("Target"+index);
    Toybox.Test.assertEqualMessage(expectedTarget, target, "Target (" + target + ") expected to be " + expectedTarget);
    // green at
    var greenAtPower = powerInterval.getGreenAt();
    var expectedGreenAtPower = greenAt * expectedTarget;
    Toybox.Test.assertEqualMessage(expectedGreenAtPower, greenAtPower, "GreenAt (" + greenAtPower + ") expected to be " + expectedGreenAtPower);
    // last total
    var lastTotal = powerInterval.getLastTotal();
    Toybox.Test.assertEqualMessage(0, lastTotal, "Last Total (" + lastTotal + ") expected to be 0.");
    // average
    var average = powerInterval.getAverage();
    Toybox.Test.assertEqualMessage(0, average, "Average (" + average + ") expected to be 0.");
    // peak
    var peak = powerInterval.getPeak();
    Toybox.Test.assertEqualMessage(0, peak, "Peak (" + peak + ") expected to be 0.");
    // display units
    // --- see testPowerIntervalInitializeDurationDisplay
    // display interval
    // --- see testPowerIntervalInitializeDurationDisplay
    return true;
}


(:test) // powerInterval initialization - duration limits
function testPowerIntervalInitializeDurationLimits(logger)
{
    // set the application properties for this test
    var properties = {
        "Time0" => -1,
        "Target0" => 2,
        "Time1" => 0,
        "Target1" => 2,
        "Time2" => 1,
        "Target2" => 2,
        "Time3" => 2,
        "Target3" => 2,
        "Time4" => 7200,
        "Target4" => 7200,
        "Time5" => 7201,
        "Target5" => 7200,
        "Time6" => 10000,
        "Target6" => 7200
    };

    // confirm that the duration cannot be less than 2 seconds.
    var powerInterval0 = new PowerIntervalMock(properties, 0, 1);
    Toybox.Test.assertEqualMessage(2, powerInterval0.getDuration(), "Duration expected to be 2.");
    var powerInterval1 = new PowerIntervalMock(properties, 1, 1);
    Toybox.Test.assertEqualMessage(2, powerInterval1.getDuration(), "Duration expected to be 2.");
    var powerInterval2 = new PowerIntervalMock(properties, 2, 1);
    Toybox.Test.assertEqualMessage(2, powerInterval2.getDuration(), "Duration expected to be 2.");
    var powerInterval3 = new PowerIntervalMock(properties, 3, 1);
    Toybox.Test.assertEqualMessage(2, powerInterval3.getDuration(), "Duration expected to be 2.");

    // confirm that the duration cannot be more than 7200 seconds.
    var powerInterval4 = new PowerIntervalMock(properties, 4, 1);
    Toybox.Test.assertEqualMessage(7200, powerInterval4.getDuration(), "Duration expected to be 7200.");
    var powerInterval5 = new PowerIntervalMock(properties, 5, 1);
    Toybox.Test.assertEqualMessage(7200, powerInterval5.getDuration(), "Duration expected to be 7200.");
    var powerInterval6 = new PowerIntervalMock(properties, 6, 1);
    Toybox.Test.assertEqualMessage(7200, powerInterval6.getDuration(), "Duration expected to be 7200.");

    return true;
}


(:test) // powerInterval initialization - duration display
function testPowerIntervalInitializeDurationDisplay(logger)
{
    // set the application properties for this test
    var properties = {
        "Time0" => 2,
        "Target0" => 100,
        "Time1" => 59,
        "Target1" => 200,
        "Time2" => 60,
        "Target2" => 300,
        "Time3" => 61,
        "Target3" => 400,
        "Time4" => 120,
        "Target4" => 500,
        "Time5" => 3599,
        "Target5" => 600,
        "Time6" => 3600,
        "Target6" => 700
    };

    // confirm that the duration displays correctly.
    var powerInterval0 = new PowerIntervalMock(properties, 0, 1);
    Toybox.Test.assertEqualMessage("2s", powerInterval0.getDurationText(), "Duration expected to be 2s.");
    var powerInterval1 = new PowerIntervalMock(properties, 1, 1);
    Toybox.Test.assertEqualMessage("59s", powerInterval1.getDurationText(), "Duration expected to be 59s.");
    var powerInterval2 = new PowerIntervalMock(properties, 2, 1);
    Toybox.Test.assertEqualMessage("1m", powerInterval2.getDurationText(), "Duration expected to be 1m.");
    var powerInterval3 = new PowerIntervalMock(properties, 3, 1);
    Toybox.Test.assertEqualMessage("1m", powerInterval3.getDurationText(), "Duration expected to be 1m.");
    var powerInterval4 = new PowerIntervalMock(properties, 4, 1);
    Toybox.Test.assertEqualMessage("2m", powerInterval4.getDurationText(), "Duration expected to be 2m.");
    var powerInterval5 = new PowerIntervalMock(properties, 5, 1);
    Toybox.Test.assertEqualMessage("59m", powerInterval5.getDurationText(), "Duration expected to be 59m.");
    var powerInterval6 = new PowerIntervalMock(properties, 6, 1);
    Toybox.Test.assertEqualMessage("1h", powerInterval6.getDurationText(), "Duration expected to be 1h.");

    return true;
}


(:test) // powerInterval update
function testPowerIntervalUpdate(logger)
{
    return true;
}


