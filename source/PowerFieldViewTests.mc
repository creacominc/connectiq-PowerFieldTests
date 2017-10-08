using Toybox.System;
using Toybox.Math;


(:test)  // test the expectedAverage helper function.
function testExpectedAverage(logger)
{
    // test cases  [current step,  steps in this average]
    var testCases = [
                            [ 3, 3 ],
                            [ 4, 3 ],
                            [ 5, 3 ],
                            [ 1200, 3 ],
                            [ 3600, 3 ],
                            [ 7200, 3 ],
                            [ 30, 30 ],
                            [ 31, 30 ],
                            [ 32, 30 ],
                            [ 1200, 30 ],
                            [ 3600, 30 ],
                            [ 7200, 30 ],
                            [ 3600, 3600 ],
                            [ 3601, 3600 ],
                            [ 3602, 3600 ],
                            [ 7200, 3600 ],
                            [ 7200, 7200 ]
                        ];
    for( var indx = 0; indx < testCases.size(); indx++ )
    {
        var currentStep = testCases[indx][0];
        var stepsInThisAverage = testCases[indx][1];

        var expected = Math.floor(((2.0*currentStep) - stepsInThisAverage + 1.0)/2.0).toLong();
        var result = expectedAverage(currentStep, stepsInThisAverage, logger).toLong();
        Toybox.Test.assertEqualMessage(expected, result ,
                                        "expectedAverage (" + currentStep + ", " + stepsInThisAverage + ") is expected to be " + expected + " got: " + result);
    }
    return true;
}



(:test)  // all values should be zero on initialization.
function initialValuesAreZero(logger)
{
    var view = new PowerFieldViewMock();
    return confirmAllFieldsAreZero(view, logger);
}


(:test) // all values should be zero if the activity info does not provide heart rate or power even if the timer is running.
function computeDoesNothingIfNoInfo(logger)
{
    var activityInfoMockNoFields = new ActivityInfoMockNoFields();
    var view = new PowerFieldViewMock();
    view.onTimerStart(); //! mark the timer as started.
    view.compute(activityInfoMockNoFields);
    return confirmAllFieldsAreZero(view, logger);
}



(:test)  // all values should be zero if the timer has not started.
function computeDoesNothingIfNoTimer(logger)
{
    var activityInfoMockWithData = new ActivityInfoMockWithData();
    var view = new PowerFieldViewMock();
    view.compute(activityInfoMockWithData);
    return confirmAllFieldsAreZero(view, logger);
}



(:test)  // heart rate should provide data if the timer is running.
function computeHeartRateOnly(logger)
{
    var rcode = true;
    var activityInfoMockHeartDataOnly = new ActivityInfoMockHeartDataOnly();
    var view = new PowerFieldViewMock();
    // test once before the timer starts
    view.compute(activityInfoMockHeartDataOnly);
    rcode = rcode && confirmAllFieldsAreZero(view, logger);
    // start the timer
    view.onTimerStart(); //! mark the timer as started.
    // test again and you should get a heart rate.
    activityInfoMockHeartDataOnly.currentHeartRate = 142.0;
    view.compute(activityInfoMockHeartDataOnly);
    rcode = rcode && confirmHeartRateIs(view, 142.0)  && confirmAllPowerFieldsAreZero(view, logger);
    return rcode;
}


(:test)  // confirm caculation of power averages and peaks.
function computePowerAveragesAndPeaks(logger)
{
    var rcode = true;
    var activityInfoMockWithData = new ActivityInfoMockWithData();
    var view = new PowerFieldViewMock();
    // test once before the timer starts
    view.compute(activityInfoMockWithData);
    rcode = rcode && confirmAllFieldsAreZero(view, logger);
    // start the timer
    view.onTimerStart(); //! mark the timer as started.
    var sumOfPowers = 0;
    // The timers go up to 2 hours and count each second so we should send 60*60*2 updates.
    for(var step=1; step <= 60*60*2; step++)
    {
        //System.println("computePowerAveragesAndPeaks - step=" + step);
        activityInfoMockWithData.currentHeartRate = 121;
        activityInfoMockWithData.currentPower = step;
        view.compute(activityInfoMockWithData);
        confirmHeartRateIs(view, activityInfoMockWithData.currentHeartRate);

        //logger.debug("step=" + step);
        // confirm 3 second average
        if(step>3)
        {
            confirmPowerFieldIs(view, 0, expectedAverage(step, 3, logger), logger);
            confirmPowerFieldIs(view, 7, expectedAverage(step, 3, logger), logger);
        }
        if(false && step>30)
        {
            confirmPowerFieldIs(view, 1, expectedAverage(step, 30, logger), logger);
            confirmPowerFieldIs(view, 8, expectedAverage(step, 30, logger), logger);
        }
        if(false && step>120)
        {
            confirmPowerFieldIs(view, 2, expectedAverage(step, 120, logger), logger);
            confirmPowerFieldIs(view, 9, expectedAverage(step, 120, logger), logger);
        }
        if(false && step>300)
        {
            confirmPowerFieldIs(view, 3, expectedAverage(step, 300, logger), logger);
            confirmPowerFieldIs(view, 10, expectedAverage(step, 300, logger), logger);
        }
        if(false && step>1200)
        {
            confirmPowerFieldIs(view, 4, expectedAverage(step, 1200, logger), logger);
            confirmPowerFieldIs(view, 11, expectedAverage(step, 1200, logger), logger);
        }
        if(false && step>3600)
        {
            confirmPowerFieldIs(view, 5, expectedAverage(step, 3600, logger), logger);
            confirmPowerFieldIs(view, 12, expectedAverage(step, 3600, logger), logger);
        }
        if(false && step>7200)
        {
            confirmPowerFieldIs(view, 6, expectedAverage(step, 7200, logger), logger);
            confirmPowerFieldIs(view, 13, expectedAverage(step, 7200, logger), logger);
        }
    }
    return rcode;
}


