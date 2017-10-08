using Toybox.System;

// confirm the value in the heart rate field.
function confirmHeartRateIs(view, value)
{
    var mHearts            = view.getHearts();
    Toybox.Test.assertEqualMessage(mHearts[0], value, "mHeart (" + mHearts[0] + ") is expected to be " + value);
    return true;
}

// confirm the value in a given power field.
function confirmPowerFieldIs(view, fieldIndex, value, logger)
{
    //logger.debug("confirmPowerFieldIs(view, fieldIndex=" + fieldIndex + ", value=" + value + ", logger)");
    switch(fieldIndex)
    {
        case 0:
            var mPower3s          = view.getPower3s();
            Toybox.Test.assertEqualMessage(mPower3s, value, "mPower3s (" + mPower3s + ") is expected to be " + value);
            break;
        case 1:
            var mPower30s         = view.getPower30s();
            Toybox.Test.assertEqualMessage(mPower30s, value, "mPower30s (" + mPower30s + ") is expected to be " + value);
            break;
        case 2:
            var mPower120s        = view.getPower120s();
            Toybox.Test.assertEqualMessage(mPower120s, value, "mPower120s (" + mPower120s + ") is expected to be " + value);
            break;
        case 3:
            var mPower300s        = view.getPower300s();
            Toybox.Test.assertEqualMessage(mPower300s, value, "mPower300s (" + mPower300s + ") is expected to be " + value);
            break;
        case 4:
            var mPower1200s       = view.getPower1200s();
            Toybox.Test.assertEqualMessage(mPower1200s, value, "mPower1200s (" + mPower1200s + ") is expected to be " + value);
            break;
        case 5:
            var mPower3600s       = view.getPower3600s();
            Toybox.Test.assertEqualMessage(mPower3600s, value, "mPower3600s (" + mPower3600s + ") is expected to be " + value);
            break;
        case 6:
            var mPower7200s       = view.getPower7200s();
            Toybox.Test.assertEqualMessage(mPower7200s, value, "mPower7200s (" + mPower7200s + ") is expected to be " + value);
            break;
        case 7:
            var mPeak3s           = view.getPeak3s();
            Toybox.Test.assertEqualMessage(mPeak3s, value, "mPeak3s (" + mPeak3s + ") is expected to be " + value);
            break;
        case 8:
            var mPeak30s          = view.getPeak30s();
            Toybox.Test.assertEqualMessage(mPeak30s, value, "mPeak30s (" + mPeak30s + ") is expected to be " + value);
            break;
        case 9:
            var mPeak120s         = view.getPeak120s();
            Toybox.Test.assertEqualMessage(mPeak120s, value, "mPeak120s (" + mPeak120s + ") is expected to be " + value);
            break;
        case 10:
            var mPeak300s         = view.getPeak300s();
            Toybox.Test.assertEqualMessage(mPeak300s, value, "mPeak300s (" + mPeak300s + ") is expected to be " + value);
            break;
        case 11:
            var mPeak1200s        = view.getPeak1200s();
            Toybox.Test.assertEqualMessage(mPeak1200s, value, "mPeak1200s (" + mPeak1200s + ") is expected to be " + value);
            break;
        case 12:
            var mPeak3600s        = view.getPeak3600s();
            Toybox.Test.assertEqualMessage(mPeak3600s, value, "mPeak3600s (" + mPeak3600s + ") is expected to be " + value);
            break;
        case 13:
            var mPeak7200s        = view.getPeak7200s();
            Toybox.Test.assertEqualMessage(mPeak7200s, value, "mPeak7200s (" + mPeak7200s + ") is expected to be " + value);
            break;
        default:
            Toybox.Test.assertMessage(false, "Invalid power index: " + fieldIndex);
    }
    return true;
}

// confirm all power fields are zero.
function confirmAllPowerFieldsAreZero(view, logger)
{
    for(var indx=0; indx < 14; indx++)
    {
        confirmPowerFieldIs(view, indx, 0, logger);
    }
    return true;
}

// confirm all fields are zero.  This can be called by multiple tests
function confirmAllFieldsAreZero(view, logger)
{
    confirmHeartRateIs(view, 0);
    confirmAllPowerFieldsAreZero(view, logger);
    return true;
}
