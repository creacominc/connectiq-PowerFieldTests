// tests for the power interval sets.ANIM_TYPE_EASE_IN


(:test) // powerIntervalSet initialize test.
function testPowerIntervalSetInitialize(logger)
{
    var numIntervals = 12;
    // set the properties for this test
    var properties = {
        "Time0" => 3,
        "Target0" => 923,
        "Time1" => 6,
        "Target1" => 549,
        "Time2" => numIntervals,
        "Target2" => 431
    };

    var powerIntervalSet = new PowerIntervalSetMock(properties, properties.size()/2);
    Toybox.Test.assertEqualMessage( (numIntervals+1), powerIntervalSet.getNumbers().size(), "numbers expected to be of size " + (numIntervals+1));
    return true;
}

/**
 * This is not so much a unit test as a debugging tool.
 * This test shows how the power values are stored and used.
 */
(:test) // powerIntervalSet update test.
function testPowerIntervalSetUpdate(logger)
{
    var numIntervals = 12;
    // set the properties for this test
    var properties = {
        "Time0" => 3,
        "Target0" => 31,
        "Time1" => numIntervals,
        "Target1" => 431
    };

    var powerIntervalSet = new PowerIntervalSetMock(properties, properties.size()/2);
    logger.debug(powerIntervalSet.getNumbers());

    // update through the time slots twice
    for(var lap=0; lap<2; lap++)
    {
        for(var curHead=0; curHead<numIntervals; curHead++)
        {
            var curPower = (((lap*numIntervals)+curHead+1) * 10);
            logger.debug("\n=======vvvvvvv current power = " + curPower);
            powerIntervalSet.update( curPower );
            logger.debug(powerIntervalSet.getNumbers());
            var interval = 0;
            logger.debug("=======        Average over " + powerIntervalSet.getDurationText(interval) + " = " + powerIntervalSet.getAverage(interval));
            interval = 1;
            logger.debug("=======^^^^^^^ Average over " + powerIntervalSet.getDurationText(interval) + " = " + powerIntervalSet.getAverage(interval));
        }
    }

    return true;
}

