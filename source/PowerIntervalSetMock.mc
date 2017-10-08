// mock wrapper for PowerInterval class

class PowerIntervalSetMock extends PowerIntervalSet
{


    function initialize(properties, numberOfFields)
    {
        var app = Application.getApp();
        app.setProperties(properties);
        PowerIntervalSet.initialize(numberOfFields);
    }

    // return the array of numbers
    function getNumbers()
    {
        return m_numbers;
    }

}
